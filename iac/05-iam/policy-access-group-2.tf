resource "ibm_iam_access_group" "res_ag_2" {
  name        = var.ag2
  description = "Access group for Kubernetes cluster auditors"
}

resource "ibm_iam_access_group_policy" "res_ag2_policy1" {

  access_group_id = ibm_iam_access_group.res_ag_2.id
  roles           = ["Viewer", "Reader"]
  resources {
    service = "containers-kubernetes"

  }
}

resource "ibm_iam_access_group_policy" "res_ag2_policy2" {

  access_group_id = ibm_iam_access_group.res_ag_2.id
  roles           = ["Reader"]
  resources {
    service = "container-registry"

  }
}