output "cluster_id" {
  value = ibm_container_vpc_cluster.iac_iks_cluster.id
}
output "cluster_name" {
  value = ibm_container_vpc_cluster.iac_iks_cluster.name
}
output "entrypoint" {
  value = ibm_container_vpc_cluster.iac_iks_cluster.public_service_endpoint_url
}

output "db_connection_string" {
  value = ibm_database.iac_app_db_instance.connectionstrings.0.composed
}
output "db_connection_certbase64" {
  value = ibm_database.iac_app_db_instance.connectionstrings.0.certbase64
}
output "db_admin_userid" {
  value = ibm_database.iac_app_db_instance.adminuser
}
output "db_id" {
  value = ibm_database.iac_app_db_instance.id
}
output "db_password" {
  value = var.db_admin_password
}
