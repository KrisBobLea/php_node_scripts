#!/bin/bash

yum install git vim curl wget

# --------------------- install docker -----------------------
yum remove docker docker-common docker-selinux docker-engine docker-ce
yum install -y yum-utils device-mapper-persistent-data lvm2
wget -O /etc/yum.repos.d/docker-ce.repo https://download.docker.com/linux/centos/docker-ce.repo
yum makecache fast
yum install -y docker-ce docker-ce-cli containerd.io

systemctl start docker
systemctl enable docker

# ------------------ install common ------------------
yum -y install zsh
chsh -s $(which zsh)
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# ------------------ start php node project ------------------
docker stop mfpad
docker rm mfpad
docker run -itd --name mfpad \
    -p 80:80 \
    -e TZ=Asia/Shanghai \
    -v /data/mfpad:/var/www/html \
    --restart always \
    --log-opt max-size=50m --log-opt max-file=10 \
    mio101/php_node_scripts