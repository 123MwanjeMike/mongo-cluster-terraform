resource "google_compute_disk" "mongos_router_0" {
  image                     = var.os["ubuntu-focal"]
  name                      = "mongos-router-0"
  physical_block_size_bytes = 4096
  project                   = var.project_id
  size                      = var.disk_size["small"]
  type                      = "pd-standard"
  zone                      = var.zone["b"]
  description               = "Disk for the mongos-router-0 instance"
}
# terraform import google_compute_disk.mongos_router_0 projects/${var.project_id}/zones/${var.zone["b"]}/disks/mongos-router-0


resource "google_compute_instance" "mongos_router_0" {
  boot_disk {
    auto_delete = false
    source      = google_compute_disk.mongos_router_0.self_link
  }

  labels = {
    "env"  = "prod"
  }
  
  allow_stopping_for_update = true

  machine_type = "e2-small"

  metadata = {
    startup-script = "sudo ufw allow ssh"
  }

  name = "mongos-router-0"

  network_interface {
    access_config {
      network_tier = "PREMIUM"
    }
    
    subnetwork = var.mongo_db_subnet
    network_ip = "10.0.0.9"
  }

  project = var.project_id

  reservation_affinity {
    type = "ANY_RESERVATION"
  }

  scheduling {
    automatic_restart   = true
    on_host_maintenance = "MIGRATE"
    provisioning_model  = "STANDARD"
  }

  service_account {
    email  = "${var.project_number}-compute@developer.gserviceaccount.com"
    scopes = ["https://www.googleapis.com/auth/cloud-platform"]
  }

  tags = ["http-server", "https-server"]
  zone = var.zone["b"]
}
# terraform import google_compute_instance.mongos_router_0 projects/${var.project_id}/zones/${var.zone["b"]}/instances/mongos-router-0
