LAB_KUBERNETES_CONFIG_DIR="$1"/kubernetes-lab/Vagrant/ubuntu/kubernetes/config

ENCRYPTION_KEY=$(head -c 32 /dev/urandom | base64)

sudo -u "$(logname)" tee "$LAB_KUBERNETES_CONFIG_DIR"/encryption-config.yaml <<EOF
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