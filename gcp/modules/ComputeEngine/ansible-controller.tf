resource "google_compute_disk" "ansible_controller" {
  image                     = var.os["ubuntu-focal"]
  name                      = "ansible-controller"
  physical_block_size_bytes = 4096
  project                   = var.project_id
  size                      = var.disk_size["small"]
  type                      = "pd-standard"
  zone                      = var.zone["b"]
  description               = "Disk for the ansible-controller instance"
}
# terraform import google_compute_disk.ansible_controller projects/${var.project_id}/zones/${var.zone["b"]}/disks/ansible-controller


resource "google_compute_instance" "ansible_controller" {
  boot_disk {
    auto_delete = false
    source      = google_compute_disk.ansible_controller.self_link
  }
  
  machine_type = "e2-small"
  
  allow_stopping_for_update = true

  metadata = {
    startup-script = "sudo ufw allow ssh"
    ssh-keys       = "mike:${file("~/.ssh/id_rsa.pub")}"
  }

  name = "ansible-controller"

  network_interface {
    access_config {
      network_tier = "PREMIUM"
    }

    network    = "databases"
    subnetwork = var.mongo_db_subnet
    network_ip = "10.0.0.2"
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

  zone = var.zone["b"]
  tags = ["http-server", "https-server"]
}
# terraform import google_compute_instance.ansible_controller projects/${var.project_id}/zones/${var.zone["b"]}/instances/ansible-controller