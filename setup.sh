#!/bin/bash

export HOME_DIRECTORY=$(getent passwd "$(logname)" | cut -d: -f6)
export PROJECT="$HOME_DIRECTORY/server-setup-lab"
export KUBE_API_SERVER="/tmp/kube-apiserver"
export KUBE_CONTROLLER_MANAGER="/tmp/kube-controller-manager"
export KUBE_SCHEDULER="/tmp/kube-scheduler"
export KUBE_CTL="/tmp/kubectl"
export KUBE_PROXY="/tmp/kube-proxy"
export KUBELET="/tmp/kubelet"
export ETCD="/tmp/etcd.tar.gz"
export CNI_PLUGINS="/tmp/cni-plugins.tgz"
export LAB_KUBERNETES_CONFIG_DIR="$HOME_DIRECTORY"/kubernetes-lab/Vagrant/ubuntu/kubernetes/config
export CERT_DIR="ca-and-tls/certificates"
export SSL_CONF_DIR="ca-and-tls/config"
export LOADBALANCER_ADDRESS=192.168.5.30

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

if [[ ! -f "$KUBE_API_SERVER" || ! -f "$KUBE_CONTROLLER_MANAGER" || ! -f "$KUBE_SCHEDULER" || ! -f "$KUBE_CTL" || ! -f "$KUBE_PROXY" || ! -f "$KUBELET" ]]
then
  echo "Downloading kubernetes binaries..."
  setup-kubernetes-lab/kubernetes/download-kubernetes-binaries.sh
  echo "The download of kubernetes binaries has finished."
fi

if [[ ! -f "$ETCD" ]]
then
  echo "Downloading etcd..."
  setup-kubernetes-lab/kubernetes/etcd/download-etcd.sh
  echo "The download of etcd has finished."
fi

if [[ ! -f "$CNI_PLUGINS" ]]
then
  echo "Downloading cni plugins..."
  setup-kubernetes-lab/kubernetes/plugins/download-cni-plugins.sh
  echo "The download of cni plugins has finished."
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
  setup-kubernetes-lab/clone-kubernetes-lab.sh
  echo "kubernetes-lab has been cloned."
  echo "Copying certificates to kubernetes-lab..."
  ca-and-tls/copy-certificates.sh
  echo "Certificates have been copied to kubernetes-lab."
  echo "Creating admin config..."
  setup-kubernetes-lab/kubernetes/create-admin-config.sh
  echo "Admin config has been created."
  echo "Creating controller manager config..."
  setup-kubernetes-lab/kubernetes/create-controller-manager-config.sh
  echo "Controller manager config has been created."
  echo "Creating scheduler config..."
  setup-kubernetes-lab/kubernetes/create-scheduler-config.sh
  echo "Scheduler config has been created."
  echo "Creating proxy config..."
  setup-kubernetes-lab/kubernetes/create-proxy-config.sh
  echo "Proxy config has been created."
  echo "Creating worker-1 config..."
  setup-kubernetes-lab/kubernetes/create-worker-1-config.sh
  echo "Worker-1 config has been created."
  echo "Generating encryption config..."
  setup-kubernetes-lab/kubernetes/generate-encryption-config.sh
  echo "Encryption config has been created."
  echo "Configuring client kubectl..."
  setup-kubernetes-lab/kubernetes/configure-client-kubectl.sh
  echo "Client kubectl has been configured."
  echo "Setting up kubernetes-lab environment..."
  setup-kubernetes-lab/setup-kubernetes-lab-environment.sh
  echo "kubernetes-lab environment setup has finished."
fi

setup-kubernetes-lab/configure-hosts.sh

cd "$PROJECT"

ssh -o "StrictHostKeyChecking no" vagrant@master-1
export INSTALLATION="/home/$USER/installation"
export SCRIPTS="$INSTALLATION/scripts"
export CONFIG="$INSTALLATION/config"
export CERTS="$INSTALLATION/certs"
export BINARIES="$INSTALLATION/binaries"
chmod +x "$SCRIPTS/*.sh"

