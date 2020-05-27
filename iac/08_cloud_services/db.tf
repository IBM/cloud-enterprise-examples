resource "ibm_database" "iac_app_db_instance" {
  name              = var.db_name
  plan              = var.db_plan
  location          = var.region
  service           = "databases-for-mongodb"
  resource_group_id = data.ibm_resource_group.group.id

  adminpassword                = var.db_admin_password
  members_memory_allocation_mb = var.db_memory_allocation
  members_disk_allocation_mb   = var.db_disk_allocation
}

##############################################################################
# Grant User Access to Database
# For simplification, this block is not used. You can assign access policies at the
# account, resource group, service, instance using this type of block.
##############################################################################
# resource "ibm_iam_access_group_policy" "ex2_db_policy" {
#  access_group_id = ibm_iam_access_group.labuser.id
#  roles        = ["Reader"]

#  resources = [{
#    service = "databases-for-mongodb"
#    resource_instance_id = element(split(":", ibm_database.db_instance.id),7)
#  }
#  ]
# }
##############################################################################
