#VERSION="v1.13.0"
VERSION=$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)

echo "Downloading kube-api-server..."
sudo -u "$(logname)" curl -# -fSL "https://storage.googleapis.com/kubernetes-release/release/$VERSION/bin/linux/amd64/kube-apiserver" -o "$KUBE_API_SERVER"
echo "Downloading kube-controller-manager..."
sudo -u "$(logname)" curl -# -fSL "https://storage.googleapis.com/kubernetes-release/release/$VERSION/bin/linux/amd64/kube-controller-manager" -o "$KUBE_CONTROLLER_MANAGER"
echo "Downloading kube-scheduler..."
sudo -u "$(logname)" curl -# -fSL "https://storage.googleapis.com/kubernetes-release/release/$VERSION/bin/linux/amd64/kube-scheduler" -o "$KUBE_SCHEDULER"
echo "Downloading kube-ctl..."
sudo -u "$(logname)" curl -# -fSL "https://storage.googleapis.com/kubernetes-release/release/$VERSION/bin/linux/amd64/kubectl" -o "$KUBE_CTL"
echo "Downloading kube-proxy..."
sudo -u "$(logname)" curl -# -fSL "https://storage.googleapis.com/kubernetes-release/release/$VERSION/bin/linux/amd64/kube-proxy" -o "$KUBE_PROXY"
echo "Downloading kubelet..."
sudo -u "$(logname)" curl -# -fSL "https://storage.googleapis.com/kubernetes-release/release/$VERSION/bin/linux/amd64/kube-proxy" -o "$KUBELET"

sudo -u "$(logname)" chmod +x "$KUBE_API_SERVER"
sudo -u "$(logname)" chmod +x "$KUBE_CONTROLLER_MANAGER"
sudo -u "$(logname)" chmod +x "$KUBE_SCHEDULER"
sudo -u "$(logname)" chmod +x "$KUBE_CTL"
sudo -u "$(logname)" chmod +x "$KUBE_PROXY"
sudo -u "$(logname)" chmod +x "$KUBELET"