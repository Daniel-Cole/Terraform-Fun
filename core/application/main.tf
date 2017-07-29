# See https://cloud.google.com/compute/docs/load-balancing/network/example
provider "google" {
  region      = "${var.region}"
  project     = "${var.project_name}"
  credentials = "${file("${var.credentials_file_path}")}"
}


#set up network
module "vpc" {
  source = "./modules/vpc"

  region                = "${var.region}"
  project_name          = "${var.project_name}"
  credentials_file_path = "${var.credentials_file_path}"

  dmz_subnet            = "${var.dmz_subnet}"
  app_subnet            = "${var.app_subnet}"
  db_subnet             = "${var.db_subnet}"
  factory_subnet        = "${var.factory_subnet}"

  allowed_ssh_ips       = "${var.allowed_ssh_ips}"

}

#set up chef-server
module "chef" {
  source                = "./modules/chef"

  region                = "${var.region}"
  region_zone           = "${var.region_zone}"
  project_name          = "${var.project_name}"
  credentials_file_path = "${var.credentials_file_path}"

  default_image         = "${var.default_image}"
  network               = "${module.vpc.network}"
  subnetwork            = "${module.vpc.factory_subnet}"

}
