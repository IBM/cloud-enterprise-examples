output "ip_address" {
  value = ibm_is_floating_ip.iac_test_floating_ip.address
}

output "entrypoint" {
  value = "http://${ibm_is_floating_ip.iac_test_floating_ip.address}:${var.port}"
}
