provider "ibm" {
  generation = 2
  region     = "us-south"
}

data "ibm_resource_group" "group" {
  name = "Default"
}
