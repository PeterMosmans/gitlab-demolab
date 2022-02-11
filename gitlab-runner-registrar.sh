#!/bin/bash

# Ensure that all variables are defined
set -u

# Check if registration file already exists
while ! grep -q 'default runner' /etc/gitlab-runner/config.toml; do
    echo "trying to register default runner"
    /usr/bin/gitlab-runner register \
                           --description "default runner" \
                           --docker-image "docker:20.10.12" \
                           --docker-network-mode "gitlab-demolab-network" \
                           --docker-privileged \
                           --docker-pull-policy if-not-present \
                           --docker-volumes /var/run/docker.sock:/var/run/docker.sock \
                           --executor docker \
                           --non-interactive \
                           --registration-token "${REGISTRATION_TOKEN}" \
                           --url "${EXTERNAL_URL}"
    sleep 5
done
