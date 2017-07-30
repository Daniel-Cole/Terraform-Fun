#VPC
resource "google_compute_network" "network" {
  name = "${var.network}"
  auto_create_subnetworks = "false"
}

#setup subnets
resource "google_compute_subnetwork" "dmz_subnet" {
  name          = "dmz-subnet-${var.environment}"
  ip_cidr_range = "${var.dmz_subnet}"
  network       = "${google_compute_network.network.self_link}"
  region        = "${var.region}"
}

resource "google_compute_subnetwork" "app_subnet" {
  name          = "app-subnet-${var.environment}"
  ip_cidr_range = "${var.app_subnet}"
  network       = "${google_compute_network.network.self_link}"
  region        = "${var.region}"
}

resource "google_compute_subnetwork" "db_subnet" {
  name          = "db-subnet-${var.environment}"
  ip_cidr_range = "${var.db_subnet}"
  network       = "${google_compute_network.network.self_link}"
  region        = "${var.region}"
}

resource "google_compute_subnetwork" "factory_subnet" {
  name          = "factory-subnet-${var.environment}"
  ip_cidr_range = "${var.factory_subnet}"
  network       = "${google_compute_network.network.self_link}"
  region        = "${var.region}"
}
