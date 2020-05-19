provider "ibm" {
  generation         = 2
  region             = "us-south"
}

variable "public_key_file"  { default = "~/.ssh/id_rsa.pub" }
locals {
  public_key    = file(pathexpand(var.public_key_file))
}

variable "ssh_key_name" {}

resource "ibm_is_ssh_key" "iac_shared_ssh_key" {
  name       = var.ssh_key_name
  public_key = local.public_key
}

output "id" {
  value = ibm_is_ssh_key.iac_shared_ssh_key.id
}
output "ibm_cloud_url" {
  value = ibm_is_ssh_key.iac_shared_ssh_key.resource_controller_url
}
