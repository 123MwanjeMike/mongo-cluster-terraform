provider "google" {
  project     = var.project_id
  region      = var.region
  credentials = file("gcp/terraform-sa-key.json")
}

module "ComputeEngine" {
  source = "./modules/ComputeEngine"

  project_id      = var.project_id
  project_number  = var.project_number
  region          = var.region
  zone            = var.zone
  os              = var.os
  disk_size       = var.disk_size
  mongo_db_subnet = module.VPC.mongo_db_subnet
}

module "VPC" {
  source = "./modules/VPC"

  region = var.region
  #  Outputs mongo_db_subnet
}
