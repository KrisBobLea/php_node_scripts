#!/bin/bash

mkdir -p /etc/v2ray
curl https://raw.githubusercontent.com/MioYvo/php_node_scripts/master/config.json -o /etc/v2ray/config.json
docker run -itd --name v2ray --restart always -p 31560:31560 -p 31561:31561 -v /etc/v2ray/:/etc/v2ray/ v2ray/official