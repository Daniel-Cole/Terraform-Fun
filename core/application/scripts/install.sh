#!/bin/bash

set -xe

RESOURCE_INDEX=$1
sudo yum update -y
sudo yum install -y install nginx
IP=$(curl -s -H "Metadata-Flavor:Google" http://metadata/computeMetadata/v1/instance/network-interfaces/0/ip)
echo "Welcome to Resource ${RESOURCE_INDEX} - ${HOSTNAME} (${IP})" > /usr/share/nginx/html/index.html
sudo service nginx start
