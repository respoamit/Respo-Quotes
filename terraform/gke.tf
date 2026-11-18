resource "google_service_account" "gke_nodes" {
  account_id   = "respo-gke-nodes"
  display_name = "Respo Quotes GKE node service account"
}

resource "google_project_iam_member" "gke_logging" {
  project = var.project_id
  role    = "roles/logging.logWriter"
  member  = "serviceAccount:${google_service_account.gke_nodes.email}"
}

resource "google_project_iam_member" "gke_monitoring" {
  project = var.project_id
  role    = "roles/monitoring.metricWriter"
  member  = "serviceAccount:${google_service_account.gke_nodes.email}"
}

resource "google_project_iam_member" "gke_artifact_reader" {
  project = var.project_id
  role    = "roles/artifactregistry.reader"
  member  = "serviceAccount:${google_service_account.gke_nodes.email}"
}


resource "google_container_cluster" "respo" {
  name     = "respo-quotes-gke"
  location = var.zone

  network    = google_compute_network.vpc.id
  subnetwork = google_compute_subnetwork.gke.id

  networking_mode = "VPC_NATIVE"

  remove_default_node_pool = true
  initial_node_count       = 1

  deletion_protection = false

  addons_config {
    http_load_balancing {
      disabled = false
    }
  }

  release_channel {
    channel = "REGULAR"
  }

  ip_allocation_policy {
    cluster_secondary_range_name  = "gke-pods"
    services_secondary_range_name = "gke-services"
  }

  private_cluster_config {
    enable_private_nodes    = true
    enable_private_endpoint = false
    master_ipv4_cidr_block  = "172.16.0.0/28"
  }

  workload_identity_config {
    workload_pool = "${var.project_id}.svc.id.goog"
  }
}


resource "google_container_node_pool" "respo" {
  name     = "respo-quotes-pool"
  cluster  = google_container_cluster.respo.id
  location = var.zone

  autoscaling {
    min_node_count = 1
    max_node_count = 2
  }

  management {
    auto_repair  = true
    auto_upgrade = true
  }

  node_config {
    machine_type = "e2-standard-2"

    service_account = google_service_account.gke_nodes.email

    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]

    labels = {
      application = "respo-quotes"
    }

    tags = [
      "respo-quotes-gke"
    ]
  }
}