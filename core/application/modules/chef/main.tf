provider "google" {
    region      = "${var.region}"
    project     = "${var.project_name}"
    credentials = "${file("${var.credentials_file_path}")}"
}

resource "google_compute_instance" "chef_server" {

  name         = "chef-server"
  machine_type = "custom-1-2048"
  zone         = "${var.region_zone}"

  disk {
    image = "${var.default_image}"
  }

  disk {
    type    = "pd-standard"
    size    = "10"
    image   = "${var.default_image}"
  }

  network_interface {
    subnetwork = "${var.subnetwork}"

    access_config {
      # Ephemeral
    }
  }

  tags = ["factory", "terraform"]

}
