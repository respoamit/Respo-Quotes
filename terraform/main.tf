terraform {
  required_version = ">= 1.0"

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 8.2"
    }
  }

  backend "gcs" {
    bucket = "tfstate-protean-beaker-508610-j3"
    prefix = "respo-quotes"
  }
}

provider "google" {
  project = var.project_id
  region  = var.region
  zone    = var.zone
}