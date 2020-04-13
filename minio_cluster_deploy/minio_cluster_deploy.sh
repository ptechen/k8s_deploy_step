#!/bin/bash

#pkill minio
export MINIO_ACCESS_KEY=admin
export MINIO_SECRET_KEY=admin123
cd /data/nfs
mkdir -p /opt/data/minio/
nohup ./minio server http://192.168.3.192/export2 http://192.168.3.193/export3 http://192.168.3.194/export4 http://192.168.3.195/export5 > /opt/data/minio/minio.log 2>&1 &
