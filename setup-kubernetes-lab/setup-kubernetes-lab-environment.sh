cd "$1"/kubernetes-lab/Vagrant || exit 1
sudo -u "$(logname)" vagrant up
cd "$1"/server-setup-lab || exit 1
