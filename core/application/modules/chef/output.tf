output chef_server_internal_ip {
  value = "${google_compute_instance.chef_server.network_interface.0.address}"
}
