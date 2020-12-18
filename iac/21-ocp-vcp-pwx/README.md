# Infrastructure as Code: Creating Red Hat OpenShift clusters on VPC Gen2

<!--

Check list for every README:
- Verify the requirement are the same, make sure the required plugins are there
- Modify the Project Requirements section. It should be different for every project
- Modify the Project Validation section. It should be different for every project

-->

This directory contains terraform code to create a minimum Red Hat OpenShift cluster in a VPC and configure it for installation of Portworx. Note that in order for the OpenShift Web console and the OperatorHub to be operational, the VPC will be configured with a public gateway to allow outbound Internet traffic from the worker nodes.

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

## Initial configuration for IAF beta installations

Before configuring and installing Portworx, there are ROKS worker node specific customization that should be performed as these steps will cause the worker notes to be replaced (which breaks Portworx!). Follow the instructions from the [IAF playbook pre-requisites](https://pages.github.ibm.com/automation-base-pak/abp-playbook/planning-install/prerequisites) and perform the following tasks:

1. From the "Adding the image pull mirror and editing the global pull secret" section, use the console to add pull secrets for the cp.icr.io and cp.stg.icr.io registries. See [entitled registry options](https://playbook.cloudpaklab.ibm.com/ibm-developer-entitled-registry-login-options/) for how to get these secrets. Note: for access to `cp.stg.icr.io` you may need to request federation of your IBMid to the staging environment. Also add your docker hub credentials to allow authenticated pulls and avoid rate-limiting. After all secrets have been added to the `openshift-config/pull-secret` secret, replace the workers using either the cli or web UI

1. After the worker replacement is complete access each worker using a debug pod: `oc debug node/<nodeIP>` and append an image mirror to the `/etc/containers/registries.conf` file. Append the following (verify indentation matches lines above)

    ```text
    oc debug node/<nodeIP>
    chroot /host
    cat >> /etc/containers/registries.conf

    # paste in the following followed by Ctrl-D

    [[registry]]
      prefix = ""
      location = "cp.icr.io/cp"
      mirror-by-digest-only = true
      prefix = ""

      [[registry.mirror]]
      location = "cp.stg.icr.io/cp"

    [[registry]]
      prefix = ""
      location = "docker.io/ibmcom"
      mirror-by-digest-only = true

      [[registry.mirror]]
      location = "cp.stg.icr.io/cp"

    tail -30 /etc/containers/registries.conf

    # verify indentation is as expected (if not use vi to fix)
    ```

1. After the mirror settings have been applied to all workers, reboot each worker with (allow 5 minutes for reboots to complete):

    ```text
    ibmcloud cs worker reboot --cluster <cluster_name_or_ID> CLUSTER_NAME -w <workerID>

    # after 5 minutes verify all nodes ready
    oc get nodes
    ```

Rebooting the nodes appears to create an issue for the internal registry pod. After all of the workers have rebooted it will go into a crash loop scenario. The crashing pod can be stopped by setting `config.imageregistry.operator.openshift.io/cluster` .spec.replicas to 0 if desired.

## Notes on Portworx setup

Portworx requires workers in VPC that are 16cpu/64GB (or 32) so the bx2.16x64 profile should be used at a minimum for the worker nodes. The minimum steps necessary are shown here along with related links to the relevant IBM Cloud documentation sections.

Separate unformatted volumes need to be attached to the workers. The IAC code in this folder will create a VPC, OpenShift cluster and volumes that can me bound to the workers. These steps provide a fast path to manually completing the installation based on information from [Storing data with Portworx](https://cloud.ibm.com/docs/openshift?topic=openshift-portworx).

1. Log in to IBM Cloud CLI and set the target resource group to the group with your target cluster. Verify the cluster is present using `ibmcloud oc clusters`

1. Unformatted block storage volumes will be created as part of the terraform code. Retrieve the ids with the `ibmcloud is volumes` command.

1. Obtain the ids for each worker with: `ibmcloud oc workers --cluster <clustername>`

1. Retrieve IAM token with `ibmcloud iam oauth-tokens` and set this to IAM_TOKEN, set the the RESOURCE_GROUP environment variable to the resource group id, and set the CLUSTER environment variable to the cluster name to save typing in later commands.

    ```text
    IAM_TOKEN=$(ibmcloud iam oauth-tokens --output json | jq -r '.iam_token')
    RESOURCE_GROUP=$(ibmcloud target --output json | jq -r '.resource_group.guid')
    CLUSTER=clustername
    ```

1. Using the id of the desired worker node and the storage volume, use CLI command to attach - template for command listed first followed by example invocations, edit these to match your volume and worker id:

    ```text
     ibmcloud ks storage attachment create --cluster CLUSTER --volume VOLUME --worker WORKER

     ibmcloud ks storage attachment create --cluster $CLUSTER --volume r014-aef666d3-5072-4900-a1b2-23a69cb3f96b --worker kube-bvc11mbw0n2a9mccenlg-timropwxvpc-default-000002a7

     ibmcloud ks storage attachment create --cluster $CLUSTER --volume r014-2e73f277-83a1-4741-b7f6-f56c92480874 --worker kube-bvc11mbw0n2a9mccenlg-timropwxvpc-default-000003e1

     ibmcloud ks storage attachment create --cluster $CLUSTER --volume r014-a5876bae-c839-426e-b7dd-6304c4c9ce3f --worker kube-bvc11mbw0n2a9mccenlg-timropwxvpc-default-0000011c

1. Verify attachments:

    ```text
    curl -X GET "https://containers.cloud.ibm.com/v2/storage/getAttachments?cluster=$CLUSTER&worker=<worker_ID>" --header "X-Auth-Resource-Group-ID: $RESOURCE_GROUP" --header "Authorization: $IAM_TOKEN"

    curl -X GET "https://containers.cloud.ibm.com/v2/storage/getAttachments?cluster=$CLUSTER&worker=kube-bvc11mbw0n2a9mccenlg-timropwxvpc-default-000002a7" --header "X-Auth-Resource-Group-ID: $RESOURCE_GROUP" --header "Authorization: $IAM_TOKEN"

    {"volume_attachments":[{"id":"0757-1e3db03e-e9bb-44ba-b423-14570a3511e6","volume":{"name":"timro-pwx-vol01","id":"r014-aef666d3-5072-4900-a1b2-23a69cb3f96b"},"device":{"id":"0757-1e3db03e-e9bb-44ba-b423-14570a3511e6-8xbd9"},"name":"volume-attachment","status":"attached","type":"data"},{"id":"0757-6a52d8da-3192-4ac9-b78d-3fa3e402be4f","volume":{"name":"gab-wistful-stimulate-nutmeg","id":"r014-54a8d1d0-b679-4c7e-bec6-b91deb30e98f"},"device":{"id":"0757-6a52d8da-3192-4ac9-b78d-3fa3e402be4f-x5rql"},"name":"volume-attachment","status":"attached","type":"boot"}]}

1. Continue with setting up Portworkx starting with review of options for metadata key-value store for volume: https://cloud.ibm.com/docs/openshift?topic=openshift-portworx#portworx_database . Choose to use in-cluster KVDB for simplicity and continue to main installation steps: https://cloud.ibm.com/docs/openshift?topic=openshift-portworx#install_portworx

1. Skip volume encryption. [Use these steps to configure encryption for the volumes](https://cloud.ibm.com/docs/openshift?topic=openshift-portworx#encrypt_volumes)

1. Copy pull secrets from `default` namespace to `kube-system` and associate with service account:

    ```text
    oc get secret all-icr-io -n default -o yaml | sed 's/default/kube-system/g' | oc create -n kube-system -f -
    oc patch -n kube-system serviceaccount/default --type='json' -p='[{"op":"add","path":"/imagePullSecrets/-","value":{"name":"all-icr-io"}}]'
    oc describe serviceaccount default -n kube-system

1. Open the Portworx catalog tile: https://cloud.ibm.com/catalog/services/portworx-enterprise . Select region, resource group, provide as tag the cluster name, provide an API key for the cloud account. Select portworx KVDB in the pulldown for metadata key-value store

1. Verify the deployment:

    ```text
    kubectl get pods -n kube-system | grep 'portworx\|stork'
    portworx-647c5                            1/1     Running     0          9m33s
    portworx-api-h7dnr                        1/1     Running     0          9m33s
    portworx-api-ndpxb                        1/1     Running     0          9m33s
    portworx-api-srnjk                        1/1     Running     0          9m33s
    portworx-gzgqc                            1/1     Running     0          9m33s
    portworx-pvc-controller-b8c88b4d7-6rnq6   1/1     Running     0          9m33s
    portworx-pvc-controller-b8c88b4d7-9bfxk   1/1     Running     0          9m33s
    portworx-pvc-controller-b8c88b4d7-nqqpr   1/1     Running     0          9m33s
    portworx-vxphk                            1/1     Running     0          9m33s
    stork-6f74dcf5fc-mxwxb                    1/1     Running     0          9m33s
    stork-6f74dcf5fc-svnrl                    1/1     Running     0          9m33s
    stork-6f74dcf5fc-z9qlc                    1/1     Running     0          9m33s
    stork-scheduler-7d755b5475-grzr2          1/1     Running     0          9m33s
    stork-scheduler-7d755b5475-nl25m          1/1     Running     0          9m33s
    stork-scheduler-7d755b5475-trhhb          1/1     Running     0          9m33s
    ```

1. Using one of the portworx pods, check the status of the storage cluster

    ```text
    kubectl exec portworx-647c5 -it -n kube-system -- /opt/pwx/bin/pxctl status
    Status: PX is operational
    License: PX-Enterprise IBM Cloud (expires in 1205 days)
    Node ID: 9fdd4434-b75c-4329-8db5-7dd54c3a3998
	    IP: 172.26.0.5 
 	    Local Storage Pool: 1 pool
	    POOL	IO_PRIORITY	RAID_LEVEL	USABLE	USED	STATUS	ZONE		REGION
	    0	LOW		raid0		200 GiB	12 GiB	Online	us-east-1	us-east
	    Local Storage Devices: 1 device
	    Device	Path		Media Type		Size		Last-Scan
	    0:1	/dev/vdd	STORAGE_MEDIUM_MAGNETIC	200 GiB		15 Dec 20 16:51 UTC
	    * Internal kvdb on this node is sharing this storage device /dev/vdd  to store its data.
	    total		-	200 GiB
	  Cache Devices:
	    * No cache devices
    Cluster Summary
	  Cluster ID: pwx-demo
	  Cluster UUID: e55324f0-e896-428f-a7b2-c31ff009df6a
	  Scheduler: kubernetes
	  Nodes: 3 node(s) with storage (3 online)
	     IP		ID					SchedulerNodeName	StorageNode	Used	Capacity	Status	StorageStatus	Version		Kernel				OS
	     172.26.0.4	c7f48fb2-7253-4a0a-b59c-2df4aa220657	172.26.0.4		Yes		12 GiB	200 GiB		Online	Up		2.6.1.6-3409af2	3.10.0-1160.6.1.el7.x86_64	Red Hat
	     172.26.0.5	9fdd4434-b75c-4329-8db5-7dd54c3a3998	172.26.0.5		Yes		12 GiB	200 GiB		Online	Up (This node)	2.6.1.6-3409af2	3.10.0-1160.6.1.el7.x86_64	Red Hat
	     172.26.0.6	331f94cf-260e-4d2d-8b99-7c67d040cb92	172.26.0.6		Yes		12 GiB	200 GiB		Online	Up		2.6.1.6-3409af2	3.10.0-1160.6.1.el7.x86_64	Red Hat
	  Warnings: 
		   WARNING: Internal Kvdb is not using dedicated drive on nodes [172.26.0.4 172.26.0.5]. This configuration is not recommended for production clusters.
    Global Storage Pool
	    Total Used    	:  36 GiB
	    Total Capacity	:  600 GiB
    ```

1. Test by creating a PVC - create a yaml file with a read-write-many claim:

    ```yaml
    kind: PersistentVolumeClaim
    apiVersion: v1
    metadata:
      name: mypvc
    spec:
      accessModes:
      - ReadWriteMany
      resources:
        requests:
          storage: 10G
      storageClassName: portworx-shared-sc
    ```

### Adding storage classes for CP4D/IAF

The IAF installation process is configured to alternately use specific portworx storage classes for shared volumes. To create the expected storage classes use these commands:

```shell
cat <<EOF | oc create -f -
apiVersion: storage.k8s.io/v1
kind: StorageClass
metadata:
  name: portworx-shared-gp3
parameters:
  priority_io: high
  repl: "3"
  sharedv4: "true"
  io_profile: db_remote
  disable_io_profile_protection: "1"
allowVolumeExpansion: true
provisioner: kubernetes.io/portworx-volume
reclaimPolicy: Retain
volumeBindingMode: Immediate
EOF
```

```shell
cat <<EOF | oc create -f -
apiVersion: storage.k8s.io/v1
kind: StorageClass
metadata:
  name: portworx-metastoredb-sc
parameters:
  priority_io: high
  io_profile: db_remote
  repl: "3"
  disable_io_profile_protection: "1"
allowVolumeExpansion: true
provisioner: kubernetes.io/portworx-volume
reclaimPolicy: Retain
volumeBindingMode: Immediate
EOF
```

### Cleaning up and removing portworx:

run in the cluster:

```text
curl -fsL https://install.portworx.com/px-wipe | bash
```

Remove the resource from the IBM Cloud Console with delete, then deprovision the OpenShift Cluster