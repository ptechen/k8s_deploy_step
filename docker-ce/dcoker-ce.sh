#!/bin/bash
yum install epel-release -y
yum install -y yum-utils

yum install wget net-tools telnet tree nmap sysstat lrzsz dos2unix bind-utils -y

yum-config-manager --add-repo http://mirrors.aliyun.com/docker-ce/linux/centos/docker-ce.repo

yum install -y docker-ce

mkdir -p /etc/docker

mkdir -p /data/docker

localIP=$(ip addr|grep eth0|grep inet|grep -v 127.0.0.1|grep -v inet6|awk '{print $2}'|tr -d "add:")

localip=${localIP%/*}

backip=$(echo $localip|awk -F. '{ print $3"."$4 }')
echo '{
  "graph": "/data/docker",
  "storage-driver": "overlay2",
  "registry-mirrors" : [
    "http://ovfftd6p.mirror.aliyuncs.com",
    "http://registry.docker-cn.com",
    "http://docker.mirrors.ustc.edu.cn",
    "http://hub-mirror.c.163.com"
  ],
  "insecure-registries" : [
    "registry.docker-cn.com",
    "docker.mirrors.ustc.edu.cn",
    "registry.access.redhat.com",
    "quay.io",
    "wds.harbor.com"
  ],
  "bip": "172.'$backip'.1/24",
  "exec-opts": ["native.cgroupdriver=systemd"],
  "live-restore": true
}' > /etc/docker/daemon.json

systemctl restart docker

systemctl enable docker

systemctl status docker
#systemctl restart docker