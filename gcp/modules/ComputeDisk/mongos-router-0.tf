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
