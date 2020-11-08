cd "$1"/kubernetes-lab/Vagrant || exit 1
sudo -u "$(logname)" vagrant up
