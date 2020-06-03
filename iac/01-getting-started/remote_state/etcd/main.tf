variable "prefix" {}
variable "etcd_admin_password" {
  default = "$uPerSeCre7Pa55w0r"
}

variable "region" {
  default = "us-south"
}

provider "ibm" {
  generation = 2
  region     = var.region
}

data "ibm_resource_group" "group" {
  name = "Default"
}

resource "ibm_database" "etcd_terraform_remote_state" {
  name                         = "${var.prefix}-remote-state"
  plan                         = "standard"
  location                     = var.region
  service                      = "databases-for-etcd"
  resource_group_id            = data.ibm_resource_group.group.id
  adminpassword                = var.etcd_admin_password
  members_memory_allocation_mb = 3072
  members_disk_allocation_mb   = 61440

  tags = ["${var.prefix}", "terraform", "remote state"]
}

// resource "ibm_resource_instance" "terraform_state_cos_instance" {
//   name     = "${var.prefix}-cos-instance"
//   service  = "cloud-object-storage"
//   plan     = "standard"
//   location = "global"
// }

// resource "ibm_cos_bucket" "terraform_state_cos_bucket" {
//   bucket_name          = "${var.prefix}-bucket"
//   resource_instance_id = ibm_resource_instance.terraform_state_cos_instance.id
//   region_location      = var.region
//   storage_class        = "smart"
// }

output "etcd_endpoint" {
  value = ibm_database.etcd_terraform_remote_state.connectionstrings[0].composed
}
output "etcd_certname" {
  value = ibm_database.etcd_terraform_remote_state.connectionstrings[0].certname
}
output "etcd_certbase64" {
  value = ibm_database.etcd_terraform_remote_state.connectionstrings[0].certbase64
}
output "etcd_user" {
  value = ibm_database.etcd_terraform_remote_state.adminuser
}
output "etcd_password" {
  value = ibm_database.etcd_terraform_remote_state.adminpassword
}
// output "etcd" {
//   value = ibm_database.etcd_terraform_remote_state
// }
