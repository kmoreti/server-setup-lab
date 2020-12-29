LOADBALANCER_ADDRESS=192.168.5.30

kubectl config set-cluster kubernetes-lab \
    --certificate-authority="$CERT_DIR"/ca.crt \
    --embed-certs=true \
    --server=https://${LOADBALANCER_ADDRESS}:6443 \
    --kubeconfig="$LAB_KUBERNETES_CONFIG_DIR"/kube-proxy.kubeconfig

kubectl config set-credentials system:kube-proxy \
    --client-certificate="$CERT_DIR"/kube-proxy.crt \
    --client-key="$CERT_DIR"/kube-proxy.key \
    --embed-certs=true \
    --kubeconfig="$LAB_KUBERNETES_CONFIG_DIR"/kube-proxy.kubeconfig

kubectl config set-context default \
    --cluster=kubernetes-lab \
    --user=system:kube-proxy \
    --kubeconfig="$LAB_KUBERNETES_CONFIG_DIR"/kube-proxy.kubeconfig

kubectl config use-context default --kubeconfig="$LAB_KUBERNETES_CONFIG_DIR"/kube-proxy.kubeconfig

chown -R "$(id -u)":"$(id -g)" "$LAB_KUBERNETES_CONFIG_DIR"/kube-proxy.kubeconfig