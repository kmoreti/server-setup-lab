LAB_KUBERNETES_DIR="$1"/kubernetes-lab/Vagrant/ubuntu/kubernetes
sudo -u "$(logname)" cp -r setup-kubernetes-lab/kubernetes/config "$LAB_KUBERNETES_DIR"/

export LOADBALANCER_ADDRESS=192.168.5.30

cat setup-kubernetes-lab/kubernetes/config-template/kube-proxy.kubeconfig_template | sudo -u "$(logname)" tee "$LAB_KUBERNETES_DIR"/config/kube-proxy.kubeconfig