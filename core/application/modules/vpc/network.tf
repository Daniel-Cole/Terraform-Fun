#VPC
resource "google_compute_network" "vpc_network" {
  name = "${var.vpc_network}"
  auto_create_subnetworks = "false"
}

#setup subnets
resource "google_compute_subnetwork" "dmz_subnet" {
  name          = "dmz-subnet"
  ip_cidr_range = "${var.dmz_subnet}"
  network       = "${google_compute_network.vpc_network.self_link}"
  region        = "${var.region}"
}

resource "google_compute_subnetwork" "app_subnet" {
  name          = "app-subnet"
  ip_cidr_range = "${var.app_subnet}"
  network       = "${google_compute_network.vpc_network.self_link}"
  region        = "${var.region}"
}

resource "google_compute_subnetwork" "db_subnet" {
  name          = "db-subnet"
  ip_cidr_range = "${var.db_subnet}"
  network       = "${google_compute_network.vpc_network.self_link}"
  region        = "${var.region}"
}

resource "google_compute_subnetwork" "factory_subnet" {
  name          = "factory-subnet"
  ip_cidr_range = "${var.factory_subnet}"
  network       = "${google_compute_network.vpc_network.self_link}"
  region        = "${var.region}"
}
