#!/usr/bin/env bash
# Copyright (C) 2022-2024 Peter Mosmans [Go Forward]
# SPDX-License-Identifier: GPL-3.0-or-later

# Start up GitLab and several demo services.
# Part of https://github.com/PeterMosmans/gitlab-demolab

# When executing without parameters, only start (and configure) GitLab
# The following arguments are recognized:
# all              Start (and configure) all services: GitLab, Dependency-Track and SonarQube
# sonarqube        Start (and configure) SonarQube
# dependency-track Start (and configure) Dependency-Track
# stop             Stop all services

set -u

COL_BOLD="\033[1m"
COL_GREEN="\033[32m"
COL_RED="\033[0;31m"
COL_RESET="\033[0m"
COL_YELLOW="\033[0;33m"

COMPOSE=$(which docker-compose)
compose_file="docker-compose.yml"

setup() {
  # Check if there already is an .env file
  if [[ ! -f .env ]]; then
    echo -e "No ${COL_BOLD}.env${COL_RESET} file found, copying env-example file to create one ... "
    cp env-example .env
    echo -e "${COL_GREEN}Default .env file created${COL_RESET}"
  else
    echo -e "${COL_GREEN}Found existing .env file${COL_RESET}"
  fi

  # shellcheck disable=SC1091
  source .env
}

validate_hostnames() {
  if ! curl --version 1> /dev/null 2>&1; then
    echo -e "${COL_RED}curl is not installed - unable to verify the hostnames or change initial passwords${COL_RESET}"
    echo -e "Please install ${COL_BOLD}curl${COL_RESET} to prevent configuration issues"
  else
    for name in ${DTRACK_HOSTNAME} ${GITLAB_HOSTNAME} ${SONARQUBE_HOSTNAME}; do
      # Note that the port number doesn't matter - we're checking whether it can be resolved
      curl --silent "http://${name}:${GITLAB_PORT}/" --output /dev/null 1> /dev/null 2>&1
      exitcode=$?
      if ((exitcode == 6)); then
        echo -e "${COL_RED}$name could not be resolved${COL_RESET}: Please check your hosts file or edit the .env file"
      fi
    done
  fi
}

wait_for_gitlab() {
  echo -n "Waiting on GitLab to initialize ... "
  while [[ $(
    "$COMPOSE" -f "$compose_file" logs gitlab 2> /dev/null | grep -q "Server initialized"
    echo $?
  ) -ne 0 ]]; do
    sleep 1
  done
  echo -e "${COL_GREEN}done${COL_RESET}"
  echo -n "Waiting on GitLab to come up online ... "
  while [[ $(curl --silent -o /dev/null -w '%{http_code}\n' -X HEAD "http://${GITLAB_HOSTNAME}:${GITLAB_PORT}/users/sign_in") -ne 200 ]]; do
    sleep 1
  done
  echo -e "${COL_GREEN}done${COL_RESET}"
  echo -e "You can now log in to GitLab at ${COL_BOLD}http://${GITLAB_HOSTNAME}:${GITLAB_PORT}${COL_RESET} as ${COL_BOLD}root${COL_RESET} using password ${COL_BOLD}${GITLAB_PASSWORD}${COL_RESET}"
  echo "If you haven't done already: Don't forget to create a runner token and register the runners manually"
  echo "Usage: ./register-runners.sh TOKEN"
}

start_dependency-track() {
  echo -e "Starting ${COL_BOLD}Dependency-Track${COL_RESET}"
  "$COMPOSE" -f "$compose_file" up --detach dtrack-apiserver dtrack-frontend
  echo -n "Waiting on Dependency-Track to come up online ... "
  while [[ $(
    "$COMPOSE" -f "$compose_file" logs dtrack-frontend 2> /dev/null | grep -q "Configuration complete"
    echo $?
  ) -ne 0 ]]; do
    sleep 1
  done
  echo -e "${COL_GREEN}done${COL_RESET}"
  status_code=$(curl --silent -o /dev/null -w '%{http_code}\n' -d "username=admin" -d "password=admin" -d "newPassword=${DTRACK_PASSWORD}" -d "confirmPassword=${DTRACK_PASSWORD}" \
    "http://${DTRACK_HOSTNAME}:${DTRACK_API_PORT}/api/v1/user/forceChangePassword")
  if [ "$status_code" -eq 200 ]; then
    echo -e "Changed default ${COL_BOLD}admin${COL_RESET} password to ${COL_BOLD}${DTRACK_PASSWORD}${COL_RESET}"
  fi
  echo -e "You now can log in to Dependency-Track at ${COL_BOLD}http://${DTRACK_HOSTNAME}:${DTRACK_FRONTEND_PORT}${COL_RESET}"
}

start_gitlab() {
  echo -e "Starting ${COL_BOLD}GitLab${COL_RESET}"
  "$COMPOSE" -f "$compose_file" up --detach gitlab gitlab-runner-1 gitlab-runner-2
}

configure_sonarqube() {
  status_code=$(curl --silent -o /dev/null -w '%{http_code}\n' -u admin:admin -X POST "http://${SONARQUBE_HOSTNAME}:${SONARQUBE_PORT}/api/users/change_password?login=admin&previousPassword=admin&password=${SONARQUBE_PASSWORD}")
  if [ "$status_code" -eq 204 ]; then
    echo -e "Changed the default ${COL_BOLD}admin${COL_RESET} password to ${SONARQUBE_PASSWORD}"
    echo "Installing the following plugins: ${SONARQUBE_PLUGINS}"
    # shellcheck disable=SC2140
    "$COMPOSE" -f "$compose_file" exec sonarqube /bin/bash -c "for plugin in ${SONARQUBE_PLUGINS}; do curl --output-dir /opt/sonarqube/extensions/plugins/ -LO "\$plugin"; done"
    echo "Restarting SonarQube"
    "$COMPOSE" -f "$compose_file" restart sonarqube
  fi
}

start_sonarqube() {
  echo -e "Starting ${COL_BOLD}SonarQube${COL_RESET}"
  "$COMPOSE" -f "$compose_file" up --detach sonarqube
  echo -n "Waiting on SonarQube to come up online ... "
  while [[ $(
    "$COMPOSE" -f "$compose_file" logs sonarqube 2> /dev/null | grep -q "SonarQube is operational"
    echo $?
  ) -ne 0 ]]; do
    sleep 1
  done
  echo -e "${COL_GREEN}done${COL_RESET}"
  configure_sonarqube
  echo -e "You now can log in to SonarQube at ${COL_BOLD}http://${SONARQUBE_HOSTNAME}:${SONARQUBE_PORT}${COL_RESET}"
}

# Fix permissions on named volume: We want all tools to be able to use it
fix_permissions() {
  docker run --rm -it -v "${DEMO_NAME}-runner_cache:/srv/cache:z" busybox /bin/sh -c "chmod o+rwx /srv/cache/"
}

# Stop all services and exit
stop_services() {
  echo "Stopping all services"
  "$COMPOSE" -f "$compose_file" stop
  exit 0
}

(($# > 0)) && [[ $1 == stop ]] && stop_services
if (($# > 0)) && [[ $1 != all ]] && [[ $1 != dependency-track ]] && [[ $1 != sonarqube ]]; then
  echo -e "${COL_RED}Unknown option${COL_RESET} - this program only understands the following options:"
  echo "(no options)       Start GitLab"
  echo -e "${COL_YELLOW}dependency-track${COL_RESET}   Start Dependency-Track (and GitLab)"
  echo -e "${COL_YELLOW}sonarqube${COL_RESET}          Start SonarQube (and GitLab)"
  echo -e "${COL_YELLOW}all${COL_RESET}                Start Dependency-Track, SonarQube, and GitLab"
  echo -e "${COL_YELLOW}stop${COL_RESET}               Stop all started services"
  exit 1
fi

setup
validate_hostnames
start_gitlab
if (($# > 0)); then
  [[ $1 == all ]] || [[ $1 == dependency-track ]] && start_dependency-track
  [[ $1 == all ]] || [[ $1 == sonarqube ]] && start_sonarqube
fi
fix_permissions
wait_for_gitlab
