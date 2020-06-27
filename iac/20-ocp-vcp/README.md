# Infrastructure as Code: Creating Red Hat OpenShift clusters on VPC Gen2

<!--

Check list for every README:
- Verify the requirement are the same, make sure the required plugins are there
- Modify the Project Requirements section. It should be different for every project
- Modify the Project Validation section. It should be different for every project

-->

This directory contains terraform code to create a minimum Red Hat OpenShift cluster in a VPC. Note that in order for the OpenShift Web console and the OperatorHub to be operational, the VPC will be configured with a public gateway to allow outbound Internet traffic from the worker nodes.

The internal registry for Red Hat OpenShift managed on IBM Cloud uses object storage for persistence. This code will also create a Cloud Object Storage instance in the resource group used for the OpenShift Cluster.

- [Infrastructure as Code: Managing Container Registry (ICR) & Kubernetes Services (IKS) Resources](#infrastructure-as-code-managing-container-registry-icr--kubernetes-services-iks-resources)
  - [General Requirements](#general-requirements)
  - [Project Requirements](#project-requirements)
  - [How to use with Terraform](#how-to-use-with-terraform)
  - [How to use with Schematics](#how-to-use-with-schematics)
  - [Project Validation](#project-validation)

## General Requirements

Same for every pattern, the requirements are documented in the [Environment Setup](https://ibm.github.io/cloud-enterprise-examples/iac/setup-environment). It includes:

- Have an IBM Cloud account with required privileges
- [Install IBM Cloud CLI](https://ibm.github.io/cloud-enterprise-examples/iac/setup-environment#install-ibm-cloud-cli)
- [Install the IBM Cloud CLI Plugins](https://ibm.github.io/cloud-enterprise-examples/iac/setup-environment#ibm-cloud-cli-plugins) `infrastructure-service`, `schematics` and `container-registry`.
- [Login to IBM Cloud with the CLI](https://ibm.github.io/cloud-enterprise-examples/iac/setup-environment#login-to-ibm-cloud)
- [Install Terraform](https://ibm.github.io/cloud-enterprise-examples/iac/setup-environment#install-terraform)
- [Install IBM Cloud Terraform Provider](https://ibm.github.io/cloud-enterprise-examples/iac/setup-environment#configure-access-to-ibm-cloud)
- [Configure access to IBM Cloud](https://ibm.github.io/cloud-enterprise-examples/iac/setup-environment#configure-access-to-ibm-cloud) for Terraform and the IBM Cloud CLI
- (Optional) Install some utility tools such as: [jq](https://stedolan.github.io/jq/download/) and [kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/)

> For OpenShift clusters on VPC Gen 2, the IBM Cloud Terraform provider must be version 1.8.0 or later

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

1. Create the file `terraform.tfvars` file with values for the variables, this is an example with the required and optional variables:

   ```hcl
   project_name = iac-iks-test-OWNER
   environment  = dev

   # Optional variables
   port           = 8080
   resource_group = "Default"
   region         = "us-south"
   vpc_zone_names = ["us-south-1", "us-south-2", "us-south-3"]
   ```

   For better results and avoid name collisions, replace `OWNER` for your username or user Id. It will fail if the word `OWNER` (uppercase) is used. Don't assign a project name with more than 24 characters.

1. Change the values of the variables `project_name` and `environment`, currently `iac-iks-test-OWNER` and `dev` respectively. It's recommended to replace `OWNER` by your username or user Id to avoid name collisions. It will fail if the word `OWNER` (uppercase) is used. Don't assign a project name with more than 24 characters.

## How to use with Terraform

In a nutshell, to play the example just execute the following commands:

```bash
terraform init
terraform plan
terraform apply
```

Then execute the validation commands or actions documented in the **Project Validation** section below. Finally, when you finish using the infrastructure, cleanup everything you created with the execution of:

```bash
terraform destroy
```

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

## Project Validation

To have access to the IKS cluster execute this **IBM Cloud CLI** command (`NAME` is the cluster name):

```bash
ibmcloud ks cluster config --cluster $NAME
```

If the project was executed with **Terraform**, get the outputs and kubectl configured executing these commands:

```bash
terraform output
ibmcloud ks cluster config --cluster $(terraform output cluster_id)
```

If the project was executed with **IBM Cloud Schematics**, get the outputs and kubectl configured executing these commands:

```bash
ibmcloud schematics workspace list          # Identify the WORKSPACE_ID
ibmcloud schematics workspace output --id $WORKSPACE_ID --json

ibmcloud ks cluster config --cluster $(ibmcloud schematics workspace output --id $WORKSPACE_ID --json | jq -r '.[].output_values[].cluster_id.value')
```

In both cases, you should see the the same output variables and get kubectl configured to access the cluster. Some `kubectl` commands to verify you have access are:

```bash
kubectl cluster-info
kubectl get nodes
kubectl get pods -A
```

<--TODO update with instructions to deploy the application >
