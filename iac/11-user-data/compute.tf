resource "ibm_is_ssh_key" "iac_app_key" {
  name       = "${var.project_name}-${var.environment}-key"
  public_key = var.public_key
}

data "local_file" "db" {
  filename = "${path.module}/db.min.json"
}

data "ibm_is_image" "ds_iac_app_image" {
  name = "ibm-ubuntu-18-04-1-minimal-amd64-1"
}

resource "ibm_is_instance" "iac_app_instance" {
  count   = var.max_size
  name    = "${var.project_name}-${var.environment}-instance-${format("%02s", count.index)}"
  image   = data.ibm_is_image.ds_iac_app_image.id
  profile = "cx2-2x4"

  primary_network_interface {
    name            = "eth1"
    subnet          = ibm_is_subnet.iac_app_subnet.id
    security_groups = [ibm_is_security_group.iac_app_security_group.id]
  }

  vpc     = ibm_is_vpc.iac_app_vpc.id
  zone    = "us-south-1"
  keys    = [ibm_is_ssh_key.iac_app_key.id]
  volumes = [ibm_is_volume.iac_app_volume[count.index].id]

  user_data = templatefile("${path.module}/scripts/init.sh", { json_db_b64 = data.local_file.db.content_base64, port = var.port })

  tags = ["iac-${var.project_name}-${var.environment}"]
}
