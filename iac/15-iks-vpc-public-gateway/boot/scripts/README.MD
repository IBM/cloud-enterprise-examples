# Iteration Zero Scripts

These scripts offer a number of utilites to help and support the configuration
 and setup of a development cluster. 

### destroy-services.sh

This will help you delete services that have been provisioned by the
 iteration zero terraform scripts.
 
 Destroy all the services that have been provisioned
 
 ```
./destory-services
```

Destroy all the services beside the one with a label inclusing the work `post
`. ie. Postgreql

 ```
./destory-services post
```

### config-console-tools

Edit the file `tools.yaml` and manually update your LogDNA, Sysdig and Github
 URLs. To add the collection of tool URLs to the OpenShift Console run the
  following scripts. You need to pass in the Cluster Ingress endpoint without
   the `https://` part of the URL.
  
```
./config-console-tools gsi-learning-ocp43-clus-7ec5d722a0ab3f463fdc90eeb94dbc70-0000.us-east.containers.appdomain.cloud
```
 
### acp-admin,acp-mgr and acp-user

Use this link to understand this script https://cloudnativetoolkit.dev/admin/config-account#access-group-for-environment-administrators

### dataload.sh

This is a userful script for loading data into a Cloud Database. More
 information can be found at this link https://cloudnativetoolkit.dev/practical/inventory-part2#add-a-cloudant-integration-to-your-backend-service

### kill-kube-ns

It is sometimes hard to run `oc delete <project/namespace>` This script will
 force the deletion of a namespace. Sometimes ICP4A installs a CRD on the
  namespace and this is not supported on OCP 3.11 and this script helps
   resolve the issue.

```
./kill-kube-ns <project/namespace>
```

### rbac.sh

This script helps define the RBAC roles aligned to persmissions provided from
 the ACCESS GROUP the development cluster is running within. More information
  can be found here https://cloudnativetoolkit.dev/admin/config-install
  
### list-storage.sh

This script will help you identify orphaned storage blocks. This can sometime
 happen if you do not clean up your storage when a cluster is deleted. You
  can run this script to output a storage report for your IBM Cloud account.  

```
ibmcloud login --sso
./list-storage.sh > account-storage.csv
```

### cleanup-storage.sh

If you identify storage allocated that is marked as `<not found>` this means
 that the storage is not associated with a running cluster. You can clean up
  the storage using the command below. Its recommending you have a good SRE
   understanding of the IBM Cloud account before running this command.

```
./list-storage.sh | grep "<not found>" | ./cleanup-storage.sh --force --skip-acl
```




