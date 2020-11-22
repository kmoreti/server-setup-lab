#!/bin/bash

HOME_DIRECTORY=$(getent passwd "$(logname)" | cut -d: -f6)

apt-get update
apt-get upgrade -y

setup-ssh-key/generate-ssh-key.sh

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
  docker/install-docker.sh
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

is_kubectl_installed=$(kubectl version --client)

if [ -z "$is_kubectl_installed" ]
then
  setup-kubernetes-lab/install-kubectl.sh
  echo "Kubectl is installed successfully."
else
  echo "Kubectl is already installed."
fi

if [ ! -d "ca-and-tls/certificates/" ]
then
  echo "Creating certificates."
  ca-and-tls/create-certificates.sh
else
  echo "Certificates already created."
fi

if [ ! -d "$HOME_DIRECTORY/registry-lab" ]
then
  setup-registry-lab/clone-registry-lab.sh "$HOME_DIRECTORY"
  setup-registry-lab/start-registry.sh "$HOME_DIRECTORY"
fi

if [ ! -d "$HOME_DIRECTORY/kubernetes-lab" ]
then

  is_virtualbox_installed=$(virtualbox --help | head -n 1 | awk '{print $NF}' 2>/dev/null)

  if [ -z "$is_virtualbox_installed" ]
  then
    setup-kubernetes-lab/install-virtualbox.sh
  fi

  is_vagrant_installed=$(vagrant --version 2>/dev/null)

  if [ -z "$is_vagrant_installed" ]
  then
    setup-kubernetes-lab/install-vagrant.sh
  fi

  setup-kubernetes-lab/clone-kubernetes-lab.sh "$HOME_DIRECTORY"
  setup-kubernetes-lab/setup-kubernetes-lab-environment.sh "$HOME_DIRECTORY"

fi