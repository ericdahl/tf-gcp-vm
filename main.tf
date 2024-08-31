provider "google" {
  project = var.project
  region      = "us-west1"    # Specify the region

  default_labels = {
    name = "tf-gcp-vm"
  }
}



resource "google_compute_instance" "default" {
  name         = "tf-gcp-vm"
  machine_type = "e2-medium"
  zone         = "us-west1-a"

  # Define the boot disk
  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-12"
    }
  }

  network_interface {
    network = "default"

    access_config {
    }
  }

  metadata = {
    ssh-keys = var.ssh_key
  }

  tags = ["web", "dev"]
}

