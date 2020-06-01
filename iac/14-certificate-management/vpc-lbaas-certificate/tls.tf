data "ibm_resource_instance" "cm" {
    name     = "iac-certificate-manager"
    service  = "cloudcerts"
}

variable "certificate_crn" {
    default = "CERT-CRN"
}

resource "ibm_iam_authorization_policy" "policy" {
  source_service_name           = "is"  
  source_resource_type          = "load-balancer"
  target_service_name           = "cloudcerts"
  roles                          = ["Writer"]
}

resource "ibm_is_lb_listener" "iac_app_lb_listener_tls" {
  lb                        = ibm_is_lb.iac_app_lb.id
  port                      = "443"
  protocol                  = "https"
  certificate_instance      = var.certificate_crn
  default_pool              = ibm_is_lb_pool.iac_app_lb_pool.id
}

output "load_balancer_host_status" {
  value = "add the host ${ibm_is_lb.iac_app_lb.hostname} as CNAME to the tls host"
}

