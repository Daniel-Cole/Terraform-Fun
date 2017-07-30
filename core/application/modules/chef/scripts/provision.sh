#!/bin/bash
set -x
#https://docs.chef.io/install_server.html#prerequisites

#use the terraform user to

#Chef needs to be loaded up first in the deployment
#Loads chef server rpm and cookbooks from bucket
USER_NAME=$1
EMAIL=$2
PASSWORD=$3
ORG_SHORT_NAME=$4
ORG=$5
TERRAFORM_PUBLIC_CRT=$6
FIRST_NAME=$7
LAST_NAME=$8

CHEF_SERVER_INSTALLER=/tmp/chef-server.rpm
CHEF_MANAGE_INSTALLER=/tmp/chef-manage.rpm

#path for chef server binaries
CHEF_PATH=/opt/opscode/bin

#download artifacts
gsutil cp "gs://terraformed-daniel-cole/artifacts/chef-server-core-12.15.8-1.el7.x86_64.rpm" $CHEF_SERVER_INSTALLER
gsutil cp "gs://terraformed-daniel-cole/artifacts/chef-manage-2.5.4-1.el7.x86_64.rpm" $CHEF_MANAGE_INSTALLER

#install chef server
sudo rpm -ivh $CHEF_SERVER_INSTALLER

echo "configuring chef server"
sudo ${CHEF_PATH}/chef-server-ctl reconfigure > /dev/null

#install chef manage
sudo ${CHEF_PATH}/chef-server-ctl install chef-manage --path $CHEF_MANAGE_INSTALLER

echo "reconfiguring chef server and manage"
sudo ${CHEF_PATH}/chef-server-ctl reconfigure > /dev/null

#chef manage-ctl gets added to /usr/bin but chef-server doesn't!
sudo chef-manage-ctl reconfigure --accept-license > /dev/null

#load self-signed cert into trusted certs folder
CHEF_SS_CERT_DIR=/var/opt/opscode/nginx/ca/
cat ${CHEF_SS_CERT_DIR}$(ls ${CHEF_SS_CERT_DIR} | grep 'crt') >> /opt/opscode/embedded/ssl/certs/cacert.pem

#create admin user, this spits out a private key for the user
sudo ${CHEF_PATH}/chef-server-ctl user-create $USER_NAME $FIRST_NAME $LAST_NAME $EMAIL $PASSWORD > /dev/null

#setup organisation
sudo ${CHEF_PATH}/chef-server-ctl org-create $ORG_SHORT_NAME $ORG --association_user $USER_NAME --filename /home/$USER_NAME/organisation-validator.pem

#set key for admin user
sudo ${CHEF_PATH}/chef-server-ctl delete-user-key $USER_NAME default
sudo ${CHEF_PATH}/chef-server-ctl add-user-key $USER_NAME -k chef -p $TERRAFORM_PUBLIC_CRT

echo 'export PATH=$PATH:/opt/opscode/bin' >> /home/$USER_NAME/.bash_profile


#initial set up of cookbooks
sudo yum install -y git

cd /home/$USER_NAME

#move cookbooks onto gs ?
git clone https://github.com/Daniel-Cole/chef.git

mkdir /home/$USER_NAME/.chef

#knife.rb file for debugging on host
cat << EOF > home/$USER_NAME/.chef/knife.rb
log_level                :info
log_location             STDOUT
node_name                'terraform'
client_key               '/home/terraform/.ssh/chef.key'
validation_client_name   'terraform'
validation_key           '/etc/chef-server/chef-validator.pem'
chef_server_url          'https://chef-server.c.terraform-app.internal/organizations/myorg'
syntax_check_cache_path  '/home/terraform/.chef/syntax_check_cache'
cookbook_path            ['~/chef/cookbooks/']
EOF


#set up cronjob to pull repo every 5min?
