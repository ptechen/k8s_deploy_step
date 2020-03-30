#!/bin/bash

yum install nfs-utils rpcbind -y

mkdir -p /data/nfs/

chown -R nfsnobody.nfsnobody /data/nfs/

chmod 777 /data/nfs/

ll /data/

mkdir -p /etc/exports

echo '
/data/nfs 192.168.3.0/24(rw,sync)
' > /etc/exports

exportfs -r

systemctl start rpcbind
systemctl status rpcbind

systemctl start nfs
systemctl status nfs

systemctl enable rpcbind
systemctl enable nfs