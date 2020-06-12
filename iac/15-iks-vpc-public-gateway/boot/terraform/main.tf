provider "ibm" {
  generation = 2
  ibmcloud_api_key  = var.ibmcloud_api_key
  region     = var.region
}
data "ibm_resource_group" "group" {
  name = var.resource_group
}

## Create a VPC
resource "ibm_is_vpc" "iac_iks_vpc" {
  name              = "${var.project_name}-${var.environment}-vpc"
  resource_group    = data.ibm_resource_group.group.id
}

resource "ibm_is_public_gateway" "iac_iks_gateway" {
    name  = "${var.project_name}-${var.environment}-gateway-${format("%02s", count.index)}"
    vpc   = ibm_is_vpc.iac_iks_vpc.id
    zone  = var.vpc_zone_names[count.index]
    count = local.max_size

    //User can configure timeouts
    timeouts {
        create = "90m"
    }
}

resource "ibm_is_subnet" "iac_iks_subnet" {
  count                    = local.max_size
  name                     = "${var.project_name}-${var.environment}-subnet-${format("%02s", count.index)}"
  zone                     = var.vpc_zone_names[count.index]
  vpc                      = ibm_is_vpc.iac_iks_vpc.id
  public_gateway           = ibm_is_public_gateway.iac_iks_gateway[count.index].id
  total_ipv4_address_count = 256
  resource_group           = data.ibm_resource_group.group.id
}

resource "ibm_is_security_group_rule" "iac_iks_security_group_rule_tcp_k8s" {
  count     = local.max_size
  group     = ibm_is_vpc.iac_iks_vpc.default_security_group
  direction = "inbound"
  remote    = ibm_is_subnet.iac_iks_subnet[count.index].ipv4_cidr_block
  tcp {
    port_min = 30000
    port_max = 32767
  }
}

resource "ibm_container_vpc_cluster" "iac_iks_cluster" {
  name              = "${var.project_name}-${var.environment}-cluster"
  vpc_id            = ibm_is_vpc.iac_iks_vpc.id
  flavor            = var.flavors[0]
  worker_count      = var.workers_count[0]
  kube_version      = var.k8s_version
  resource_group_id = data.ibm_resource_group.group.id
  wait_till         = "OneWorkerNodeReady"
  zones {
    name      = var.vpc_zone_names[0]
    subnet_id = ibm_is_subnet.iac_iks_subnet[0].id
  }
}

resource "ibm_container_vpc_worker_pool" "iac_iks_cluster_pool" {
  count             = local.max_size - 1
  cluster           = ibm_container_vpc_cluster.iac_iks_cluster.id
  worker_pool_name  = "${var.project_name}-${var.environment}-wp-${format("%02s", count.index + 1)}"
  flavor            = var.flavors[count.index + 1]
  vpc_id            = ibm_is_vpc.iac_iks_vpc.id
  worker_count      = var.workers_count[count.index + 1]
  resource_group_id = data.ibm_resource_group.group.id
  zones {
    name      = var.vpc_zone_names[count.index + 1]
    subnet_id = ibm_is_subnet.iac_iks_subnet[count.index + 1].id
  }
}