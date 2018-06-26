#!/bin/bash

# ------------------ prepare centos ------------------
rpm -Uvh http://www.elrepo.org/elrepo-release-7.0-3.el7.elrepo.noarch.rpm
yum --enablerepo=elrepo-kernel install kernel-ml -y
grub2-mkconfig -o /boot/grub2/grub.cfg

reboot