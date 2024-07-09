#!/bin/bash

mkdir -p -m 700 ~/.aws
cat << EOF > ~/.aws/credentials
[default]
aws_access_key_id = minio
aws_secret_access_key = minio123
EOF
