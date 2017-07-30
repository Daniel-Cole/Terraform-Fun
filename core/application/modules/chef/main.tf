provider "google" {
    region      = "${var.region}"
    project     = "${var.project_name}"
    credentials = "${file("${var.credentials_file_path}")}"
}

resource "google_compute_instance" "chef_server" {

  #set instance types in variable
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

  #move all certs into single directory?
  provisioner "file" {
    source      = "${var.chef_crt_src}"
    destination = "${var.chef_crt_dst}"

    connection {
      type        = "ssh"
      user        = "terraform"
      private_key = "${file("${var.private_key_path}")}"
      agent       = false
    }
  }

  provisioner "file" {
    source      = "${var.chef_key_src}"
    destination = "${var.chef_key_dst}"

    connection {
      type        = "ssh"
      user        = "terraform"
      private_key = "${file("${var.private_key_path}")}"
      agent       = false
    }
  }

  provisioner "file" {
    source      = "${path.module}/${var.install_script_src_path}"
    destination = "${var.install_script_dest_path}"

    connection {
      type        = "ssh"
      user        = "terraform"
      private_key = "${file("${var.private_key_path}")}"
      agent       = false
    }
  }

  provisioner "remote-exec" {
    connection {
      type        = "ssh"
      user        = "terraform"
      private_key = "${file("${var.private_key_path}")}"
      agent       = false
    }


    inline = [
     "chmod 700 ${var.install_script_dest_path}",
     "sudo /bin/bash ${var.install_script_dest_path} ${var.chef_username} ${var.chef_email} ${var.chef_password} ${var.chef_organisation} ${var.chef_org_shortname} ${var.chef_crt_dst} ${var.chef_first_name} ${var.chef_last_name}",
    ]
  }

  #allow read access to gs for rpms
  service_account {
    scopes = ["https://www.googleapis.com/auth/devstorage.read_only"]
  }

  tags = ["factory", "terraform", "chef-server"]

}
