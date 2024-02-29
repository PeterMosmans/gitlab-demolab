# GitLab Demolab

This repository contains all files to automatically configure and set up a local
demo environment, consisting of a CI/CD GitLab server and multiple
(Docker-in-Docker) GitLab runners. Optionally, SonarQube as well as
Dependency-Track can be configured and set up as well.

## Prerequisites

Have `curl`, `docker`, and `docker-compose` installed.

## Usage

```console
./installer.sh
```

This will fire up an instance of GitLab and two GitLab runners, capable of
performing Docker-in-Docker commands.

All variables are stored in an `.env` file: The `.env` file itself not supplied
in this repository, but an example is. If you don't create an `.env` file before
using the installer, it will automatically copy and use the `env-example` file
for you.

Then, you\'ll need to register the (group of) runners with a valid runner token,
which needs to be created manually: In GitLab, go to the Admin Area / Dashboard,
click on Shared Runners, and click on New instance runner
(`/admin/runners/new`). Select \"Run untagged jobs\" and click on Create runner.
This will generate a new runner token. Copy the token.

Lastly, execute the `register-runners.sh` script with that token as parameter.
This script will register all runners that are up and running.

## Starting and configuring SonarQube

```console
./installer.sh sonarqube
```

## Starting and configuring Dependency-Track

```console
./installer.sh dependency-track
```

## Stopping / pausing the demolab

```console
./installer.sh stop
```

## Removing the demolab

```console
docker-compose down
```

By default all data, configuration and logs will be stored in persistent Docker
volumes. They will remain, even if you stop or remove the Docker containers. To
clean everything up, remove the containers including named volumes.

```console
docker-compose down --remove-orphans --volumes
```

Please note that this is a lab setup - and not meant to be used in production in
any way. All services only bind / listen to `127.0.0.1` by default (this can be
changed in the file `docker-compose`.

Furthermore all runners share one named Docker volume as cache under
`/srv/cache`. This named volume will be initialized by default, and has lax
permissions (to ensure all tools can work with it).

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

`SONARQUBE_HOSTNAME` defines the hostname that will be used to access SonarQube.
Please note that this name needs to be resolved, see the remarks at the bottom
of this page.

`SONARQUBE_PASSWORD` defines the initial password for user `admin`.

`SONARQUBE_PLUGINS` defines a space-delimited list of SonarQube plugins that
will be installed at first startup.

`SONARQUBE_PORT` defines the port number on which the web interface of SonarQube
will be accessible.

`SONARQUBE_VERSION` allows you to specify which SonarQube image you would like
to use.

**Important!**

The GITLAB_PASSWORD needs to be complex, otherwise installation will fail, see
<https://about.gitlab.com/handbook/security/password-standard.html>.

If you want to access the web interfaces using \"pretty host names\" that are
defined using `GITLAB_HOSTNAME` and `SONARQUBE_HOSTNAME` (instead of
`localhost`), then make sure that they can be resolved by your browser. This can
be done for instance by adding them to your local `hosts` file.

# Copyright / License

Great that you're using this code, hopefully you find it useful! All that I'm
asking is that you properly attribute the author (Peter Mosmans), and respect
the [GPLv3 license](LICENSE).
