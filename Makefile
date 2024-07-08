

minio:
	k apply -f minio.yaml
	k create ns flux-system
	k apply -f bucket-secret.yaml

flux:
	./flux.sh