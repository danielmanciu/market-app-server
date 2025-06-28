#!/bin/bash

# Setup Docker
sudo apt-get update
sudo apt-get install ca-certificates curl -y

sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt-get update

sudo apt-get install docker-ce docker-ce-cli containerd.io -y
sudo usermod -aG docker ubuntu

# Install additional apt packages
sudo apt install unzip -y

# Setup AWS
cd /tmp
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install
rm awscliv2.zip

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
