module "resources" {
  ## Uncomment the path with the cloud service provider of choice.
  #   source = "./aws"
  #   source = "./azure"
  source = "./gcp"

  project_id = var.gcp_project_id
  project_number = var.gcp_project_number
}
