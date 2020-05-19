output "ip_address" {
  value = ibm_is_floating_ip.iac_app_floating_ip[*].address
}

output "lb_ip_address" {
  value = ibm_is_lb.iac_app_lb.public_ips
}

output "entrypoint" {
  value = "http://${ibm_is_lb.iac_app_lb.hostname}:${var.port}"
}
