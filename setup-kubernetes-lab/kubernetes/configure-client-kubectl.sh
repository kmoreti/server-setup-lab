KUBERNETES_LB_ADDRESS=192.168.5.30

sudo -u "$(logname)" kubectl config set-cluster kubernetes-lab \
    --certificate-authority="$CERT_DIR"/ca.crt \
    --embed-certs=true \
    --server=https://${KUBERNETES_LB_ADDRESS}:6443

sudo -u "$(logname)" kubectl config set-credentials admin \
    --client-certificate="$CERT_DIR"/admin.crt \
    --client-key="$CERT_DIR"/admin.key

sudo -u "$(logname)" kubectl config set-context kubernetes-lab \
    --cluster=kubernetes-lab \
    --user=admin

sudo -u "$(logname)" kubectl config use-context kubernetes-lab

