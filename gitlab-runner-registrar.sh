#!/bin/bash

# Ensure that all variables are defined
set -u

# Check if registration file already exists
while ! grep -q "runner on $HOSTNAME" /etc/gitlab-runner/config.toml; do
    echo "trying to register runner on $HOSTNAME"
    /usr/bin/gitlab-runner register \
                           --description "runner on $HOSTNAME" \
                           --docker-image "docker:{DIND_VERSION}" \
                           --docker-network-mode "${DEMO_NAME}-network" \
                           --docker-privileged \
                           --docker-pull-policy if-not-present \
                           --docker-volumes /var/run/docker.sock:/var/run/docker.sock \
                           --executor docker \
                           --non-interactive \
                           --registration-token "${REGISTRATION_TOKEN}" \
                           --url "${EXTERNAL_URL}"
    sleep 5
done
