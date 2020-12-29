WORKER_1_KUBECONFIG="$LAB_KUBERNETES_CONFIG_DIR"/worker-1.kubeconfig

sudo -u "$(logname)" kubectl config set-cluster kubernetes-lab \
    --certificate-authority="$CERT_DIR"/ca.crt \
    --embed-certs=true \
    --server=https://${LOADBALANCER_ADDRESS}:6443 \
    --kubeconfig="$WORKER_1_KUBECONFIG"

sudo -u "$(logname)" kubectl config set-credentials system:node:worker-1 \
    --client-certificate="$CERT_DIR"/worker-1.crt \
    --client-key="$CERT_DIR"/worker-1.key \
    --embed-certs=true \
    --kubeconfig="$WORKER_1_KUBECONFIG"

sudo -u "$(logname)" kubectl config set-context default \
    --cluster=kubernetes-lab \
    --user=system:node:worker-1 \
    --kubeconfig="$WORKER_1_KUBECONFIG"

sudo -u "$(logname)" kubectl config use-context default --kubeconfig="$WORKER_1_KUBECONFIG"

sudo -u "$(logname)" chmod 664 "$WORKER_1_KUBECONFIG"
