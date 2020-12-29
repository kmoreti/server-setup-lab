kubectl config set-cluster kubernetes-lab \
    --certificate-authority="$CERT_DIR"/ca.crt \
    --embed-certs=true \
    --server=https://127.0.0.1:6443 \
    --kubeconfig="$LAB_KUBERNETES_CONFIG_DIR"/kube-scheduler.kubeconfig

kubectl config set-credentials system:kube-scheduler \
    --client-certificate="$CERT_DIR"/kube-scheduler.crt \
    --client-key="$CERT_DIR"/kube-scheduler.key \
    --embed-certs=true \
    --kubeconfig="$LAB_KUBERNETES_CONFIG_DIR"/kube-scheduler.kubeconfig

kubectl config set-context default \
    --cluster=kubernetes-lab \
    --user=system:kube-scheduler \
    --kubeconfig="$LAB_KUBERNETES_CONFIG_DIR"/kube-scheduler.kubeconfig

kubectl config use-context default --kubeconfig="$LAB_KUBERNETES_CONFIG_DIR"/kube-scheduler.kubeconfig

chown -R "$(id -u)":"$(id -g)" "$LAB_KUBERNETES_CONFIG_DIR"/kube-scheduler.kubeconfig
