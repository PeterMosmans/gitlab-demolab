#!/usr/bin/env bash

# Start up demo lab
# Part of https://github.com/PeterMosmans/gitlab-demolab
#
# Copyright (C) 2022-2024 Peter Mosmans [Go Forward]
# SPDX-License-Identifier: GPL-3.0-or-later

# As soon as we encounter an error, stop
set -e

COMPOSE=$(which docker-compose)
compose_file="docker-compose.yml"

# Check if there already is an .env file
if [[ ! -f .env ]]; then
  echo "No .env file found, copying env-example file to create one..."
  cp env-example .env
fi

# shellcheck disable=SC1091
source .env

if curl --version 1> /dev/null 2>&1; then
  echo "curl is installed: checking whether hostnames can be resolved"
  set +e
  for name in ${GITLAB_HOSTNAME} ${SONARQUBE_HOSTNAME}; do
    # Note that the port number doesn't matter - we're checking whether it can be resolved
    curl --silent "http://${name}:${GITLAB_PORT}/" --output /dev/null
    exitcode=$?
    if ((exitcode == 6)); then
      echo "$name could not be resolved: Please check your hosts file or edit the .env file"
      exit 0
    else
      echo "$name successfully resolved"
    fi
  done
else
  echo "curl is not installed - unable to verify the hostnames"
fi

echo "Starting the services"
sudo "$COMPOSE" -f "$compose_file" up --detach

echo "Waiting on SonarQube to come up online"
while [[ $(
  sudo "$COMPOSE" -f "$compose_file" logs sonarqube 2> /dev/null | grep -q "SonarQube is operational"
  echo $?
) -ne 0 ]]; do
  sleep 1
done
echo "Changing default admin password to ${SONARQUBE_PASSWORD}"
curl -u admin:admin -X POST "http://${SONARQUBE_HOSTNAME}:${SONARQUBE_PORT}/api/users/change_password?login=admin&previousPassword=admin&password=${SONARQUBE_PASSWORD}"
echo "You now can log in to SonarQube at http://${SONARQUBE_HOSTNAME}:${SONARQUBE_PORT} as admin using password ${SONARQUBE_PASSWORD}"

echo "Waiting for GitLab to start up..."
while [[ $(
  sudo "$COMPOSE" -f "$compose_file" logs gitlab 2> /dev/null | grep -q "Server initialized"
  echo $?
) -ne 0 ]]; do
  sleep 1
done
echo "You can now log in to GitLab at http://${GITLAB_HOSTNAME}:${GITLAB_PORT} as root using password ${GITLAB_PASSWORD}"
echo "Don't forget to create a runner token and register all runners manually"
echo "Usage: ./register-runners.sh TOKEN"
