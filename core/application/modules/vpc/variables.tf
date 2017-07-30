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
variable "environment" {
  default = "0"
}

variable "network" {
  description = "The name of the network for the deployment"
  default     = "default"
}

variable "dmz_subnet" {
  default     = "10.0.0.0/26"
}

variable "app_subnet" {
  default     = "10.0.0.64/26"
}

variable "db_subnet" {
  default     = "10.0.0.128/26"
}

variable "factory_subnet" {
  default     = "10.0.0.192/26"
}



variable "allowed_ssh_ips" {
  default = ["0.0.0.0/32"]
}
