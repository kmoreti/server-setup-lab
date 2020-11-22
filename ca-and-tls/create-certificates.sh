CERT_DIR="ca-and-tls/certificates"
SSL_CONF_DIR="ca-and-tls/config"

sudo -u "$(logname)" mkdir "$CERT_DIR"
sudo -u "$(logname)" mkdir "$SSL_CONF_DIR"


#####################################################################################
# Certificate Authority
#####################################################################################
# Create private key for CA
sudo -u "$(logname)" openssl genrsa -out "$CERT_DIR"/ca.key 2048

# Comment line starting with RANDFILE in /etc/ssl/openssl.cnf definition to avoid permission issues
sudo sed -i '0,/RANDFILE/{s/RANDFILE/\#&/}' /etc/ssl/openssl.cnf

# Create CSR using the private key
sudo -u "$(logname)" openssl req -new -key "$CERT_DIR"/ca.key -subj "/CN=KUBERNETES-CA" -out "$CERT_DIR"/ca.csr

# Self sign the csr using its own private key
sudo -u "$(logname)" openssl x509 -req -in "$CERT_DIR"/ca.csr -signkey ca.key -CAcreateserial -out "$CERT_DIR"/ca.crt -days 1000

#####################################################################################
# Client and Server Certificates
#####################################################################################
# Generate private key for admin user
sudo -u "$(logname)" openssl genrsa -out "$CERT_DIR"/admin.key 2048

# Generate CSR for admin user. Note the OU.
sudo -u "$(logname)" openssl req -new -key "$CERT_DIR"/admin.key -subj "/CN=admin/O=system:masters" -out "$CERT_DIR"/admin.csr

# Sign certificate for admin user using CA servers private key
sudo -u "$(logname)" openssl x509 -req -in "$CERT_DIR"/admin.csr -CA ca.crt -CAkey ca.key -CAcreateserial  -out "$CERT_DIR"/admin.crt -days 1000

#####################################################################################
# The Controller Manager Client Certificate
#####################################################################################
sudo -u "$(logname)" openssl genrsa -out "$CERT_DIR"/kube-controller-manager.key 2048
sudo -u "$(logname)" openssl req -new -key "$CERT_DIR"/kube-controller-manager.key -subj "/CN=system:kube-controller-manager" -out "$CERT_DIR"/kube-controller-manager.csr
sudo -u "$(logname)" openssl x509 -req -in "$CERT_DIR"/kube-controller-manager.csr -CA ca.crt -CAkey ca.key -CAcreateserial -out "$CERT_DIR"/kube-controller-manager.crt -days 1000

#####################################################################################
# The Kube Proxy Client Certificate
#####################################################################################
sudo -u "$(logname)" openssl genrsa -out "$CERT_DIR"/kube-proxy.key 2048
sudo -u "$(logname)" openssl req -new -key "$CERT_DIR"/kube-proxy.key -subj "/CN=system:kube-proxy" -out "$CERT_DIR"/kube-proxy.csr
sudo -u "$(logname)" openssl x509 -req -in "$CERT_DIR"/kube-proxy.csr -CA ca.crt -CAkey ca.key -CAcreateserial  -out "$CERT_DIR"/kube-proxy.crt -days 1000

#####################################################################################
# The Scheduler Client Certificate
#####################################################################################
sudo -u "$(logname)" openssl genrsa -out "$CERT_DIR"/kube-scheduler.key 2048
sudo -u "$(logname)" openssl req -new -key "$CERT_DIR"/kube-scheduler.key -subj "/CN=system:kube-scheduler" -out "$CERT_DIR"/kube-scheduler.csr
sudo -u "$(logname)" openssl x509 -req -in "$CERT_DIR"/kube-scheduler.csr -CA ca.crt -CAkey ca.key -CAcreateserial  -out "$CERT_DIR"/kube-scheduler.crt -days 1000

#####################################################################################
# The Kubernetes API Server Certificate
#####################################################################################
sudo -u "$(logname)" cat > "$SSL_CONF_DIR"/openssl.cnf <<EOF
[req]
req_extensions = v3_req
distinguished_name = req_distinguished_name
[req_distinguished_name]
[ v3_req ]
basicConstraints = CA:FALSE
keyUsage = nonRepudiation, digitalSignature, keyEncipherment
subjectAltName = @alt_names
[alt_names]
DNS.1 = kubernetes
DNS.2 = kubernetes.default
DNS.3 = kubernetes.default.svc
DNS.4 = kubernetes.default.svc.cluster.local
IP.1 = 10.96.0.1
IP.2 = 192.168.5.11
IP.3 = 192.168.5.12
IP.4 = 192.168.5.30
IP.5 = 127.0.0.1
EOF

# Generates certs for kube-apiserver
sudo -u "$(logname)" openssl genrsa -out "$CERT_DIR"/kube-apiserver.key 2048
sudo -u "$(logname)" openssl req -new -key "$CERT_DIR"/kube-apiserver.key -subj "/CN=kube-apiserver" -out "$CERT_DIR"/kube-apiserver.csr -config openssl.cnf
sudo -u "$(logname)" openssl x509 -req -in "$CERT_DIR"/kube-apiserver.csr -CA ca.crt -CAkey ca.key -CAcreateserial  -out "$CERT_DIR"/kube-apiserver.crt -extensions v3_req -extfile openssl.cnf -days 1000

#####################################################################################
# The ETCD Server Certificate
#####################################################################################
sudo -u "$(logname)" cat > "$SSL_CONF_DIR"/openssl-etcd.cnf <<EOF
[req]
req_extensions = v3_req
distinguished_name = req_distinguished_name
[req_distinguished_name]
[ v3_req ]
basicConstraints = CA:FALSE
keyUsage = nonRepudiation, digitalSignature, keyEncipherment
subjectAltName = @alt_names
[alt_names]
IP.1 = 192.168.5.11
IP.2 = 192.168.5.12
IP.3 = 127.0.0.1
EOF

# Generates certs for ETCD
sudo -u "$(logname)" openssl genrsa -out "$CERT_DIR"/etcd-server.key 2048
sudo -u "$(logname)" openssl req -new -key "$CERT_DIR"/etcd-server.key -subj "/CN=etcd-server" -out "$CERT_DIR"/etcd-server.csr -config openssl-etcd.cnf
sudo -u "$(logname)" openssl x509 -req -in "$CERT_DIR"/etcd-server.csr -CA ca.crt -CAkey ca.key -CAcreateserial  -out "$CERT_DIR"/etcd-server.crt -extensions v3_req -extfile openssl-etcd.cnf -days 1000

#####################################################################################
# The Service Account Key Pair
#####################################################################################
sudo -u "$(logname)" openssl genrsa -out "$CERT_DIR"/service-account.key 2048
sudo -u "$(logname)" openssl req -new -key "$CERT_DIR"/service-account.key -subj "/CN=service-accounts" -out "$CERT_DIR"/service-account.csr
sudo -u "$(logname)" openssl x509 -req -in "$CERT_DIR"/service-account.csr -CA ca.crt -CAkey ca.key -CAcreateserial  -out "$CERT_DIR"/service-account.crt -days 1000
