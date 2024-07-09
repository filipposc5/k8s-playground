
~/.aws/credentials:
	./gencreds.sh

minio: ~/.aws/credentials
	kubectl apply -f minio.yaml
	kubectl create ns flux-system
	kubectl apply -f bucket-secret.yaml

flux:
	./flux.sh

# eval $(make minio-ip)
minio-ip:
	@echo minio_ip=$$(kubectl get pod -o json -l app=minio | jq -r '.items | .[].status.podIP')
