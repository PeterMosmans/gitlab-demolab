#!/usr/bin/env bash

# Start up demo lab

# Copyright (C) 2023 Peter Mosmans [Go Forward]
# SPDX-License-Identifier: GPL-3.0-or-later

set -e

COMPOSE=$(which docker-compose)
compose_file="docker-compose.yml"

# shellcheck disable=SC1091
source .env

echo "Starting the services"
sudo "$COMPOSE" -f "$compose_file" up --detach

echo "Waiting on SonarQube to come up online"
while [[ $(sudo "$COMPOSE" -f "$compose_file" logs sonarqube 2>/dev/null | grep -q "SonarQube is operational"; echo $?) -ne 0 ]]; do
    sleep 1
done
echo "Changing default admin password to ${SONARQUBE_PASSWORD}"
curl -u admin:admin -X POST "http://localhost:${SONARQUBE_PORT}/api/users/change_password?login=admin&previousPassword=admin&password=${SONARQUBE_PASSWORD}"
echo "You now can log in to SonarQube at http://localhost:${SONARQUBE_PORT}"
echo "Waiting for GitLab to start up..."
while [[ $(sudo "$COMPOSE" -f "$compose_file" logs gitlab 2>/dev/null | grep -q "Server initialized"; echo $?) -ne 0 ]]; do
    sleep 1
done
echo "You can now log in to GitLab at ${EXTERNAL_URL}"

