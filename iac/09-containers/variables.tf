variable "project_name" {}
variable "environment" {}

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
variable "flavors" {
  type    = list(string)
  default = ["cx2.2x4", "cx2.4x8", "cx2.8x16"]
}
variable "workers_count" {
  type    = list(number)
  default = [3, 2, 1]
}
variable "k8s_version" {
  default = "1.18.3"
}

locals {
  max_size = length(var.vpc_zone_names)
}
