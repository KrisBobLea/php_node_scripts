#!/bin/bash

echo "-------- install shadowsocks(python) -----"
yum install -y python-setuptools && easy_install pip
pip install shadowsocks
echo "----------------- done -------------------"

echo "-------- start shadowsocks server --------"
ss_config="/etc/shadowsocks.json"
IP="`ifconfig |grep 'inet'|grep -v '172.17.0.1' | grep -v 'grep' | grep -v '127.0.0.1' |grep -v 'inet6'| awk '{print $2}'`" # store IP
echo $IP
# remove old ss config file
rm $ss_config
# generate random password
pwd=`cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 10 | head -n 1`

server_port=31518

cat <<EOF > $ss_config
{
    "server":"$IP",
    "server_port": $server_port,
    "local_address": "127.0.0.1",
    "local_port":1080,
    "password":"$pwd",
    "timeout":300,
    "method":"aes-256-cfb",
    "fast_open": false
}
EOF
echo "-------- create config file in $ss_config --------"
ssserver -c /etc/shadowsocks.json -d restart

echo "-------- add ssserver to init.d/rc.local  --------"
echo "ssserver -c /etc/shadowsocks.json -d start" >> /etc/rc.local


# ---------------- php ----------------
echo "________ install php, httpd _________"
yum install -y php httpd
chkconfig httpd on
# TODO cp httpd.conf
# yes | cp -f httpd.conf /etc/httpd/conf/httpd.conf
/etc/init.d/httpd restart

echo "________ download mfsset ________"
mkdir -p /var/www/html
cd /var/www/html
rm -f mfs_set
wget https://www.mfpad.com/public/node/mfs_set

echo "________ post ss config info to master ________"
echo "-F ip=$IP -F port=$server_port -F pwd=$pwd $master_uri"
master_uri="http://service.mfpad.com/Pad/returnMfsConfig?ip=$IP"
curl -F ip=$IP -F port=$server_port -F pwd=$pwd $master_uri

echo "******** write iptables ********"
cat <<EOF > /etc/sysconfig/iptables
# Firewall configuration written by system-config-firewall
# Manual customization of this file is not recommended.
*filter
:INPUT ACCEPT [0:0]
:FORWARD ACCEPT [0:0]
:OUTPUT ACCEPT [0:0]
-A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
-A INPUT -p icmp -j ACCEPT
-A INPUT -i lo -j ACCEPT
-A INPUT -m state --state NEW -m tcp -p tcp --dport 22 -j ACCEPT
-A INPUT -m state --state NEW -m tcp -p tcp --dport 80 -j ACCEPT
-A INPUT -m state --state NEW -m tcp -p tcp --dport $server_port -j ACCEPT
-A INPUT -j REJECT --reject-with icmp-host-prohibited
-A FORWARD -j REJECT --reject-with icmp-host-prohibited
COMMIT
EOF
service iptables restart

echo 'enjoy'
