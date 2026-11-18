resource "google_compute_address" "respo_quotes" {
  name         = "respo-quotes-public-ip"
  region       = var.region
  address_type = "EXTERNAL"
  network_tier = "PREMIUM"
}