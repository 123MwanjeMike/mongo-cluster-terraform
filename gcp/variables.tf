variable "project_id" {
  default     = "oceanic-muse-408212"
  description = "GCP project ID"
}

variable "project_number" {
  default     = "903857880702"
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
    "ubuntu-focal" = "ubuntu-2004-focal-v20220712"
    "ubuntu-jammy" = "ubuntu-2204-jammy-v20230425"
  }
  description = "Operating systems to use"
}

variable "disk_size" {
  default = {
    "tiny"   = "10"
    "small"  = "20"
    "medium" = "50"
    "large"  = "100"
    "huge"   = "200"
  }
  description = "Disk sizes to use"
}
