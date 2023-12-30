resource "google_compute_network" "databases" {
  name                    = "databases"
  auto_create_subnetworks = false
  mtu                     = 8896
}

resource "google_compute_subnetwork" "mongo_db" {
  name          = "mongo-db"
  ip_cidr_range = "10.0.0.0/28"
  region        = var.region
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
  source_ranges = [google_compute_subnetwork.mongo_db.ip_cidr_range]
}
