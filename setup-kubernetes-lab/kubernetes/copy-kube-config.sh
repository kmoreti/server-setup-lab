sudo -u "$(logname)" cp config "$1"/kubernetes-lab/Vagrant/kubernetes/

LOADBALANCER_ADDRESS=192.168.5.30

sudo -u "$(logname)" cat setup-kubernetes-lab/kubernetes/config-template/kube-proxy.kubeconfig_template > "$1"/kubernetes-lab/Vagrant/kubernetes/config/