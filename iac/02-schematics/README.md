# Infrastructure as Code: Using IBM Cloud Schematics

<!--

Check list for every README:
- Verify the requirement are the same, make sure the required plugins are there
- Modify the Project Requirements section. It should be different for every project
- Modify the Project Validation section. It should be different for every project

-->

- [Infrastructure as Code: Using IBM Cloud Schematics](#infrastructure-as-code-using-ibm-cloud-schematics)
  - [General Requirements](#general-requirements)
  - [Project Requirements](#project-requirements)
  - [How to use with Schematics](#how-to-use-with-schematics)
  - [How to use with Terraform](#how-to-use-with-terraform)
  - [Project Validation](#project-validation)

This example is covered in the [IBM Cloud Schematics](https://ibm.github.io/cloud-enterprise-examples/iac/schematics) page of the Infrastructure as Code pattern. Refer to that page to know how to use it and execute it.

## General Requirements

Same for every pattern, the requirements are documented in the [Environment Setup](https://ibm.github.io/cloud-enterprise-examples/iac/setup-environment). It includes:

- Have an IBM Cloud account with required privileges
- [Install IBM Cloud CLI](https://ibm.github.io/cloud-enterprise-examples/iac/setup-environment#install-ibm-cloud-cli)
- [Install the IBM Cloud CLI Plugins](https://ibm.github.io/cloud-enterprise-examples/iac/setup-environment#ibm-cloud-cli-plugins) `infrastructure-service` and `schematics`
- [Login to IBM Cloud with the CLI](https://ibm.github.io/cloud-enterprise-examples/iac/setup-environment#login-to-ibm-cloud)
- [Install Terraform](https://ibm.github.io/cloud-enterprise-examples/iac/setup-environment#install-terraform)
- [Install IBM Cloud Terraform Provider](https://ibm.github.io/cloud-enterprise-examples/iac/setup-environment#configure-access-to-ibm-cloud)
- [Configure access to IBM Cloud](https://ibm.github.io/cloud-enterprise-examples/iac/setup-environment#configure-access-to-ibm-cloud) for Terraform and the IBM Cloud CLI
- (Optional) Install some utility tools such as: [jq](https://stedolan.github.io/jq/download/)

Executing these commands you are validating part of these requirements:

```bash
ibmcloud --version
ibmcloud plugin show infrastructure-service | head -3
ibmcloud plugin show schematics | head -3
ibmcloud target
terraform version
ls ~/.terraform.d/plugins/terraform-provider-ibm_*
echo $IC_API_KEY
```

If you have an API Key but is not set neither have the JSON file when it was created, you must recreate the key. Delete the old one if won't be in use anymore.

```bash
# Delete the old one, if won't be in use anymore
ibmcloud iam api-keys       # Identify your old API Key Name
ibmcloud iam api-key-delete NAME

# Create a new one and set it as environment variable
ibmcloud iam api-key-create TerraformKey -d "API Key for Terraform" --file ~/ibm_api_key.json
export IC_API_KEY=$(grep '"apikey":' ~/ibm_api_key.json | sed 's/.*: "\(.*\)".*/\1/')
```

The folder [check_access](../01-getting-started/check_access/) has a simple Terraform code that help you to verify your access to IBM Cloud. Go to the directory `check_access` and execute the following commands, you should see a list of the Access Groups related to the account with Terraform and IBM Cloud CLI:

```bash
cd check_access
terraform init
terraform apply

ibmcloud iam access-groups
```

## Project Requirements

This project requires the following actions:

1. Have a SSH Key pair or create them with the command `ssh-keygen`
2. Create the `workspace.json` file using the template `workspace.tmpl.json` to assign a value to the `PUBLIC_KEY` variable executing these commands:

   ```bash
   PUBLIC_KEY="$(cat ~/.ssh/id_rsa.pub)"
   sed "s|{ PUBLIC_KEY }|$PUBLIC_KEY|" workspace.tmpl.json > workspace.json
   ```

3. Change the values of the variables `project_name` and `environment`, currently `iac-network-test-OWNER` and `dev` respectively. It's recommended to replace `OWNER` by your username or user Id to avoid name collisions. It will fail if the word `OWNER` (uppercase) is used. Don't assign a project name with more than 24 characters.

## How to use with Schematics

Execute the following commands:

```bash
# Create workspace:
ibmcloud schematics workspace list
ibmcloud schematics workspace new --file workspace.json
ibmcloud schematics workspace list          # Identify the WORKSPACE_ID
WORKSPACE_ID=

# ... wait until the status is INACTIVE

# (Optional) Planing:
ibmcloud schematics plan --id $WORKSPACE_ID  # Identify the Activity_ID
ibmcloud schematics logs --id $WORKSPACE_ID --act-id Activity_ID

# ... wait until it's done

# Apply:
ibmcloud schematics apply --id $WORKSPACE_ID # Identify the Activity_ID
ibmcloud schematics logs  --id $WORKSPACE_ID --act-id Activity_ID
```

After the validations in the **Project Validation** section below, cleanup everything you created with the execution of:

```bash

ibmcloud schematics destroy --id $WORKSPACE_ID # Identify the Activity_ID
ibmcloud schematics logs  --id $WORKSPACE_ID --act-id Activity_ID

# ... wait until it's done

ibmcloud schematics workspace delete --id $WORKSPACE_ID
ibmcloud schematics workspace list
```

## How to use with Terraform

This specific example is to be executed with Schematics but you can use the Terraform Schematics data source with the code in the directory `data_source`. Go to this directory and execute the following commands:

```bash
cd data_source
terraform init

export TF_VAR_schematics_workspace_id=$WORKSPACE_ID

terraform plan
terraform apply
```

Then execute the validation commands or actions documented in the **Project Validation** section below. In this Data Source project there is nothing to destroy, nothing was created.

## Project Validation

To validate the project that was executed with **IBM Cloud Schematics**, verify the results executing these commands:

```bash
ibmcloud schematics workspace list          # Identify the WORKSPACE_ID
ibmcloud schematics workspace output --id $WORKSPACE_ID --json

curl $(ibmcloud schematics workspace output --id $WORKSPACE_ID --json | jq -r '.[].output_values[].entrypoint.value')
IP=$(ibmcloud schematics workspace output --id $WORKSPACE_ID --json | jq -r '.[].output_values[].ip_address.value')
ssh -i ~/.ssh/id_rsa ubuntu@$IP "echo 'Hello World'"
```

To validate the Data Source project that was executed with **Terraform**, verify the results executing these commands:

```bash
terraform output

curl $(terraform output entrypoint)
ssh -i ~/.ssh/id_rsa ubuntu@$(terraform output ip_address) "echo 'Hello World'"
```

In both cases, you should see the the same output variables and the "Hello World" after executing the `curl` and `ssh` commands.
