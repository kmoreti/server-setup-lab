ENCRYPTION_KEY=$(head -c 32 /dev/urandom | base64)

sudo -u "$(logname)" cat > "$1"/kubernetes-lab/Vagrant/kubernetes/config/encryption-config.yaml <<EOF
kind: EncryptionConfig
apiVersion: v1
resources:
  - resources:
      - secrets
    providers:
      - aescbc:
          keys:
            - name: key1
              secret: ${ENCRYPTION_KEY}
      - identity: {}
EOF