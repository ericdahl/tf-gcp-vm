resource "google_compute_instance" "jumphost" {
  name = "tf-gcp-vm-jumphost"
  #   name         = "tf-gcp-vm"
  machine_type = "e2-medium"
  zone         = "us-west2-a"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-12"
    }
  }

  network_interface {
    network    = google_compute_network.default.name
    subnetwork = google_compute_subnetwork.public.name

    access_config {
    }
  }

  metadata = {
    ssh-keys = var.ssh_key
  }

  metadata_startup_script = "apt install -y htop netcat-openbsd"

  tags = ["ssh"]
}