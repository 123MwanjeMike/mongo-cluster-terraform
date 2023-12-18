provider "google" {
  project     = var.project_id
  region      = var.region
  credentials = file("../terraform-sa-key.json")
}

# Create a Google Cloud Platform network
resource "google_compute_network" "databases" {
  name                    = "databases"
  auto_create_subnetworks = false
  mtu                     = 8896
}

resource "google_compute_subnetwork" "mongod-db" {
  name          = "mongo-db"
  ip_cidr_range = "10.132.0.32/27"
  region        = "europe-north1"
  network       = google_compute_network.databases.self_link
}


module "ComputeDisk" {
  source = "./modules/ComputeDisk"

  project_id = var.project_id
  zone       = var.zone
  os         = var.os
  disk_size  = var.disk_size
}

module "ComputeInstance" {
  source = "./modules/ComputeInstance"

  project_id     = var.project_id
  project_number = var.project_number
  region         = var.region
  zone           = var.zone
  os             = var.os
  disk_size      = var.disk_size
}
