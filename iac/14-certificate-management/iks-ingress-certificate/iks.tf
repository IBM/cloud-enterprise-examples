resource "ibm_container_vpc_cluster" "iac_iks_cluster" {
  name              = "${var.project_name}-${var.environment}-cluster"
  vpc_id            = ibm_is_vpc.iac_iks_vpc.id
  flavor            = var.flavors[0]
  worker_count      = var.workers_count[0]
  kube_version      = var.k8s_version
  resource_group_id = data.ibm_resource_group.group.id
  public_service_endpoint = var.public_endpoint
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
