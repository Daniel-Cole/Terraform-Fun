resource "google_compute_firewall" "terraform-default" {
  name    = "terraform-default"
  network = "${google_compute_network.vpc_network.name}"

  allow {
    protocol = "icmp"
  }

  allow {
    protocol      = "tcp"
    ports         = ["22"]
  }

  source_ranges = ["${var.allowed_ssh_ips}"]

  target_tags = ["terraform"]
}
