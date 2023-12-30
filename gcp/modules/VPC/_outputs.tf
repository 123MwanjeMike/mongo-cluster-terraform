output "mongo_db_subnet" {
  value       = google_compute_subnetwork.mongo_db.self_link
  description = "Self link for mongo-db subnet"
}
