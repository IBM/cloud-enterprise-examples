# IBM Terraform Provider Image

This repository contains infrastructure as code (IasC) scripting to enable the running of local Terraform commands using the latest Terraform Provider. It includes sample Terraform for creating a VPC Gen2 with IKS cluster enabled and exposing for the gateway.

## Overview

- Add credentials so we can launch the local CLI Tools image
- Passing the `IBMCLOUD_API_KEY` on the image run enables the keys to be managed outside of the terrform content

```bash
cp credentials.template credentials.properties
```

- Update the `credential.properties` file and add the IBM Cloud API Key

```bash
./launch.sh
```

- After boot strapping into the local tools image you can run the latest IBM Terraform provider 1.7.1 with Terraform CLI

```base
cd terraform
terraform init
terraform plan
terraform apply
```

## Summary

This is a simple way of running latest provider locally and running a set of terraform for creating VPC Gen2 IKS Cluster.
The cluster is created by default in the us-south region and as a single-zone cluster. In order to change the region, adjust the region specified in `terraform.tfvars` and the zone name(s) to the `vpc_zone_names` list in `variables.tf`. To create the cluster as a multi-zone cluster, add additional zone names to the `vpc_zone_names` list in `variables.tf`.
