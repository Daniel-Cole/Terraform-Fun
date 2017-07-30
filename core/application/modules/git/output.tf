output git_server_internal_ip {
  value = "${google_compute_instance.git_server.network_interface.0.address}"
}
