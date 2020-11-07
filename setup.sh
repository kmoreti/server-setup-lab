#!/bin/bash

DOCKER_USER="kmserver"

apt-get update
apt-get upgrade -y

docker/install-docker.sh $DOCKER_USER

