resource "google_compute_network" "vpc" {
  name                    = "respo-quotes-vpc"
  auto_create_subnetworks = false

}

resource "google_compute_subnetwork" "gke" {
  name          = "respo-quotes-gke-subnet"
  region        = var.region
  network       = google_compute_network.vpc.id
  ip_cidr_range = "10.10.0.0/16"

  secondary_ip_range {
    range_name    = "gke-pods"
    ip_cidr_range = "10.20.0.0/16"
  }

  secondary_ip_range {
    range_name    = "gke-services"
    ip_cidr_range = "10.30.0.0/20"
  }


  private_ip_google_access = true
}

resource "google_compute_router" "router" {
  name    = "respo-quotes-router"
  region  = var.region
  network = google_compute_network.vpc.id
}

resource "google_compute_router_nat" "nat" {
  name                               = "respo-quotes-nat"
  router                             = google_compute_router.router.name
  region                             = var.region
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"

  log_config {
    enable = true
    filter = "ERRORS_ONLY"
  }
}