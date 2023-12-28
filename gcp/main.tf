provider "google" {
  project     = var.project_id
  region      = var.region
  credentials = file("../terraform-sa-key.json")
}

resource "google_compute_network" "databases" {
  name                    = "databases"
  auto_create_subnetworks = false
  mtu                     = 8896
}

resource "google_compute_subnetwork" "mongod_db" {
  name          = "mongo-db"
  ip_cidr_range = "10.0.0.0/28"
  region        = "europe-north1"
  network       = google_compute_network.databases.self_link
}

resource "google_compute_firewall" "allow_ssh_and_mongos" {
  name    = "allow-ssh-and-mongos"
  network = google_compute_network.databases.self_link
  allow {
    protocol = "tcp"
    ports    = ["22", "27017"]
  }
  source_ranges = ["0.0.0.0/0"]
}

resource "google_compute_firewall" "mongod_ports" {
  name    = "mongod-ports"
  network = google_compute_network.databases.self_link
  allow {
    protocol = "tcp"
    ports    = ["27018", "27019"]
  }
  source_ranges = ["10.0.0.0/28"]
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
