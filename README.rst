##############
GitLab Demolab
##############

This repository contains all files to set up a local network, consisting of a
CI/CD GitLab server, and a (docker-in-docker compatible) GitLab runner.

All variables are stored in an ``.env`` file:

::

   DEMO_NAME=my-demo
   EXTERNAL_URL=http://gitlab:8080/
   HTTP_PORT=8080
   INITIAL_ROOT_PASSWORD=the-initial-password-for-user-root
   REGISTRATION_TOKEN=a-random-token-to-register-gitlab-runners
   SSH_PORT=7722

The ``.env`` file is not supplied in this repository. To quickly get started,
copy the file ``env-example`` file to ``.env``, edit the values, and you're good
to go.

The ``DEMO_NAME`` allows you to run multiple instances of this demo on the same
machine, as it will generate its own "Docker namespace".

The ``HTTP_PORT`` specifies on which port the GitLab webinterface can be
accessed.

The ``SSH`` port is the SSH port for GitLab.

If you want to access the webinterface, make sure that the ``EXTERNAL_URL`` can
be resolved by your browser. If you choose any other value than ``localhost``,
make sure that the hostname can be resolved (e.g. by adding it to the ``hosts``
file).

Prerequisites
=============

Have ``docker`` and ``docker-compose`` installed.

.. code-block:: console

   cp env-example .env

   # Edit the values in .env

   docker-compose up --detach

This will fire up an instance of GitLab, and a GitLab runner, capable of
performing Docker-in-Docker commands. The registration of the GitLab runner will
be performed automatically.

Stopping / pausing the demolab
==============================

.. code-block:: console

   docker-compose stop

By default all data, configuration and logs will be stored in persistent Docker
volumes. They will remain, even if you stop or remove the Docker containers.
To clean everything up, remove the containers by hand.

.. code-block:: console

   docker-compose rm
   source .env
   docker volume rm ${DEMO_NAME}-gitlab_{config,data,logs,runner_config}


Please note that this is a lab setup - and not meant to be used in production in
any way.
