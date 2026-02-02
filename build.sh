#!/bin/bash

#install docker

sudo apt update
sudo apt install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

sudo apt  install docker.io

sudo groupadd docker
sudo usermod -aG docker $USER

echo "✅ Docker installed successfully."


# check wether docker installed or not
docker ps

echo "📦 Building Docker image..."
docker build -t dev-app .

echo "Docker image 'dev-app' built successfully."
