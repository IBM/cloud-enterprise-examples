variable "public_key_file" { default = "~/.ssh/id_rsa.pub" }
locals {
  public_key = "${file(pathexpand(var.public_key_file))}"
}

variable "port" {
  default = 8080
}
