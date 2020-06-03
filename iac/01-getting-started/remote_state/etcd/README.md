# Terraform State Bucket

This code is to create the etcd database to store the shared Terraform state. You can accomplish this either using [Terraform](https://cloud.ibm.com/docs/terraform?topic=terraform-databases-resources) or the [IBM Cloud Web Console](https://cloud.ibm.com/docs/databases-for-etcd?topic=databases-for-etcd-getting-started).

To quickly create and use the etcd database execute the following commands:

```bash
export TF_VAR_prefix="terraform-state-$USER"
export TF_VAR_etcd_admin_password=$(LC_CTYPE=C tr -dc 'a-zA-Z0-9' < /dev/urandom | head -c 32)

terraform init && terraform plan
terraform apply

terraform output etcd_certbase64 | base64 --decode > ../ca.crt

export ETCDCTL_ENDPOINTS=$(terraform output etcd_endpoint)
export ETCD_USER=$(terraform output etcd_password)
export ETCD_PASSWD=$(terraform output etcd_password)
```

Below are the step by step instructions with more information.

1. Create the file `terraform.tfvars` with the following content:

   ```hcl
   prefix = "terraform-state-OWNER"
   etcd_admin_password = "$uPerSeCre7Pa55w0r"
   ```

   Replace `OWNER` by your user id or something that identify you, do not use `_` neither uppercase characters. Also make sure to set a good password for the variable `etcd_admin_password`. You can use the following one-liner to generate a random string on MacOS X and Linux with 32 alpha-numeric characters.

   ```bash
   LC_CTYPE=C tr -dc 'a-zA-Z0-9' < /dev/urandom | head -c 32
   ```

   Alternatively, you can export the environment variable `TF_VAR_prefix` and `TF_VAR_etcd_admin_password` with the value for the prefix and the password, respectively, just like in the quick start sample above.

2. Execute the following Terraform commands:

   ```bash
   terraform init
   terraform plan
   terraform apply
   ```

3. Save the certificate to a file. Execute:

   ```bash
   terraform output etcd_certbase64 | base64 --decode > ../ca.crt
   ```

   On MacOS X you may have to replace `decode --decode` by `base64 -D`

4. Export the entrypoint and certificate path in an environment variable to be used by the backend configuration.

   ```bash
   export ETCDCTL_ENDPOINTS=$(terraform output etcd_endpoint)

   export ETCD_USER=$(terraform output etcd_password)
   export ETCD_PASSWD=$(terraform output etcd_password)
   ```

5. Optionally, export the rest of the required variables to use the `etcdctl` command to access the key/values or debugging.

   ```bash
   export ETCDCTL_API=3
   export ETCDCTL_USER=$(terraform output etcd_user):$(terraform output etcd_password)
   export ETCDCTL_CACERT=$PWD/../ca.crt
   ```

   With the variables `ETCDCTL_API`, `ETCDCTL_CACERT`, `ETCDCTL_ENDPOINTS` and `ETCDCTL_USER` exported and `etcdctl` installed you can run commands like these to verify your connectivity:

   ```bash
   $ etcdctl put foo bar
   OK
   $ etcdctl get foo
   foo
   bar
   ```

Go back to the previous directory and follow the instructions in the main document.

When you finish using this bucket you can destroy it with this Terraform command:

```bash
terraform destroy
```
