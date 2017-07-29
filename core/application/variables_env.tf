variable "dmz_subnet" {
  default = "10.0.0.0/26"
}

variable "app_subnet" {
  default = "10.0.0.64/26"
}

variable "db_subnet" {
  default = "10.0.0.128/26"
}

variable "factory_subnet" {
  default = "10.0.0.192/26"
}

variable "allowed_ssh_ips" {
  default = ["0.0.0.0/32"]
}
