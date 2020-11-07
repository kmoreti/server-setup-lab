#!/bin/bash

DOCKER_USER="kmserver"

apt-get update
apt-get upgrade -y

is_curl_installed=$(curl -V)

if [ -z "$is_curl_installed" ]
then
  apt-get install curl
  echo "Curl is installed successfully."
else
  echo "Curl is already installed."
fi

is_docker_installed=$(docker --version)

if [ -z "$is_docker_installed" ]
then
  docker/install-docker.sh $DOCKER_USER
  echo "Docker is installed successfully."
else
  echo "Docker is already installed."
fi

is_docker_compose_installed=$(docker-compose --version)

if [ -z "$is_docker_compose_installed" ]
then
  docker/install-docker-compose.sh
  echo "Docker-compose is installed successfully."
else
  echo "Docker-compose is already installed."
fi

