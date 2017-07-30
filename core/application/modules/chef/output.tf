output chef_server_internal_ip {
  value = "${google_compute_instance.chef_server.network_interface.0.address}"
}

output chef_server_external_ip {
  value = "${google_compute_instance.chef_server.network_interface.0.access_config.0.assigned_nat_ip}"
}
