data "ibm_resource_instance" "cm" {
    name     = "iac-certificate-manager"
    service  = "cloudcerts"
}

resource "ibm_certificate_manager_import" "cert" {
  certificate_manager_instance_id = data.ibm_resource_instance.cm.id
  name                            = "iac-imported-certificate"
  description="Certificate signed by public CA and imported to Certificate Manager"
  data = {
    content = file(var.certfile_path)
    priv_key = file(var.private_keyfile_path)
    intermediate = file(var.intermediate_certfile_path)
  }
}

output "imported-certificate-id" {
  value = ibm_certificate_manager_import.cert.id
}

output "imported-certificate-issuer" {
  value = ibm_certificate_manager_import.cert.issuer
}

output "imported-certificate-expires-on" {
  value = ibm_certificate_manager_import.cert.expires_on
}
