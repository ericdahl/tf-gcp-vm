resource "google_compute_network" "default" {
  name                    = "tf-gcp-vm"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "public" {
  name          = "public"
  network       = google_compute_network.default.name
  ip_cidr_range = "10.0.0.0/24"
  region        = "us-west2"
}


resource "google_compute_firewall" "icmp_all" {
  name    = "icmp-all"
  network = google_compute_network.default.name

  allow {
    protocol = "icmp"
  }

  source_ranges = ["0.0.0.0/0"]
}

resource "google_compute_firewall" "http" {
  name    = "http"
  network = google_compute_network.default.name

  allow {
    protocol = "tcp"
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["web"]
}

resource "google_compute_firewall" "ssh" {
  name    = "ssh"
  network = google_compute_network.default.name

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = [var.admin_cidr]
  target_tags   = ["ssh"]
}

resource "google_compute_router" "default" {
  name    = "tf-gcp-vm"
  network = google_compute_network.default.name



}

resource "google_compute_router_nat" "default" {
  name                               = "tf-gcp-vm"
  router                             = google_compute_router.default.name
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"
}