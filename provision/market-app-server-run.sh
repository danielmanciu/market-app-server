#!/bin/bash

# Login to Docker
aws ecr get-login-password --region eu-north-1 | docker login --username AWS --password-stdin 267348411096.dkr.ecr.eu-north-1.amazonaws.com

# Download config for nginx
aws s3 cp s3://market-app-s3/nginx/nginx.conf nginx/nginx.conf

# Download SSL certs for nginx
aws s3 cp s3://market-app-s3/nginx/certs/ssl-fullchain.pem nginx/certs/fullchain.pem
aws s3 cp s3://market-app-s3/nginx/certs/ssl-privkey.pem nginx/certs/privkey.pem

# Download docker-compose.yml
aws s3 cp s3://market-app-s3/docker/docker-compose.yml .

# Run Docker containers
docker compose up -d
