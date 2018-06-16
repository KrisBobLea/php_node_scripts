#!/bin/bash

# ------------------ install curl git vim --------------------
yum install git vim curl

# --------------------- install docker -----------------------
curl -fsSL get.docker.com -o get-docker.sh
sh get-docker.sh
systemctl start docker
systemctl enable docker

# ------------------ install docker-compose ------------------
curl -L https://github.com/docker/compose/releases/download/1.21.2/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

# ------------------ start php node project ------------------
docker-compose up -d
