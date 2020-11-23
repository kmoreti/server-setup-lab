LAB_KUBERNETES_DIR="$1"/kubernetes-lab/Vagrant/ubuntu/kubernetes
sudo -u "$(logname)" cp -r setup-kubernetes-lab/kubernetes/config "$LAB_KUBERNETES_DIR"/

LOADBALANCER_ADDRESS=192.168.5.30

sudo -u "$(logname)" cat setup-kubernetes-lab/kubernetes/config-template/kube-proxy.kubeconfig_template | "$LAB_KUBERNETES_DIR"/config/kube-proxy.kubeconfig