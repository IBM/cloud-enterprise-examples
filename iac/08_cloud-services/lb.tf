resource "ibm_is_lb" "iac_app_lb" {
  name    = "${var.project_name}-${var.environment}-lb"
  subnets = ibm_is_subnet.iac_app_subnet.*.id
}

resource "ibm_is_lb_listener" "iac_app_lb_listener" {
  lb           = ibm_is_lb.iac_app_lb.id
  port         = var.port
  protocol     = "http"
  default_pool = ibm_is_lb_pool.iac_app_lb_pool.id
}

resource "ibm_is_lb_pool" "iac_app_lb_pool" {
  name                = "${var.project_name}-${var.environment}-lb-pool"
  lb                  = ibm_is_lb.iac_app_lb.id
  algorithm           = "round_robin"
  protocol            = "http"
  health_delay        = 5
  health_retries      = 2
  health_timeout      = 2
  health_type         = "http"
  health_monitor_url  = "/"
  health_monitor_port = var.port
}

resource "ibm_is_lb_pool_member" "iac_app_lb_pool_mem" {
  count          = local.max_size
  lb             = ibm_is_lb.iac_app_lb.id
  pool           = ibm_is_lb_pool.iac_app_lb_pool.id
  port           = var.port
  target_address = ibm_is_instance.iac_app_instance[count.index].primary_network_interface.0.primary_ipv4_address
  weight         = (100 - count.index)
}
