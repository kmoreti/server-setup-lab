#!/bin/bash

HOME_DIRECTORY=$(getent passwd "$(logname)" | cut -d: -f6)
export KUBE_API_SERVER="/tmp/kube-apiserver"
export KUBE_CONTROLLER_MANAGER="/tmp/kube-controller-manager"
export KUBE_SCHEDULER="/tmp/kube-scheduler"
export KUBE_CTL="/tmp/kubectl"

apt-get update
apt-get upgrade -y

setup-ssh-key/generate-ssh-key.sh

is_curl_installed=$(curl -V)

if [ -z "$is_curl_installed" ]
then
  echo "Installing curl..."
  apt-get install curl
  echo "Curl is installed successfully."
else
  echo "Curl is already installed."
fi

if [[ ! -f "$KUBE_API_SERVER" || ! -f "$KUBE_CONTROLLER_MANAGER" || ! -f "$KUBE_SCHEDULER" || ! -f "$KUBE_CTL" ]]
then
  echo "Downloading kubernetes binaries..."
  setup-kubernetes-lab/kubernetes/download-kubernetes-binaries.sh
  echo "Download of kubernetes binaries has finished..."
fi

is_docker_installed=$(docker --version)

if [ -z "$is_docker_installed" ]
then
  echo "Installing docker..."
  docker/install-docker.sh
  echo "Docker is installed successfully."
else
  echo "Docker is already installed."
fi

is_docker_compose_installed=$(docker-compose --version)

if [ -z "$is_docker_compose_installed" ]
then
  echo "Installing docker-compose..."
  docker/install-docker-compose.sh
  echo "Docker-compose is installed successfully."
else
  echo "Docker-compose is already installed."
fi

is_kubectl_installed=$(kubectl version --client)

if [ -z "$is_kubectl_installed" ]
then
  echo "Installing kubectl..."
  setup-kubernetes-lab/install-kubectl.sh
  echo "Kubectl is installed successfully."
else
  echo "Kubectl is already installed."
fi

if [ ! -d "ca-and-tls/certificates/" ]
then
  echo "Creating certificates..."
  ca-and-tls/create-certificates.sh
  echo "Certificates has been created."
else
  echo "Certificates already created."
fi

if [ ! -d "$HOME_DIRECTORY/registry-lab" ]
then
  echo "Cloning registry-lab..."
  setup-registry-lab/clone-registry-lab.sh "$HOME_DIRECTORY"
  echo "registry-lab has been cloned."
  echo "Starting registry..."
  setup-registry-lab/start-registry.sh "$HOME_DIRECTORY"
  echo "Registry has been started."
fi

if [ ! -d "$HOME_DIRECTORY/kubernetes-lab" ]
then

  is_virtualbox_installed=$(virtualbox --help | head -n 1 | awk '{print $NF}' 2>/dev/null)

  if [ -z "$is_virtualbox_installed" ]
  then
    echo "Installing Virtualbox..."
    setup-kubernetes-lab/install-virtualbox.sh
    echo "Virtualbox installation has finished."
  fi

  is_vagrant_installed=$(vagrant --version 2>/dev/null)

  if [ -z "$is_vagrant_installed" ]
  then
    echo "Installing Vagrant..."
    setup-kubernetes-lab/install-vagrant.sh
    echo "Vagrant installation has finished."
  fi

  echo "Cloning kubernetes-lab..."
  setup-kubernetes-lab/clone-kubernetes-lab.sh "$HOME_DIRECTORY"
  echo "kubernetes-lab has been cloned."
  echo "Copying certificates to kubernetes-lab..."
  ca-and-tls/copy-certificates.sh "$HOME_DIRECTORY"
  echo "Certificates have been copied to kubernetes-lab."
  echo "Copying kube-config files to kubernetes-lab..."
  setup-kubernetes-lab/kubernetes/copy-kube-config.sh "$HOME_DIRECTORY"
  echo "kube-config files have been copied to kubernetes-lab."
  echo "Generating encryption config..."
  setup-kubernetes-lab/kubernetes/generate-encryption-config.sh "$HOME_DIRECTORY"
  echo "Encryption config has been created."
  echo "Setting up kubernetes-lab environment..."
  setup-kubernetes-lab/setup-kubernetes-lab-environment.sh "$HOME_DIRECTORY"
  echo "kubernetes-lab environment setup has finished."
fi

