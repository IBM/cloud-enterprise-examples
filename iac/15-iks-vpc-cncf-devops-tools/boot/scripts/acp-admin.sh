#!/bin/bash
# --------------------------------------------------------------------------------------------------------
# Name : Environment Administrator Access Group Policies
#
# Description: Add policies to an access group that allow installation and administration
# of the Developer Tools environment into a new or existing OpenShift or Kubernetes cluster.
#
# --------------------------------------------------------------------------------------------------------
#
# input validation
if [ -z "$1" ]; then
    echo "Usage: acp-admin.sh <ACCESS_GROUP> <RESOURCE_GROUP>"
    echo "Add policies to an access group for administering resources in a resource group"
    echo "<ACCESS_GROUP> - The name of the access group (ex: <RESOURCE_GROUP>-ADMIN)"
    echo "<RESOURCE_GROUP> - The name of the resource group for the environment (ex: garage-apps)"
    exit
fi

ACCESS_GROUP=$1
RESOURCE_GROUP=$2

# input validation
if [ -z "${ACCESS_GROUP}" ]; then
    echo "Usage: acp-admin.sh <ACCESS_GROUP> <RESOURCE_GROUP>"
    echo "Please provide the name of the access group (ex: <RESOURCE_GROUP>-ADMIN)"
    exit
fi

# input validation
if [ -z "${RESOURCE_GROUP}" ]; then
    echo "Usage: acp-admin.sh <ACCESS_GROUP> <RESOURCE_GROUP>"
    echo "Please provide the name of the resource group for the environment (ex: garage-apps)"
    exit
fi


# Get ID for resource group
RESOURCE_GROUP_ID=$(ibmcloud resource group ${RESOURCE_GROUP} | grep -E "^ID" | sed -E "s/ID: *(.*)/\1/g")
echo "ID for resource group" ${RESOURCE_GROUP} "is" ${RESOURCE_GROUP_ID}


# Define the Polices for the Access Group to enable installation and administration

# "Managing user access with Identity and Access Management"
# https://cloud.ibm.com/docs/Registry?topic=registry-iam
# Container Registry service in All regions - 64
# Manager role grants access to create namespaces for the environment in the image registry
# Administrator role is needed to create clusters
ibmcloud iam access-group-policy-create ${ACCESS_GROUP} --service-name container-registry --roles Administrator,Manager

# "Prepare to create clusters at the account level"
# https://cloud.ibm.com/docs/containers?topic=containers-clusters#cluster_prepare
# "Understanding access to the infrastructure portfolio"
# https://cloud.ibm.com/docs/containers?topic=containers-users#understand_infra
# Kubernetes Service service in All regions in Resource Group - 45
# Administrator role grants access to create and delete clusters in the resource group
# Manager role grants access to manage existing clusters in the resource group
# To create clusters, the user will also need Administrator access to the image registry
ibmcloud iam access-group-policy-create ${ACCESS_GROUP} --service-name containers-kubernetes --resource-group-name ${RESOURCE_GROUP} --roles Administrator,Manager

# "IAM access"
# https://cloud.ibm.com/docs/iam?topic=iam-userroles
# "Assigning access to resource groups and the resources within them"
# https://cloud.ibm.com/docs/resources?topic=resources-bp_resourcegroups#assigning_access_rgs
# All IAM Services in All regions in Resource Group - 31
# Editor role grants access to create and delete service instances (any IAM service)
# Manager role grants access to manage existing service instances in the resource group
ibmcloud iam access-group-policy-create ${ACCESS_GROUP} --resource-group-name ${RESOURCE_GROUP} --roles Editor,Manager

# "Assigning access to resource groups and the resources within them"
# https://cloud.ibm.com/docs/resources?topic=resources-bp_resourcegroups#assigning_access_rgs
# Resource Group - 10
# Viewer role grants access to view the resource group itself, so that the resource group can be specified when creating a service
ibmcloud iam access-group-policy-create ${ACCESS_GROUP} --resource-type "resource-group" --resource ${RESOURCE_GROUP_ID} --roles Viewer


echo "Completed creating polices!"