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
- [Optional variables](#optional-variables)
  - [How to use with Terraform](#how-to-use-with-terraform)
  - [How to use with Schematics](#how-to-use-with-schematics)
  - [Kubernetes deployments](#kubernetes-deployments)
    - [Version 1.0](#version-10)
    - [Version 1.1](#version-11)
    - [Version 2.0](#version-20)
  - [Project Validation](#project-validation)

This example is covered in the [Container Resources](https://ibm.github.io/cloud-enterprise-examples/iac-resources/container) page of the Infrastructure as Code pattern. Refer to that page to know how to use it and execute it.

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

1. Create an ICR namespace to push all the project images

   ```bash
   ibmcloud cr namespace-list
   ibmcloud cr namespace-add iac-registry
   ```

2. Build all the image versions and push them to ICR executing the following commands. If `us.icr.io` is not your region identify it with `ibmcloud cr region`.

   ```bash
   docker build -t us.icr.io/iac-registry/movies:1.0 -f docker/1.0/Dockerfile .
   docker build -t us.icr.io/iac-registry/movies:1.1 -f docker/1.1/Dockerfile .
   docker build -t us.icr.io/iac-registry/movies:2.0 -f docker/2.0/Dockerfile .
   docker images

   ibmcloud cr login

   docker push us.icr.io/iac-registry/movies:1.0
   docker push us.icr.io/iac-registry/movies:1.1
   docker push us.icr.io/iac-registry/movies:2.0
   ibmcloud cr images --restrict iac-registry
   ```

3. Create the file `terraform.tfvars` with values for the variables, this is an example with the required and optional variables:

   ```hcl
   project_name = "iac-iks-test-OWNER"
   environment  = "dev"

   # Optional variables
   resource_group = "Default"
   region         = "us-south"
   vpc_zone_names = ["us-south-1", "us-south-2", "us-south-3"]
   flavors        = ["cx2.2x4", "cx2.4x8", "cx2.8x16"]
   workers_count  = [3, 2, 1]
   k8s_version    = "1.18.3"
   ```

   For better results and avoid name collisions, change the values of the variables `project_name` and `environment`, replace `OWNER` for your username or user Id. It will fail if the word `OWNER` (uppercase) is used. Don't assign a project name nor any variable with more than 24 characters.

   A cluster with the given configuration is large (6 workers) and takes a long time to provision, instead you can use the following `terraform.tfvars` file with a simpler cluster that can be provisioned in less time.

   ```hcl path=terraform.tfvars
   project_name = "iac-iks-small-OWNER"
   environment  = "dev"

   # Optional variables
   resource_group = "Default"
   region         = "us-south"
   vpc_zone_names = ["us-south-1"]
   flavors        = ["mx2.4x32"]
   workers_count  = [1]
   k8s_version    = "1.18.3"
   ```

   If the Kubernetes version `1.18.3` is not available or old, get the latest supported version with the command `ibmcloud ks versions`

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

DEFAULT_SG_ID=$(ibmcloud is vpc-default-security-group $VPC_ID --json | jq -r ".id")
ibmcloud is security-group-rule-add $DEFAULT_SG_ID inbound tcp --port-min 30000 --port-max 32767

ibmcloud ks versions
VERSION=1.18.3

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

Get the cluster configuration to setup `kubectl` and validate the access to the cluster.

```bash
ibmcloud ks cluster config --cluster $NAME

kubectl cluster-info
```

Then execute the validation commands or actions documented in the **Project Validation** section below. Finally, when you finish using the infrastructure, cleanup everything you created with the execution of:

```bash
ibmcloud ks cluster rm --cluster $NAME
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

Get the cluster configuration to setup `kubectl` and validate the access to the cluster.

```bash
ibmcloud ks cluster config --cluster $(terraform output cluster_id)

kubectl cluster-info
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

Get the cluster configuration to setup `kubectl` and validate the access to the cluster.

```bash
ibmcloud schematics workspace list          # Identify the WORKSPACE_ID
ibmcloud schematics workspace output --id $WORKSPACE_ID --json

ibmcloud ks cluster config --cluster $(ibmcloud schematics workspace output --id $WORKSPACE_ID --json | jq -r '.[].output_values[].cluster_id.value')

kubectl cluster-info
```

After the validations in the **Project Validation** section below, cleanup everything you created with the execution of:

```bash
ibmcloud schematics destroy --id $WORKSPACE_ID # Identify the Activity_ID
ibmcloud schematics logs  --id $WORKSPACE_ID --act-id Activity_ID

# ... wait until it's done

ibmcloud schematics workspace delete --id $WORKSPACE_ID
ibmcloud schematics workspace list
```

## Kubernetes deployments

Having the cluster up and running it's time to deploy the API application. There are different versions each one explain us different objectives, so let's deploy one by one and do a validation after each deployment.

### Version 1.0

```bash
kubectl apply -f kubernetes/deployment.yaml
kubectl apply -f kubernetes/service.yaml
```

### Version 1.1

```bash
kubectl apply -f kubernetes/service.yaml
```

### Version 2.0

```bash
kubectl apply -f kubernetes/service.yaml
```

## Project Validation

Optionally, you can validate the container locally using docker or docker compose. The validation of each version is different, execute the code according to the version to validate.

- **Version `1.0`**:

  ```bash path=v1.0
  docker run --name movies -d --rm -p 80:8080 us.icr.io/iac-registry/movies:1.0
  curl http://localhost/movies/675
  ```

- **Version `1.1`**:

  ```bash path=v1.1
  docker run --name movies -d --rm -p 80:8080 -v $PWD/data:/data us.icr.io/iac-registry/movies:1.1
  curl http://localhost/movies/675
  ```

- **Version `2.0`**:

  ```bash path=v2.0
  docker run --name movies -d --rm -p 80:8080 -v $PWD/data:/data us.icr.io/iac-registry/movies:2.0
  curl http://localhost/movies/675
  ```

Stop the running container, regardless of the version, with the following command:

```bash
docker stop $(docker ps -q --filter name=movies)
```

To have access to the IKS cluster execute this **IBM Cloud CLI** command (`NAME` is the cluster name):

```bash
ibmcloud ks cluster config --cluster $NAME
```

For each scenario we have configured `kubectl` to have access to the cluster, complete the validation with some extra `kubectl` commands:

```bash
kubectl cluster-info
kubectl get nodes
kubectl get pods -A
```

To validate the API application get the external IP or FQDN address runnig the commands:

```bash
kubectl get svc movies
ADDRESS=$(kubectl get svc movies -o=jsonpath='{.status.loadBalancer.ingress[0].hostname}')

curl $ADDRESS/movies/675
```
