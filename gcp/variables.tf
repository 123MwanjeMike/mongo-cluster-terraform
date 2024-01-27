variable "project_id" {
  description = "GCP project ID"
}

variable "project_number" {
  description = "GCP project number"
}

variable "region" {
  default     = "europe-north1"
  description = "Default region"
}

variable "zone" {
  default = {
    "a" = "europe-north1-a"
    "b" = "europe-north1-b"
    "c" = "europe-north1-c"
  }
  description = "Available zones in the default project region (europe-north1)"
}

variable "os" {
  default = {
    "ubuntu-jammy" = "ubuntu-2204-jammy-v20230425"
    "ubuntu-focal" = "ubuntu-2004-focal-v20220712"
  }
  description = "Operating systems to use"
}

variable "disk_size" {
  default = {
    "small"  = "20"
    "medium" = "50"
  }
  description = "Disk sizes to use"
}

variable "replica_size" {
  default     = 3
  description = "Number of instances in a replica set"
}