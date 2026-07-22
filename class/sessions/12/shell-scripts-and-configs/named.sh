#!/bin/bash
# This script configure bind on your centos server

# wget https://main.linuxbeat.com/named.conf
# wget https://main.linuxbeat.com/iran.ir.db

cp -f named.conf  /var/named/chroot/etc/
cp -f iran.ir.db  /var/named/chroot/var/named/
echo "nameserver 127.0.0.1" > /etc/resolv.conf
chattr +i /etc/resolv.conf
systemctl stop firewalld
systemctl disable firewalld
dig mx iran.ir
