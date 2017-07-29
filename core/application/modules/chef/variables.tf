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
variable "vpc_network" {
  description = "The name of the network for the deployment"
  default     = "vpc-terraformed"
}

variable "network" {
  default = "default"
}

variable "subnetwork" {
  default = "default"
}

#VM defaults
variable "default_image" {
  default     = "ubuntu-os-cloud/ubuntu-1404-trusty-v20170718"
}
