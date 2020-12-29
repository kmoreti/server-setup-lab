ADMIN_KUBECONFIG="$LAB_KUBERNETES_CONFIG_DIR"/admin.kubeconfig

sudo -u "$(logname)" kubectl config set-cluster kubernetes-lab \
    --certificate-authority="$CERT_DIR"/ca.crt \
    --embed-certs=true \
    --server=https://127.0.0.1:6443 \
    --kubeconfig="$ADMIN_KUBECONFIG"

sudo -u "$(logname)" kubectl config set-credentials admin \
    --client-certificate="$CERT_DIR"/admin.crt \
    --client-key="$CERT_DIR"/admin.key \
    --embed-certs=true \
    --kubeconfig="$ADMIN_KUBECONFIG"

sudo -u "$(logname)" kubectl config set-context default \
    --cluster=kubernetes-lab \
    --user=admin \
    --kubeconfig="$ADMIN_KUBECONFIG"

sudo -u "$(logname)" kubectl config use-context default --kubeconfig="$ADMIN_KUBECONFIG"

sudo -u "$(logname)" chmod 664 "$ADMIN_KUBECONFIG"
