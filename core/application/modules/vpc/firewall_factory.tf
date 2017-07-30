resource "google_compute_firewall" "terraform-chef-https" {
  name    = "terraform-chef-https"
  network = "${google_compute_network.network.name}"

  allow {
    protocol      = "tcp"
    ports         = ["443", "80"]
  }

  source_ranges = [
    "${var.allowed_ssh_ips}",
    "${var.dmz_subnet}",
    "${var.app_subnet}",
    "${var.factory_subnet}"
  ]

  target_tags = ["chef-server"]
}
