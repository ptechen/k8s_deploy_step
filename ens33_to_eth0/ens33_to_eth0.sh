#!/bin/bash

mv /etc/sysconfig/network-scripts/ifcfg-ens33 /etc/sysconfig/network-scripts/ifcfg-eth0

sed -i "s/NAME=ens33/NAME=eth0/g" /etc/sysconfig/network-scripts/ifcfg-eth0
sed -i "s/DEVICE=ens33/DEVICE=eth0/g" /etc/sysconfig/network-scripts/ifcfg-eth0

sed -i "s/rhgb quiet/net.ifnames=0 biosdevname=0 rhgb quiet/g" /etc/default/grub

grub2-mkconfig -o /boot/grub2/grub.cfg

reboot