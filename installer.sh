#!/usr/bin/env bash

# Start up Dependency-Track
# Part of https://github.com/PeterMosmans/gitlab-demolab
#
# Copyright (C) 2022-2024 Peter Mosmans [Go Forward]
# SPDX-License-Identifier: GPL-3.0-or-later

# When executing without parameters, only start GitLab
# The following arguments are recognized:
# all              Start (and configure) all services: GitLab, Dependency-Track and SonarQube
# sonarqube        Start (and configure) SonarQube
# dependency-track Start (and configure) Dependency-Track
# stop             Stop all services
# remove           Remove all services

set -u

COMPOSE=$(which docker-compose)
compose_file="docker-compose.yml"

# Check if there already is an .env file
if [[ ! -f .env ]]; then
  echo "No .env file found, copying env-example file to create one..."
  cp env-example .env
fi

# shellcheck disable=SC1091
source .env

if ! curl --version 1> /dev/null 2>&1; then
  echo "curl is not installed - unable to verify the hostnames or change initial passwords"
else
  for name in ${DTRACK_HOSTNAME} ${GITLAB_HOSTNAME} ${SONARQUBE_HOSTNAME}; do
    # Note that the port number doesn't matter - we're checking whether it can be resolved
    curl --silent "http://${name}:${GITLAB_PORT}/" --output /dev/null 1> /dev/null 2>&1
    exitcode=$?
    if ((exitcode == 6)); then
      echo "$name could not be resolved: Please check your hosts file or edit the .env file"
    fi
  done
fi

start_dependency-track() {
  # Check if this is the first time that this service is started
  configured=$(
    docker volume inspect "${DEMO_NAME}-dependency-track" 1> /dev/null 2>&1
    echo $?
  )
  echo "Starting Dependency-Track"
  "$COMPOSE" -f "$compose_file" up --detach dtrack-apiserver dtrack-frontend
  echo "Waiting on Dependency-Track to come up online..."
  while [[ $(
    "$COMPOSE" -f "$compose_file" logs dtrack-frontend 2> /dev/null | grep -q "Configuration complete"
    echo $?
  ) -ne 0 ]]; do
    sleep 1
  done
  if [[ $configured -ne 0 ]]; then
    echo "Changing default admin password to ${DTRACK_PASSWORD}"
    curl -d "username=admin" -d "password=admin" -d "newPassword=${DTRACK_PASSWORD}" -d "confirmPassword=${DTRACK_PASSWORD}" \
      "http://${DTRACK_HOSTNAME}:${DTRACK_API_PORT}/api/v1/user/forceChangePassword"
  fi
  echo "You now can log in to Dependency-Track at http://${DTRACK_HOSTNAME}:${DTRACK_FRONTEND_PORT} as admin using password ${DTRACK_PASSWORD}"
}

start_gitlab() {
  echo "Starting GitLab"
  "$COMPOSE" -f "$compose_file" up --detach gitlab gitlab-runner-1 gitlab-runner-2
}

start_sonarqube() {
  # Check if this is the first time that this service is started
  configured=$(
    docker volume inspect "${DEMO_NAME}-sonarqube_config" 1> /dev/null 2>&1
    echo $?
  )
  echo "Starting SonarQube"
  "$COMPOSE" -f "$compose_file" up --detach sonarqube
  echo "Waiting on SonarQube to come up online..."
  while [[ $(
    "$COMPOSE" -f "$compose_file" logs sonarqube 2> /dev/null | grep -q "SonarQube is operational"
    echo $?
  ) -ne 0 ]]; do
    sleep 1
  done
  if [[ $configured -ne 0 ]]; then
    echo "Changing default admin password to ${SONARQUBE_PASSWORD}"
    curl -u admin:admin -X POST "http://${SONARQUBE_HOSTNAME}:${SONARQUBE_PORT}/api/users/change_password?login=admin&previousPassword=admin&password=${SONARQUBE_PASSWORD}"
  fi
  echo "You now can log in to SonarQube at http://${SONARQUBE_HOSTNAME}:${SONARQUBE_PORT} as admin using password ${SONARQUBE_PASSWORD}"
}

# Check if a parameter has been passed
if [[ $# -ne 0 ]]; then
  if [[ $1 == stop ]]; then
    echo "Stopping all services..."
    "$COMPOSE" -f "$compose_file" stop
    exit 0
  fi
  if [[ $1 == sonarqube ]] || [[ $1 == all ]]; then
    start_sonarqube
  fi
  if [[ $1 == dependency-track ]] || [[ $1 == all ]]; then
    start_dependency-track
  fi
  if [[ $1 == remove ]]; then
    echo "Removing all services..."
    "$COMPOSE" -f "$compose_file" down
    exit 0
  fi
fi

start_gitlab

echo "Waiting for GitLab to come up online..."
while [[ $(
  "$COMPOSE" -f "$compose_file" logs gitlab 2> /dev/null | grep -q "Server initialized"
  echo $?
) -ne 0 ]]; do
  sleep 1
done

echo "You can now log in to GitLab at http://${GITLAB_HOSTNAME}:${GITLAB_PORT} as root using password ${GITLAB_PASSWORD}"
echo "If you haven't done already: Don't forget to create a runner token and register the runners manually"
echo "Usage: ./register-runners.sh TOKEN"
