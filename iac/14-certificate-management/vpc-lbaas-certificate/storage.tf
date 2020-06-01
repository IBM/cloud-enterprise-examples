resource "ibm_resource_instance" "iac_app_cos_instance" {
  name     = "${var.project_name}-${var.environment}-cos-instance"
  service  = "cloud-object-storage"
  plan     = "standard"
  location = "global"
}

resource "ibm_cos_bucket" "iac_app_cos_bucket" {
  bucket_name          = "${var.project_name}-${var.environment}-bucket"
  resource_instance_id = ibm_resource_instance.iac_app_cos_instance.id
  region_location      = "us-south"
  storage_class        = "smart"
}
