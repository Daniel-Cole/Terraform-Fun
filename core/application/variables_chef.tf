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
