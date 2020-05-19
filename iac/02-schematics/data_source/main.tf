// Get the Workspace ID with:
// NAME=Workspace_Name
// export TF_VAR_schematics_workspace_id=$(ibmcloud schematics workspace list --json | jq -r '.workspaces[] | select(.name == "'$NAME'") | .id')

variable "schematics_workspace_id" {}

data "ibm_schematics_workspace" "iac-test" {
  workspace_id = var.schematics_workspace_id
}

data "ibm_schematics_output" "iac-test-output" {
  workspace_id = var.schematics_workspace_id
  template_id  = data.ibm_schematics_workspace.iac-test.template_id.0
}

output "output_vars" {
  value = data.ibm_schematics_output.iac-test-output.output_values
}

output "entrypoint" {
  value = data.ibm_schematics_output.iac-test-output.output_values.entrypoint
}

output "ip_address" {
  value = data.ibm_schematics_output.iac-test-output.output_values.ip_address
}
