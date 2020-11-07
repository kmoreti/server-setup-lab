cd /tmp || exit 1
curl -fsSL https://get.docker.com -o get-docker.sh
sh /tmp/get-docker.sh
usermod -aG docker "$(logname)"
docker --version
