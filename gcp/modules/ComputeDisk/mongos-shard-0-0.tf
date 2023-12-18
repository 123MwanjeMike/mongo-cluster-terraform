resource "google_compute_disk" "mongod_shard_0_0" {
  image                     = var.os["ubuntu-focal"]
  name                      = "mongod-shard-0-0"
  physical_block_size_bytes = 4096
  project                   = var.project_id
  size                      = var.disk_size["medium"]
  type                      = "pd-standard"
  zone                      = var.zone["b"]
  description               = "Disk for a mongodb sharded cluster shard instance"
}
# terraform import google_compute_disk.mongod_shard_0_0 projects/${var.project_id}/zones/${var.zone["b"]}/disks/mongod-shard-0-0
