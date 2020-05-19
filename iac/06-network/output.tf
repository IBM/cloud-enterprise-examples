// output "ip_address" {
//   value = ibm_is_floating_ip.iac_app_floating_ip[*].address
// }

output "pgw_ip_addresses" {
  value = ibm_is_public_gateway.pgw[*].floating_ip.address
}
