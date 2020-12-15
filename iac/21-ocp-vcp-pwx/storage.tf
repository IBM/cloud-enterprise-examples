resource "ibm_is_volume" "iac_app_volume" {
  count    = local.max_size
  resource_group_id = data.ibm_resource_group.group.id
  name     = "${var.project_name}-${var.environment}-volume-${format("%02s", count.index)}"
  profile  = "10iops-tier"
  zone     = var.vpc_zone_names[count.index]
  capacity = var.pwx_volume_size
}
