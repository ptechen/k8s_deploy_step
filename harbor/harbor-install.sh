#!/bin/bash

# /opt/harbor/harbor.yml
# hostname: harbor.od.com
# http:
#   port: 180
# data_volume: /data/harbor
# location: /data/harbor/logs
tar xf harbor-offline-installer-v1.10.1.tgz -C /opt
mv /opt/harbor /opt/harbor-v1.10.1
ln -s /opt/harbor-v1.10.1 /opt/harbor
yum install epel-release -y
mkdir -p /data/harbor/logs

#yum install -y python3
#
#pip3 install docker-compose

#sh /opt/harbor/install.sh

yum install -y nginx

echo 'server {
    listen       80;
    server_name  vadd.harbor.com;
    client_max_body_size 1000m;
    location / {
        proxy_pass http://127.0.0.1:180;
    }
}' > /etc/nginx/conf.d/vadd.harbor.com.conf

systemctl start nginx

systemctl enable nginx

#docker pull docker.io/library/nginx:1.7.9

#docker tag 84581e99d807 harbor.od.com/public/nginx:v1.7.9

#docker login harbor.od.com

#docker push harbor.od.com/public/nginx:v1.7.9



tar xf harbor-offline-installer-v1.8.3.tgz -C /opt
mv /opt/harbor /opt/harbor-v1.8.3
ln -s /opt/harbor-v1.8.3 /opt/harbor
yum install epel-release -y
mkdir -p /data/harbor/logs

echo 'server {
    listen       80;
    server_name  wds.harbor.com;
    client_max_body_size 1000m;
    location / {
        proxy_pass http://127.0.0.1:8000;
    }
}' > /etc/nginx/conf.d/harbor.od.com.conf