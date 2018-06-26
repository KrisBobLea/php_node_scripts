#!/bin/bash

# ------------------ upgrade system packages --------------------
yum makecache fast
yum update --skip-broken -y
reboot