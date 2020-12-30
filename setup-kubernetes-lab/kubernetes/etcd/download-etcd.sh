echo "Downloading etcd..."
sudo -u "$(logname)" curl -fsSL "https://github.com/coreos/etcd/releases/download/v3.3.9/etcd-v3.3.9-linux-amd64.tar.gz" -o "$ETCD"
