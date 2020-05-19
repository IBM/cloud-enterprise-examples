resource "ibm_iam_access_group" "res_ag_3" {
  name        = var.ag3
  description = "Access group for Schematics workspace managers"
}

resource "ibm_iam_access_group_policy" "res_ag3_policy1" {

  access_group_id = ibm_iam_access_group.res_ag_3.id
  roles           = ["Administrator", "Manager"]
  resources {
    service = "schematics"

  }
}