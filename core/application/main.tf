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

  environment           = "${var.environment}"
  network               = "${var.network}"
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
  network               = "${var.network}"
  subnetwork            = "${module.vpc.factory_subnet}"

  private_key_path      = "${var.private_key_path}"

  chef_username         = "${var.chef_username}"
  chef_password         = "${var.chef_password}"
  chef_email            = "${var.chef_email}"
  chef_organisation     = "${var.chef_organisation}"
  chef_key_src          = "${var.chef_key_src}"
  chef_crt_src          = "${var.chef_crt_src}"
  chef_first_name       = "${var.chef_first_name}"
  chef_last_name        = "${var.chef_last_name}"

}

module "git" {
  source                = "./modules/git"

  region                = "${var.region}"
  region_zone           = "${var.region_zone}"
  project_name          = "${var.project_name}"
  credentials_file_path = "${var.credentials_file_path}"

  default_image         = "${var.default_image}"
  network               = "${module.vpc.network}"
  subnetwork            = "${module.vpc.factory_subnet}"

  private_key_path      = "${var.private_key_path}"

  chef_host             = "${module.chef.chef_server_external_ip}"
}
