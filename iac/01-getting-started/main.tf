provider "ibm" {
  generation = 2
  region     = "us-south"
}

resource "ibm_is_ssh_key" "iac_test_key" {
  name       = "terraform-test-key"
  public_key = local.public_key
}

resource "ibm_is_instance" "iac_test_instance" {
  name    = "terraform-test-instance"
  image   = "r006-14140f94-fcc4-11e9-96e7-a72723715315"
  profile = "cx2-2x4"

  primary_network_interface {
    name            = "eth1"
    subnet          = ibm_is_subnet.iac_test_subnet.id
    security_groups = [ibm_is_security_group.iac_test_security_group.id]
  }

  vpc  = ibm_is_vpc.iac_test_vpc.id
  zone = "us-south-1"
  keys = [ibm_is_ssh_key.iac_test_key.id]

  user_data = <<-EOUD
              #!/bin/bash
              echo "Hello World" > index.html
              nohup busybox httpd -f -p ${var.port} &
              EOUD

  tags = ["iac-terraform-test"]
}
