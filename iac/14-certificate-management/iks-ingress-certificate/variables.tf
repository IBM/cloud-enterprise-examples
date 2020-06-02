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
  default = ["us-south-1"]
}
variable "flavors" {
  type    = list(string)
  default = ["cx2.2x4"]
}
variable "workers_count" {
  type    = list(number)
  default = [2]
}
variable "k8s_version" {
  default = "1.18"
}

locals {
  max_size = length(var.vpc_zone_names)
}
