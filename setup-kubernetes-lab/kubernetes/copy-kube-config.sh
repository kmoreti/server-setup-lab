LAB_KUBERNETES_DIR="$1"/kubernetes-lab/Vagrant/ubuntu/kubernetes
sudo -u "$(logname)" cp -r setup-kubernetes-lab/kubernetes/config "$LAB_KUBERNETES_DIR"/

LOADBALANCER_ADDRESS=192.168.5.30

sudo -u "$(logname)" tee "$LAB_KUBERNETES_DIR"/config/kube-proxy.kubeconfig <<EOF
{
  kubectl config set-cluster kubernetes-lab \
    --certificate-authority=ca.crt \
    --embed-certs=true \
    --server=https://${LOADBALANCER_ADDRESS}:6443 \
    --kubeconfig=kube-proxy.kubeconfig

  kubectl config set-credentials system:kube-proxy \
    --client-certificate=kube-proxy.crt \
    --client-key=kube-proxy.key \
    --embed-certs=true \
    --kubeconfig=kube-proxy.kubeconfig

  kubectl config set-context default \
    --cluster=kubernetes-lab \
    --user=system:kube-proxy \
    --kubeconfig=kube-proxy.kubeconfig

  kubectl config use-context default --kubeconfig=kube-proxy.kubeconfig
}
EOF