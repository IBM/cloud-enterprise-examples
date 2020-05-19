variable "project_name" {}
variable "environment" {}

variable "port" {
  default = 8080
}

variable "resource_group" {
  default = "Default"
}
variable "region" {
  default = "us-south"
}
variable "vpc_zone_names" {
  type    = list(string)
  default = ["us-south-1", "us-south-2", "us-south-3"]
}

locals {
  max_size = length(var.vpc_zone_names)
}
