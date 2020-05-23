# Infrastructure as Code: Managing Container Registry (ICR) & Kubernetes Services (IKS) Resources

<!--

Check list for every README:
- Verify the requirement are the same, make sure the required plugins are there
- Modify the Project Requirements section. It should be different for every project
- Modify the Project Validation section. It should be different for every project

-->

- [Infrastructure as Code: Managing Container Registry (ICR) & Kubernetes Services (IKS) Resources](#infrastructure-as-code-managing-container-registry-icr--kubernetes-services-iks-resources)
  - [General Requirements](#general-requirements)
  - [Project Requirements](#project-requirements)
  - [How to use with the IBM Cloud CLI](#how-to-use-with-the-ibm-cloud-cli)
  - [How to use with Terraform](#how-to-use-with-terraform)
  - [How to use with Schematics](#how-to-use-with-schematics)
  - [Project Validation](#project-validation)

This example is covered in the [Network & Storage Resources](https://ibm.github.io/cloud-enterprise-examples/iac-resources/compute) page of the Infrastructure as Code pattern. Refer to that page to know how to use it and execute it.

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

1. Build the image and push it to ICR executing the following commands. If `us.icr.io` is not your region identify it with `ibmcloud cr region`.

   ```bash
   docker build -t us.icr.io/iac-registry/movies:1.0 .
   docker images

   ibmcloud cr namespace-list
   ibmcloud cr namespace-add iac-registry
   ibmcloud cr login
   docker push us.icr.io/iac-registry/movies:1.0
   ibmcloud cr images
   ```

2. Create the file `terraform.tfvars` file with values for the variables, this is an example with the required and optional variables:

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

3. Change the values of the variables `project_name` and `environment`, currently `iac-iks-test-OWNER` and `dev` respectively. It's recommended to replace `OWNER` by your username or user Id to avoid name collisions. It will fail if the word `OWNER` (uppercase) is used. Don't assign a project name with more than 24 characters.

## How to use with the IBM Cloud CLI

To create an IKS using the IBM Cloud CLI execute the following commands. Select the zone (`ZONE`), workers node flavor (`FLAVOR`), number of worker nodes (`N`), the Kubernetes cluster version (`VERSION`) and the name for all the resources (`*_Name` and `NAME`).

```bash
ibmcloud ks zone ls --provider vpc-gen2 --show-flavors
ZONE=us-south-1
ibmcloud ks flavors --provider vpc-gen2 --zone $ZONE
FLAVOR=cx2.2x4

VPC_Name=iac-iks-vpc
ibmcloud is vpc-create $VPC_Name
VPC_ID=$(ibmcloud is vpcs --json | jq -r ".[] | select(.name==\"$VPC_Name\").id")

Subnet_Name=iac-iks-subnet
ibmcloud is subnet-create $Subnet_Name $VPC_ID --zone $ZONE --ipv4-address-count 16
SUBNET_ID=$(ibmcloud is subnets --json | jq -r ".[] | select(.name==\"$Subnet_Name\").id")

SG_Name=iac-iks-sg
ibmcloud is security-group-create $SG_Name $VPC_ID
SG_ID=$(ibmcloud is security-groups --json | jq -r ".[] | select(.name==\"$SG_Name\").id")

ibmcloud is security-group-rule-add $SG_ID inbound tcp --port-min 30000 --port-max 32767

ibmcloud ks versions
VERSION=1.18.2


NAME=iac-iks-cluster
N=3

ibmcloud ks cluster create vpc-gen2 \
  --name $NAME \
  --zone $ZONE \
  --vpc-id $VPC_ID \
  --subnet-id $SUBNET_ID \
  --flavor $FLAVOR \
  --version $VERSION \
  --workers $N
  # --entitlement cloud_pak \
  # --service-subnet $SUBNET_CIDR \
  # --pod-subnet $POD_CIDR \
  # --disable-public-service-endpoint \
```

Then execute the validation commands or actions documented in the **Project Validation** section below. Finally, when you finish using the infrastructure, cleanup everything you created with the execution of:

```bash
ibmcloud ks cluster rm --cluster $NAME
ibmcloud is security-group-delete $SG_ID
ibmcloud is subnet-delete $SUBNET_ID
ibmcloud is vpc-delete $VPC_ID
```

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
