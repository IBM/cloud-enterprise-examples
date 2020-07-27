variable "project_name" {}
variable "environment" {}

variable "resource_group" {
  default = "Default"
}
variable "region" {
  default = "us-east"
}
variable "vpc_zone_names" {
  type    = list
  default = ["us-east-1"]
}
variable "flavors" {
  type    = list
  default = ["mx2.4x32"]
}
variable "workers_count" {
  type    = list
  default = [2]
}
variable "k8s_version" {
  default = "4.4_openshift"
}

locals {
  max_size = length(var.vpc_zone_names)
}
