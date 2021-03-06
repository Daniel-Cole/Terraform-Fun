#GCE variables for project/region
variable "region" {
  default = "us-east"
}

variable "region_zone" {
  default = "us-east1-f"
}

variable "project_name" {
  description = "The ID of the Google Cloud project"
}

#Credentials
variable "credentials_file_path" {
  description = "Path to the JSON file used to describe your account credentials"
  default     = "~/.gcloud/Terraform.json"
}

variable "public_key_path" {
  description = "Path to file containing public key"
  default     = "~/.ssh/gcloud_id_rsa.pub"
}

variable "private_key_path" {
  description = "Path to file containing private key"
  default     = "~/.ssh/gcloud_id_rsa"
}


#Networks
variable "network" {
  default = "default"
}

variable "subnetwork" {
  default = "default"
}

#VM defaults
variable "default_image" {
  default = "ubuntu-os-cloud/ubuntu-1404-trusty-v20170718"
}

variable "install_script_src_path" {
  default = "scripts/provision.sh"
}

variable "install_script_dest_path" {
  default = "/tmp/provision.sh"
}

variable "chef_username" {
  default = "default-user"
}

variable "chef_password" {
  default = "password123"
}

variable "chef_email" {
  default = "default-user"
}

variable "chef_organisation" {
  default = "myorganisation"
}

variable "chef_org_shortname" {
  default = "myorg"
}

variable "chef_key_src" {
  default = "keys/chef.key"
}

variable "chef_key_dst" {
  default = "~/.ssh/chef.key"
}

variable "chef_crt_src" {
  default = "keys/chef.pub"
}

variable "chef_crt_dst" {
  default = "/tmp/chef.pub"
}

variable "chef_first_name" {
  default = "daniel"
}

variable "chef_last_name" {
  default = "cole"
}
