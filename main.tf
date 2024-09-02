provider "google" {
  project = var.project
  region  = "us-west2"

  default_labels = {
    name = "tf-gcp-vm"
  }
}



