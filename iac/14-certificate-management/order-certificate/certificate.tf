data "ibm_resource_instance" "cm" {
    name     = "iac-certificate-manager"
    service  = "cloudcerts"
}

resource "ibm_certificate_manager_order" "cert" {
  certificate_manager_instance_id = data.ibm_resource_instance.cm.id
  name                            = "iac-ordered-certificate"
  description                     = "Certificate ordered using alternate DNS provider"
  domains                         = ["movies.timro.us"]
  rotate_keys                     = false
  domain_validation_method        = "dns-01"
  # dns_provider_instance_crn       = ibm_cis.instance.id  // if not provided CM will use callback
}

output "ordered-certificate-id" {
  value = ibm_certificate_manager_order.cert.id
}

output "ordered-certificate-status" {
  value = ibm_certificate_manager_order.cert.status
}

output "ordered-certificate-expires-on" {
  value = ibm_certificate_manager_order.cert.expires_on
}
