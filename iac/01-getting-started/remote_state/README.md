# Using Terraform Remote State

This simple example creates an instance running a simple web server with a "Hello World" web page. The main purpose of this sample is to explain how to setup and use a remote Terraform state instead of stored in your filesystem.

To get this up and running really quick, execute the following commands:

```bash
cd etcd
export TF_VAR_prefix="terraform-state-$USER"
export TF_VAR_etcd_admin_password=$(LC_CTYPE=C tr -dc 'a-zA-Z0-9' < /dev/urandom | head -c 32)
terraform init && terraform plan
terraform apply
terraform output etcd_certbase64 | base64 -d > ../ca.crt
export ETCDCTL_ENDPOINTS=$(terraform output etcd_endpoint)
export ETCD_PASSWD=$(terraform output etcd_password)

export ETCDCTL_API=3
export ETCDCTL_USER=$(terraform output etcd_user):$(terraform output etcd_password)
export ETCDCTL_CACERT=$PWD/../ca.crt
cd ..

openssl req -newkey rsa:2048 -nodes -keyout key.pem -x509 -days 365 -out certificate.pem -subj "/C=US/ST=California/L=San Diego/O=IBM/OU=Terraform Backend"
sed   -e "s|{ ETCDCTL_ENDPOINTS }|$ETCDCTL_ENDPOINTS|" \
      -e "s|{ ETCD_PASSWD }|$ETCD_PASSWD|" backend_etcd.tf.tmpl > backend_etcd.tf

terraform init
terraform plan && terraform apply

curl $(terraform output entrypoint) # --> Hello World
etcdctl get --prefix terraform-state
```

Follow these instructions step by step to know how this example works:

1. Generate the etcd database to store the state. Go to the `etcd` directory and follow these [instructions](./etcd/README.md). Basically what you have to do is:

   ```bash
   cd etcd

   export TF_VAR_prefix="terraform-state-$USER"

   terraform init && terraform plan
   terraform apply

   terraform output etcd_certbase64 | base64 -d > ../ca.crt

   export ETCDCTL_ENDPOINTS=$(terraform output etcd_endpoint)
   export ETCD_USER=$(terraform output etcd_password)
   export ETCD_PASSWD=$(terraform output etcd_password)

   cd ..
   ```

2. Move back to this directory. Due to the terraform issue [#19185](https://github.com/hashicorp/terraform/issues/19185) generate the private and public key like so:

   ```bash
   openssl req -newkey rsa:2048 -nodes -keyout key.pem -x509 -days 365 -out certificate.pem -subj "/C=US/ST=California/L=San Diego/O=IBM/OU=Terraform Backend"
   ```

3. Execute the following `sed` command to create the `backend_etcd.tf` file with the etcd endpoint and admin password:

   ```bash
   sed -e "s|{ ETCDCTL_ENDPOINTS }|$ETCDCTL_ENDPOINTS|" \
      -e "s|{ ETCD_PASSWD }|$ETCD_PASSWD|" backend_etcd.tf.tmpl > backend_etcd.tf
   ```

   <!--
      terraform init \
      -backend-config="endpoints=[\"${ETCDCTL_ENDPOINTS}\"]" \
      -backend-config="password=\"${ETCD_PASSWD}\"" \
      -backend-config='username="root"' \
      -backend-config='prefix="terraform-state/"' \
      -backend-config='lock=true' \
      -backend-config='cacert_path="ca.crt"' \
      -backend-config='cert_path="certificate.pem"' \
      -backend-config='key_path="key.pem"'
   -->

   Alternatively, modify the `backend_etcd.tf` file with the value of the `endpoints`, `password` and `cacert_path` from the previously used environment variables. If you choose this option, make sure not commit those changes to GitHub or GitLab.

4. Execute `terraform init` to configure the backend to use the etcd database.
5. Alternatively, you can select a different backend method such as `http` or `s3`. Follow the instructions from the [blog post](https://www.ibm.com/cloud/blog/store-terraform-states-cloud-object-storage) and the code from [https://github.com/l2fprod/serverless-terraform-backend](https://github.com/l2fprod/serverless-terraform-backend)
6. Finish the execution of the terraform code to confirm the terraform state is remotely stored in etcd. Exeucte these commands:

   ```bash
   export TF_VAR_prefix="terraform-state-$USER"
   terraform plan && terraform apply

   curl $(terraform output entrypoint)
   # Expect: Hello World

   etcdctl get --prefix terraform-state
   ```

When you are done with this example destroy all the resources: the demo instance used in this example and the etcd database, in this order.

```bash
terraform destroy
cd etcd
terraform destroy
cd ..
```
