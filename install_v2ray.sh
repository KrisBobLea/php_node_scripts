#!/bin/bash

mkdir -p /etc/v2ray
cp config.json /etc/v2ray/
docker run -itd --name v2ray --restart always -p 31560:31560 -p 31561:31561 -v /etc/v2ray/:/etc/v2ray/ v2ray/official