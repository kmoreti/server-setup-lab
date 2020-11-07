apt-get install curl
cd /tmp
curl -fsSL https://get.docker.com -o get-docker.sh
sh /tmp/get-docker.sh
echo $1
sudo usermod -aG docker $1