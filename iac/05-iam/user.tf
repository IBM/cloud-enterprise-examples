variable "user_email" {}

resource "ibm_iam_access_group_members" "ag1_members" {
  access_group_id = ibm_iam_access_group.res_ag_1.id
  ibm_ids         = [var.user_email]
}

resource "ibm_iam_access_group_members" "ag3_members" {
  access_group_id = ibm_iam_access_group.res_ag_3.id
  ibm_ids         = [var.user_email]
}

resource "ibm_iam_access_group_members" "ag4_members" {
  access_group_id = ibm_iam_access_group.res_ag_4.id
  ibm_ids         = [var.user_email]
}