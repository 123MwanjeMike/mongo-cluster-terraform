resource "google_compute_disk" "mongod_shard_0_2" {
  image                     = var.os["ubuntu-focal"]
  name                      = "mongod-shard-0-2"
  physical_block_size_bytes = 4096
  project                   = var.project_id
  size                      = var.disk_size["medium"]
  type                      = "pd-standard"
  zone                      = var.zone["a"]
  description               = "Disk for a mongodb sharded cluster shard instance"
}
# terraform import google_compute_disk.mongod_shard_0_2 projects/${var.project_id}/zones/${var.zone["b"]}/disks/mongod-shard-0-2


resource "google_compute_instance" "mongod_shard_0_2" {
  boot_disk {
    auto_delete = false
    source      = google_compute_disk.mongod_shard_0_2.self_link
  }

  machine_type = "e2-highmem-2"
  
  allow_stopping_for_update = true

  metadata = {
    startup-script = "sudo ufw allow ssh"
  }

  name = "mongod-shard-0-2"

  network_interface {
    access_config {
      network_tier = "PREMIUM"
    }
    
    subnetwork = var.mongo_db_subnet
    network_ip = "10.0.0.8"
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
    scopes = ["https://www.googleapis.com/auth/devstorage.read_only", "https://www.googleapis.com/auth/logging.write", "https://www.googleapis.com/auth/monitoring.write", "https://www.googleapis.com/auth/service.management.readonly", "https://www.googleapis.com/auth/servicecontrol", "https://www.googleapis.com/auth/trace.append"]
  }

  zone = var.zone["a"]
}
# terraform import google_compute_instance.mongod_shard_0_2 projects/${var.project_id}/zones/${var.zone["b"]}/instances/mongod-shard-0-2
