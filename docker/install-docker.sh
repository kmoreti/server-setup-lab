is_curl_installed=$(curl -V)

if [ -z "$is_curl_installed" ]
then
  apt-get install curl
fi

cd /tmp || exit 1
curl -fsSL https://get.docker.com -o get-docker.sh
sh /tmp/get-docker.sh
sudo usermod -aG docker $1
