sudo -u "$(logname)" curl -fsSL "https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kube-apiserver" -o "$KUBE_API_SERVER"
sudo -u "$(logname)" curl -fsSL "https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kube-controller-manager" -o "$KUBE_CONTROLLER_MANAGER"
sudo -u "$(logname)" curl -fsSL "https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kube-scheduler" -o "$KUBE_SCHEDULER"
sudo -u "$(logname)" curl -fsSL "https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl" -o "$KUBE_CTL"

sudo -u "$(logname)" chmod +x "$KUBE_API_SERVER"
sudo -u "$(logname)" chmod +x "$KUBE_CONTROLLER_MANAGER"
sudo -u "$(logname)" chmod +x "$KUBE_SCHEDULER"
sudo -u "$(logname)" chmod +x "$KUBE_CTL"