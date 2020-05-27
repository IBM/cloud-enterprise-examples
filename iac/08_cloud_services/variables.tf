variable "project_name" {}
variable "environment" {}

variable "public_key" {}

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

variable "db_plan" {
  default = "standard"
}
variable "db_name" {
  default = "ex2_test_db_lab"
}
variable "db_admin_password" {
  default = "password123"
}
variable "db_memory_allocation" {
  default = "3072"
}
variable "db_disk_allocation" {
  default = "61440"
}

// variable "db_user_username"{
//   default = "admin"
// }
// variable "db_user_password" {
//   default = "password123"
// }
