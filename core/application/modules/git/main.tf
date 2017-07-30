provider "google" {
    region      = "${var.region}"
    project     = "${var.project_name}"
    credentials = "${file("${var.credentials_file_path}")}"
}

resource "google_compute_instance" "git_server" {

  #use machine defined in variable
  name         = "git-server"
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

  provisioner "chef" {

    connection {
      type        = "ssh"
      user        = "terraform"
      private_key = "${file("${var.private_key_path}")}"
      agent       = false
    }

    attributes_json = <<-EOF
      {
        "key": "value",
        "factory": {
          "cluster1": {
            "nodes": ["git-server"]
          }
        }
      }
    EOF

    environment             = "_default"
    run_list                = ["output::default"]
    node_name               = "git-server"
    server_url              = "https://chef-server.c.terraform-app.internal/organizations/myorg/"
    recreate_client         = true
    user_name               = "terraform"
    user_key                = "${file("keys/chef.key")}"
    version                 = "12.19.36"
    fetch_chef_certificates = true
  }

  tags = ["factory", "terraform"]

}
