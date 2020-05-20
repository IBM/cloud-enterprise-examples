resource "ibm_is_vpc" "iac_app_vpc" {
  name = "${var.project_name}-${var.environment}-vpc"
}

resource "ibm_is_subnet" "iac_app_subnet" {
  count                    = local.max_size
  name                     = "${var.project_name}-${var.environment}-subnet-${format("%02s", count.index)}"
  zone                     = var.vpc_zone_names[count.index]
  vpc                      = ibm_is_vpc.iac_app_vpc.id
  total_ipv4_address_count = 16
  public_gateway           = ibm_is_public_gateway.pgw[count.index].id
  resource_group           = data.ibm_resource_group.group.id
}

resource "ibm_is_security_group" "iac_app_security_group" {
  name           = "${var.project_name}-${var.environment}-sg-public"
  vpc            = ibm_is_vpc.iac_app_vpc.id
  resource_group = data.ibm_resource_group.group.id
}

resource "ibm_is_security_group_rule" "iac_app_security_group_rule_tcp_http" {
  count     = local.max_size
  group     = ibm_is_security_group.iac_app_security_group.id
  direction = "inbound"
  remote    = ibm_is_subnet.iac_app_subnet[count.index].ipv4_cidr_block

  tcp {
    port_min = var.port
    port_max = var.port
  }
}

resource "ibm_is_security_group_rule" "iac_app_security_group_rule_tcp_ssh" {
  count     = local.max_size
  group     = ibm_is_security_group.iac_app_security_group.id
  direction = "inbound"
  remote    = ibm_is_subnet.iac_app_subnet[0].ipv4_cidr_block

  tcp {
    port_min = 22
    port_max = 22
  }
}

resource "ibm_is_security_group_rule" "iac_app_security_group_rule_all_outbound" {
  group     = ibm_is_security_group.iac_app_security_group.id
  direction = "outbound"
}

resource "ibm_is_public_gateway" "pgw" {
  count = local.max_size
  name  = "${var.project_name}-${var.environment}-pgw-${format("%02s", count.index)}"
  vpc   = ibm_is_vpc.iac_app_vpc.id
  zone  = var.vpc_zone_names[count.index]
}

// resource "ibm_is_floating_ip" "iac_app_floating_ip" {
//   name   = "${var.project_name}-${var.environment}-ip-${format("%02s", count.index)}"
//   target = ibm_is_instance.iac_app_instance[count.index].primary_network_interface.0.id
//   count  = local.max_size
// }
