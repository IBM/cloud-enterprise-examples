output "ip_address" {
  value = ibm_is_floating_ip.iac_app_floating_ip[*].address
}

output "lb_ip_address" {
  value = ibm_is_lb.iac_app_lb.public_ips
}

output "entrypoint" {
  value = "http://${ibm_is_lb.iac_app_lb.hostname}:${var.port}"
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
output "db_version" {
  value = ibm_database.iac_app_db_instance.version
}
