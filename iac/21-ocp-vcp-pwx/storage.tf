resource "ibm_is_volume" "iac_app_volume" {
  count    = var.workers_count[0]
  resource_group = data.ibm_resource_group.group.id
  name     = "${var.project_name}-${var.environment}-volume-${format("%02s", count.index)}"
  profile  = "10iops-tier"
  zone     = var.vpc_zone_names[0]
  capacity = var.pwx_volume_size
}
