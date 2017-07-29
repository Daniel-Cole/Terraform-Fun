output "network" {
  value = "${google_compute_network.vpc_network.name}"
}

output "dmz_subnet" {
  value = "${google_compute_subnetwork.dmz_subnet.name}"
}

output "app_subnet" {
  value = "${google_compute_subnetwork.app_subnet.name}"
}

output "db_subnet" {
  value = "${google_compute_subnetwork.db_subnet.name}"
}

output "factory_subnet" {
  value = "${google_compute_subnetwork.factory_subnet.name}"
}
