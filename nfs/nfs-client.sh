#!/bin/bash

yum install nfs-utils rpcbind -y

mkdir -p /data/nfs

mount -t nfs 192.168.3.225:/data/nfs /data/nfs