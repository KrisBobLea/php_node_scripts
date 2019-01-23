#!/bin/bash

sudo apt-get remove -y docker docker-engine docker.io
sudo apt-get update
sudo apt-get install -y \
    linux-image-extra-$(uname -r) \
    linux-image-extra-virtual

sudo apt-get update
sudo apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo apt-key fingerprint 0EBFCD88

sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"

sudo apt-get update
sudo apt-get install -y docker-ce

# ------------------ start php node project ------------------
docker run -itd --name mfpad -p 80:80 -e TZ=Asia/Shanghai --restart always --log-opt max-size=50m --log-opt max-file=10 mio101/php_node_scripts