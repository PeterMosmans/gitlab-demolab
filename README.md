# GitLab Demolab

This repository contains all files to set up a local network, consisting of a
CI/CD GitLab server and multiple (docker-in-docker compatible) GitLab runners.
Optionally, SonarQube as well as Dependency-Track can be set up.

## Prerequisites

Have `docker` and `docker-compose` installed.

## Usage

All variables are stored in an `.env` file: The `.env` file itself not supplied
in this repository, but an example is: To quickly get started, copy the file
`env-example` file to `.env`, edit the values (especially the SonarQube and
GitLab passwords), make sure that `gitlab` resolves to localhost, and you\'re
good to go.

If you don't create an `.env` file before using the installer, it will
automatically copy and use the `env-example` file for you.

```console
./installer.sh
```

This will fire up an instance of GitLab, and three GitLab runners, capable of
performing Docker-in-Docker commands.

Then, you\'ll need to register the (group of) runners with a valid runner token,
which needs to be created manually: Go to the Admin Area / Dashboard, click on
Shared Runners, and click on New instance runner (`/admin/runners/new`). Select
\"Run untagged jobs\" and click on Create runner. This will generate a new
runner token. Copy the token.

Lastly, execute the `register-runners.sh` script with that token as parameter.
This script will register all runners that are up and running.

## Starting SonarQube

```console
./installer.sh sonarqube
```

## Starting Dependency-Track

```console
./installer.sh dtrack
```

## Stopping / pausing the demolab

```console
./installer.sh stop
```

## Removing the demolab

```console
./installer.sh down
```

By default all data, configuration and logs will be stored in persistent Docker
volumes. They will remain, even if you stop or remove the Docker containers. To
clean everything up, remove the containers including named volumes.

```console
docker-compose down --remove-orphans --volumes
```

Please note that this is a lab setup - and not meant to be used in production in
any way. All services only bind / listen to `127.0.0.1` by default (this can be
changed in the file `docker-compose`

## Variables

The `DEMO_NAME` allows you to run multiple instances of this demo on the same
machine, as it will generate its own \"Docker namespace\".

`DIND_VERSION` defines the Docker-in-Docker image tag being used.

`DTRACK_API_PORT` defines the port number of the Dependency-Track API interface.

`DTRACK_API_VERSION` defines the Dependency-Track API image tag.

`DTRACK_FRONTEND_PORT` defines the port number on which the web interface of
Dependency-Track will be accessible.

`DTRACK_FRONTEND_VERSION` defines the Dependency-Track frontend image tag.

`GITLAB_HOSTNAME` defines the hostname that will be used to access GitLab.
Please note that this name needs to be resolved, see the remarks at the bottom
of this page.

`GITLAB_PASSWORD` defines the initial password for user `root`.

`GITLAB_PORT` defines the port number on which the web interface of GitLab will
be accessible.

`GITLAB_SSH` defines the SSH port number for GitLab.

`GITLAB_VERSION` defines the GitLab image tag being used. Please note that the
runners always use the latest version.

`RUNNER_VOLUME` defines an extra (named) Docker volume that will be available
for all runners. By default this is set to create / use a shared volume to store
OWASP Dependency Check data on.

`SONARQUBE_HOSTNAME` defines the hostname that will be used to access SonarQube.
Please note that this name needs to be resolved, see the remarks at the bottom
of this page.

`SONARQUBE_PASSWORD` defines the initial password for user `admin`.

`SONARQUBE_PORT` defines the port number on which the web interface of SonarQube
will be accessible.

`SONARQUBE_VERSION` allows you to specify which SonarQube image you would like
to use.

**Important!**

If you want to access the web interfaces using \"pretty host names\" that are
defined using `GITLAB_HOSTNAME` and `SONARQUBE_HOSTNAME` (instead of
`localhost`), then make sure that they can be resolved by your browser. This can
be done for instance by adding them to your local `hosts` file.

Note that the GITLAB_PASSWORD needs to be complex, otherwise
installation will fail, see
<https://about.gitlab.com/handbook/security/password-standard.html>

# Copyright / License

Great that you're using this code, hopefully you find it useful! All that I'm
asking is that you properly attribute the author (Peter Mosmans), and respect
the [GPLv3 license](LICENSE).
