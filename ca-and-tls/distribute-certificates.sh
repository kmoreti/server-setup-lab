CERT_DIR=$(getent passwd "$(logname)" | cut -d: -f6)/server-setup-lab/ca-and-tls/certificates

for instance in master-1 master-2; do
  scp "$CERT_DIR"/ca.crt "$CERT_DIR"/ca.key "$CERT_DIR"/kube-apiserver.key "$CERT_DIR"/kube-apiserver.crt \
    "$CERT_DIR"/service-account.key "$CERT_DIR"/service-account.crt \
    "$CERT_DIR"/etcd-server.key "$CERT_DIR"/etcd-server.crt \
    ${instance}:~/
done