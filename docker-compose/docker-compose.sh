#!/bin/bash

yum install -y nginx

echo 'server {
    listen       80;
    server_name  wds.harbor.com;
    client_max_body_size 1000m;
    location / {
        proxy_pass http://127.0.0.1:180;
    }
}' > /etc/nginx/conf.d/wds.harbor.com.conf