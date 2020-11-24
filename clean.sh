HOME_DIRECTORY=$(getent passwd "$(logname)" | cut -d: -f6)

cd "$HOME_DIRECTORY"/kubernetes-lab/Vagrant/ || exit 1

vagrant destroy

cd "$HOME_DIRECTORY"/server-setup-lab/ || exit 1

rm -rf ca-and-tls/config/ ca-and-tls/certificates/ "$HOME_DIRECTORY"/kubernetes-lab/

git pull