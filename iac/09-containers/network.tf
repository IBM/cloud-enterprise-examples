resource "ibm_is_vpc" "iac_iks_vpc" {
  name = "${var.project_name}-${var.environment}-vpc"
}

resource "ibm_is_subnet" "iac_iks_subnet" {
  count                    = local.max_size
  name                     = "${var.project_name}-${var.environment}-subnet-${format("%02s", count.index)}"
  zone                     = var.vpc_zone_names[count.index]
  vpc                      = ibm_is_vpc.iac_iks_vpc.id
  total_ipv4_address_count = 256
  resource_group           = data.ibm_resource_group.group.id
}

resource "ibm_is_security_group" "iac_iks_security_group" {
  name           = "${var.project_name}-${var.environment}-sg-public"
  vpc            = ibm_is_vpc.iac_iks_vpc.id
  resource_group = data.ibm_resource_group.group.id
}

resource "ibm_is_security_group_rule" "iac_iks_security_group_rule_tcp_k8s" {
  count     = local.max_size
  group     = ibm_is_security_group.iac_iks_security_group.id
  direction = "inbound"
  remote    = ibm_is_subnet.iac_iks_subnet[count.index].ipv4_cidr_block

  tcp {
    port_min = 30000
    port_max = 32767
  }
}
