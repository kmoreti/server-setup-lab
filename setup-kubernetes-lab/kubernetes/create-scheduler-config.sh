SCHEDULER_CONFIG="$LAB_KUBERNETES_CONFIG_DIR"/kube-scheduler.kubeconfig

sudo -u "$(logname)" kubectl config set-cluster kubernetes-lab \
    --certificate-authority="$CERT_DIR"/ca.crt \
    --embed-certs=true \
    --server=https://127.0.0.1:6443 \
    --kubeconfig="$SCHEDULER_CONFIG"

sudo -u "$(logname)" kubectl config set-credentials system:kube-scheduler \
    --client-certificate="$CERT_DIR"/kube-scheduler.crt \
    --client-key="$CERT_DIR"/kube-scheduler.key \
    --embed-certs=true \
    --kubeconfig="$SCHEDULER_CONFIG"

sudo -u "$(logname)" kubectl config set-context default \
    --cluster=kubernetes-lab \
    --user=system:kube-scheduler \
    --kubeconfig="$SCHEDULER_CONFIG"

sudo -u "$(logname)" kubectl config use-context default --kubeconfig="$SCHEDULER_CONFIG"

sudo -u "$(logname)" chmod 664 "$SCHEDULER_CONFIG"
