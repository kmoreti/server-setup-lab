cd "$HOME_DIRECTORY"/kubernetes-lab/Vagrant || exit 1
sudo -u "$(logname)" vagrant up
cd "$HOME_DIRECTORY"/server-setup-lab || exit 1
