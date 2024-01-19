#!/bin/bash

# Register GitLab runners with a runner (group) token
# Part of https://github.com/PeterMosmans/gitlab-demolab
#
# Copyright (C) 2023-2024 Peter Mosmans [Go Forward]
# SPDX-License-Identifier: GPL-3.0-or-later

# Usage: register-runners.sh TOKEN

# shellcheck disable=SC1091
source .env
# Ensure that all variables are defined
set -u
token=$1

# Note that the hard-coded service name gitlab is being used
for runner in $(docker-compose ps | awk '/-runner/{print $1}'); do
  echo "Trying to register runner on $runner"
  docker exec -it "$runner" /bin/bash -c "/usr/bin/gitlab-runner register \
--non-interactive \
--url http://gitlab:${GITLAB_PORT} \
--clone-url http://gitlab:${GITLAB_PORT} \
--description $runner \
--docker-image docker:${DIND_VERSION} \
--docker-network-mode ${DEMO_NAME}-network \
--docker-privileged \
--docker-pull-policy if-not-present \
--docker-volumes /var/run/docker.sock:/var/run/docker.sock \
--docker-volumes ${RUNNER_VOLUME} \
--executor docker \
--non-interactive \
--token ${token}"
done
