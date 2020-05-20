# Getting Started with Terraform

This example is covered in the [Getting Started](https://ibm.github.io/cloud-enterprise-examples/iac/getting-started-terraform) page for Infrastructure as Code pattern. Refer to that page to know how to use it and execute it.

## Check Access to IBM Cloud

Before play with this example make sure you complete the section Environment Setup to have Terraform, IBM Cloud CLI and a connection to IBM Cloud. The folder [check_access](./check_access/) has a simple Terraform code that you can use to verify your access to IBM Cloud.

Just move to the directory `check_access` and execute the terraform sub-commands: `init` and `apply`. You should see a list of the Access Groups related to the account you used to login to IBM Cloud, this is the same output of the command `ibmcloud iam access-groups`. Like so:

```bash
cd check_access
terraform init
terraform apply

ibmcloud iam access-groups
```

## Quick Start

In a nutshell, to play the example just execute the following commands:

```bash
terraform init
terraform plan
terraform apply

terraform output ip_address

curl "http://$(terraform output ip_address):8080"

ssh -i ~/.ssh/id_rsa ubuntu@$(terraform output ip_address) "echo 'Hello World'"

ssh -i ~/.ssh/id_rsa ubuntu@$(terraform output ip_address)
# Exit from the instance with: exit

terraform destroy
```

If you do not have the SSH key pair files, generate them with the command `ssh-keygen` (just for Mac OS X or Linux).
