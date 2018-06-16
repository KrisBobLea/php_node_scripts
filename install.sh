#!/bin/bash

# ------------------ install curl git vim --------------------
yum install git vim curl

# --------------------- install docker -----------------------
curl -fsSL get.docker.com -o get-docker.sh
sh get-docker.sh
systemctl start docker
systemctl enable docker

# ------------------ install docker-compose ------------------
# curl -L https://github.com/docker/compose/releases/download/1.21.2/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose
# chmod +x /usr/local/bin/docker-compose

# ------------------ start php node project ------------------
# docker-compose up -d
docker run -itd --name mfpad -p 80:80 -e TZ=Asia/Shanghai --restart always --log-opt max-size=10m --log-opt max-file=10 mio101/php_node_scripts