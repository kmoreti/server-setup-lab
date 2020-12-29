kubectl config set-cluster kubernetes-lab \
    --certificate-authority="$CERT_DIR"/ca.crt \
    --embed-certs=true \
    --server=https://127.0.0.1:6443 \
    --kubeconfig="$LAB_KUBERNETES_CONFIG_DIR"/admin.kubeconfig

kubectl config set-credentials admin \
    --client-certificate="$CERT_DIR"/admin.crt \
    --client-key="$CERT_DIR"/admin.key \
    --embed-certs=true \
    --kubeconfig="$LAB_KUBERNETES_CONFIG_DIR"/admin.kubeconfig

kubectl config set-context default \
    --cluster=kubernetes-lab \
    --user=admin \
    --kubeconfig="$LAB_KUBERNETES_CONFIG_DIR"/admin.kubeconfig

sudo -u "$(logname)" kubectl config use-context default --kubeconfig="$LAB_KUBERNETES_CONFIG_DIR"/admin.kubeconfig
