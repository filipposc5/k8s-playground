

minio:
	kubectl apply -f minio.yaml
	kubectl create ns flux-system
	kubectl apply -f bucket-secret.yaml

flux:
	./flux.sh