resource "ibm_iam_access_group" "res_ag_4" {
  name        = var.ag4
  description = "Access group for Cloud Object Storage administrators"
}

resource "ibm_iam_access_group_policy" "res_ag4_policy1" {
  access_group_id = ibm_iam_access_group.res_ag_4.id
  roles           = ["Administrator", "Manager"]
  resources {
    service = "cloud-object-storage"
  }
}