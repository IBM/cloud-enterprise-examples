provider "ibm" {
  region             = "us-south"
  generation         = 2
}

data "ibm_resource_group" "group" {
  name = "Default"
}

resource "ibm_database" "db_instance" {
  name              = "sampledb"
  plan              = "standard"
  location          = "us-south"
  service           = "databases-for-mongodb"
  resource_group_id = data.ibm_resource_group.group.id

  adminpassword                = "P@ssW0rd"
  members_memory_allocation_mb = "3072"
  members_disk_allocation_mb   = "61440"
}

output "db_connection_composed" {
  value = ibm_database.db_instance.connectionstrings.0.composed
}
output "db_connection_certbase64" {
  value = ibm_database.db_instance.connectionstrings.0.certbase64
}
// output "db_connection_string" {
//   value = ibm_database.db_instance.connectionstrings.0
// }
// output "instance" {
//   value = ibm_database.db_instance
// }
