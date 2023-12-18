resource "google_compute_instance" "mongod_shard_0_1" {
  boot_disk {
    auto_delete = false
    source      = "mongod-shard-0-1"
  }

  machine_type = "e2-highmem-2"
  
  allow_stopping_for_update = true

  metadata = {
    startup-script = "sudo ufw allow ssh"
  }

  name = "mongod-shard-0-1"

  network_interface {
    network    = "databases"
    subnetwork = "mongo-db"
    network_ip = "10.132.0.49"
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

  zone = var.zone["c"]
}
# terraform import google_compute_instance.mongod_shard_0_1 projects/${var.project_id}/zones/${var.zone["b"]}/instances/mongod-shard-0-1