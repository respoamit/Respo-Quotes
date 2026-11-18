resource "google_artifact_registry_repository" "respo_quotes" {
  location      = var.region
  repository_id = "respo-quotes"
  description   = "Container images for Respo Quotes"
  format        = "DOCKER"
}