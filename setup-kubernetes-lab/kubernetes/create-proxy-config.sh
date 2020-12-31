PROXY_CONFIG="$LAB_KUBERNETES_CONFIG_DIR"/kube-proxy.kubeconfig

sudo -u "$(logname)" kubectl config set-cluster kubernetes-lab \
    --certificate-authority="$CERT_DIR"/ca.crt \
    --embed-certs=true \
    --server=https://"${LOADBALANCER_ADDRESS}":6443 \
    --kubeconfig="$PROXY_CONFIG"

sudo -u "$(logname)" kubectl config set-credentials system:kube-proxy \
    --client-certificate="$CERT_DIR"/kube-proxy.crt \
    --client-key="$CERT_DIR"/kube-proxy.key \
    --embed-certs=true \
    --kubeconfig="$PROXY_CONFIG"

sudo -u "$(logname)" kubectl config set-context default \
    --cluster=kubernetes-lab \
    --user=system:kube-proxy \
    --kubeconfig="$PROXY_CONFIG"

sudo -u "$(logname)" kubectl config use-context default --kubeconfig="$PROXY_CONFIG"

sudo -u "$(logname)" chmod 664 "$PROXY_CONFIG"
