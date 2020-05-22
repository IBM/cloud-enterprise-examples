resource "ibm_container_vpc_cluster" "iac_iks_cluster" {
  name              = "${var.project_name}-${var.environment}-cluster"
  vpc_id            = ibm_is_vpc.iac_iks_vpc.id
  flavor            = "bx2-4x16"
  worker_count      = 1
  resource_group_id = data.ibm_resource_group.group.id
  zones {
    name      = var.vpc_zone_names[0]
    // subnet_id = ibm_is_subnet.iac_iks_subnet[0].id
    subnet_id = ibm_is_subnet.iac_iks_subnet.id
  }
}

// resource "ibm_container_vpc_worker_pool" "iac_iks_cluster_pool" {
//   count             = local.max_size - 1
//   cluster           = ibm_container_vpc_cluster.iac_iks_cluster.id
//   worker_pool_name  = "${var.project_name}-${var.environment}-worker-pool-${format("%02s", count.index + 1)}"
//   flavor            = "bx2-2x8"
//   vpc_id            = ibm_is_vpc.iac_iks_vpc.id
//   worker_count      = 3
//   resource_group_id = data.ibm_resource_group.group.id
//   zones {
//     name      = var.vpc_zone_names[count.index + 1]
//     subnet_id = ibm_is_subnet.iac_iks_subnet[count.index + 1].id
//   }
// }
