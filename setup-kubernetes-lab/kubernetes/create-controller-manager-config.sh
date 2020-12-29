CONTROLLER_MANAGER_CONFIG="$LAB_KUBERNETES_CONFIG_DIR"/kube-controller-manager.kubeconfig
sudo -u "$(logname)" kubectl config set-cluster kubernetes-lab \
    --certificate-authority=$HOME/ca.crt \
    --embed-certs=true \
    --server=https://127.0.0.1:6443 \
    --kubeconfig="$CONTROLLER_MANAGER_CONFIG"

sudo -u "$(logname)" kubectl config set-credentials system:kube-controller-manager \
    --client-certificate="$CERT_DIR"/kube-controller-manager.crt \
    --client-key="$CERT_DIR"/kube-controller-manager.key \
    --embed-certs=true \
    --kubeconfig="$CONTROLLER_MANAGER_CONFIG"

sudo -u "$(logname)" kubectl config set-context default \
    --cluster=kubernetes-lab \
    --user=system:kube-controller-manager \
    --kubeconfig="$CONTROLLER_MANAGER_CONFIG"

sudo -u "$(logname)" kubectl config use-context default --kubeconfig="$CONTROLLER_MANAGER_CONFIG"

sudo -u "$(logname)" chmod 664 "$CONTROLLER_MANAGER_CONFIG"
