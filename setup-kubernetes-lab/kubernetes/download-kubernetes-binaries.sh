curl -fsSL "https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kube-apiserver" -o "$KUBE_API_SERVER"
curl -fsSL "https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kube-controller-manager" -o "$KUBE_CONTROLLER_MANAGER"
curl -fsSL "https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kube-scheduler" -o "$KUBE_SCHEDULER"
curl -fsSL "https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl" -o "$KUBE_CTL"

chmod +x "$KUBE_API_SERVER"
chmod +x "$KUBE_CONTROLLER_MANAGER"
chmod +x "$KUBE_SCHEDULER"
chmod +x "$KUBE_CTL"