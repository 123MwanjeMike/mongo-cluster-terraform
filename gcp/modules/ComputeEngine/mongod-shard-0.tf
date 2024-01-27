resource "google_compute_instance" "mongod_shard_0" {
  count = var.replica_size

  boot_disk {
    initialize_params {
        image = var.os["ubuntu-focal"]
        size  = var.disk_size["medium"]
        type  = "pd-standard"
    }
  }

  machine_type = "e2-highmem-2"
  
  allow_stopping_for_update = true

  metadata = {
    startup-script = "sudo ufw allow ssh"
  }

  name = "mongod-shard-0-${count.index}"

  network_interface {
    access_config {
      network_tier = "PREMIUM"
    }
    
    subnetwork = var.mongo_db_subnet
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

  tags = ["mongod-shard", "mongodb-cluster"]

  zone = var.zone[sort(keys(var.zone))[count.index]]
}
