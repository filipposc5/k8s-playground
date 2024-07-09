#!/bin/bash

set -euo pipefail
curl -s https://fluxcd.io/install.sh | sudo bash
flux install
apt install awscli -y

minio_ip=$(kubectl get pod -o json -l app=minio | jq -r '.items | .[].status.podIP')
# flux create source --export bucket minio  --endpoint http://${minio_ip}:9000 --bucket-name fluxcd --insecure > bucket.yaml


aws s3 --endpoint http://${minio_ip}:9000 mb s3://fluxcd

kubectl create cm foo --from-literal a=b --dry-run=client -o yaml > cm1.yaml

aws s3 --endpoint http://${minio_ip}:9000 ls s3://fluxcd/


# gotcha: --endpoint requires no scheme, otherwise throws weird error "Endpoint url cannot have fully qualified paths."
flux create source bucket minio  --endpoint minio.default.svc.cluster.local.:9000 --bucket-name fluxcd --insecure --secret-ref minio-bucket-secret -n flux-system --interval=2h

aws s3 --endpoint http://${minio_ip}:9000 cp cm1.yaml s3://fluxcd/

wget https://github.com/derailed/k9s/releases/download/v0.32.5/k9s_Linux_amd64.tar.gz
echo 33c31bf5feba292b59b8dabe5547cb52ab565521ee5619b52eb4bd4bf226cea3  k9s_Linux_amd64.tar.gz > sum
sha256sum -c sum
tar zvxf k9s_Linux_amd64.tar.gz k9s
sudo mv k9s /usr/local/bin
