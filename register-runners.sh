#!/bin/bash

# Register GitLab runners with a runner token

# Copyright (C) 2023 Peter Mosmans [Go Forward]
# SPDX-License-Identifier: GPL-3.0-or-later

# Usage: register-runners.sh TOKEN

# shellcheck disable=SC1091
source .env
set -u
token=$1
for runner in $(docker-compose ps|awk '/-runner/{print $1}'); do
echo "Trying to register runner on $runner"
docker exec -it "$runner" /bin/bash -c "/usr/bin/gitlab-runner register \
--non-interactive \
--url ${EXTERNAL_URL} \
--description $runner \
--docker-image docker:${DIND_VERSION} \
--docker-network-mode ${DEMO_NAME}-network \
--docker-privileged \
--docker-pull-policy if-not-present \
--docker-volumes /var/run/docker.sock:/var/run/docker.sock \
--executor docker \
--non-interactive \
--token ${token}"
done

