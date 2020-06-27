resource "ibm_database" "iac_app_db_instance" {
  name              = var.db_name
  plan              = var.db_plan
  location          = var.region
  service           = "databases-for-mongodb"
  resource_group_id = data.ibm_resource_group.group.id
  service_endpoints = "private"

  adminpassword                = var.db_admin_password
  members_memory_allocation_mb = var.db_memory_allocation
  members_disk_allocation_mb   = var.db_disk_allocation
}
