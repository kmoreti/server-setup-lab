#!/bin/bash

DOCKER_USER="kmserver"

apt-get update
apt-get upgrade -y

is_docker_installed=$(docker --version)

if [ -z "$is_docker_installed" ]
then
  docker/install-docker.sh $DOCKER_USER
  echo "Docker is installed successfully."
else
  echo "Docker is already installed."
fi

