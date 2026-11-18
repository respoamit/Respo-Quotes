output "gke_cluster_name" {
  value = google_container_cluster.respo.name
}

output "gke_cluster_location" {
  value = google_container_cluster.respo.location
}

output "gke_node_pool" {
  value = google_container_node_pool.respo.name
}

output "respo_quotes_public_ip" {
  value = google_compute_address.respo_quotes.address
}

output "respo_quotes_global_ip" {
  value = google_compute_global_address.respo_quotes.address
}