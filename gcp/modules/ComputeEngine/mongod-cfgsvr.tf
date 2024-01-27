resource "google_compute_instance" "mongod_cfgsvr" {
  count = var.replica_size

  boot_disk {
    initialize_params {
        image = var.os
        size  = var.disk_size["small"]
        type  = "pd-standard"
    }
  }

  allow_stopping_for_update = true
  machine_type              = "e2-standard-2"
  metadata = {
    startup-script = "sudo ufw allow ssh"
  }
  name = "mongod-cfgsvr-${count.index}"
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

  tags = ["mongod-config-server", "mongodb-cluster"]
  zone = var.zone[sort(keys(var.zone))[count.index]]
}
