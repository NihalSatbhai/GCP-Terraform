## WARNING = Never push your credentials to your public repository
terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.41.0"
    }
  }
}

provider "google" {
  credentials = file("../Credentials/admin.json") ## Passing admin.json as authentication source which we generated from service account of GCP
  project     = var.project
  region      = var.region
}