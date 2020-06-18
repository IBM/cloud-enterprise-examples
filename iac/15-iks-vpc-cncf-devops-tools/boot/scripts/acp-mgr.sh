#!/bin/bash
# --------------------------------------------------------------------------------------------------------
# Name : Account Manager IAM Access Group Policies
#
# Description: Add policies to an access group that allow management of the resoruce groups,
# users, and access groups in an IBM Cloud account.
#
# --------------------------------------------------------------------------------------------------------
#
# input validation
if [ -z "$1" ]; then
    echo "Usage: acp-mgr.sh <ACCESS_GROUP>"
    echo "Add account management policies to an access group"
    echo "<ACCESS_GROUP> - The name of the access group (ex: ACCOUNT-MGR)"
    exit
fi

ACCESS_GROUP=$1

# input validation
if [ -z "${ACCESS_GROUP}" ]; then
    echo "Usage: acp-mgr.sh <ACCESS_GROUP>"
    echo "Please provide the name of the access group (ex: ACCOUNT-MGR)"
    exit
fi


# Define the Polices for the Access Group to enable managing an account

# ACCOUNT MANAGEMENT POLICIES

# This doc explains the range of account management services and how to enable them:
# "Assigning access to account management services"
# https://cloud.ibm.com/docs/iam?topic=iam-account-services

# "Who can create resource groups?"
# https://cloud.ibm.com/docs/resources?topic=resources-resources-faq#create-resource
# "Assigning access to account management services > All account management services option"
# https://cloud.ibm.com/docs/iam?topic=iam-account-services#all-account-management
# All account management services - 38
# Administrator role grants that role for all account management services
# This policy alone essentially gives the users all the permissions of the account owner (except classic infrastructure and Cloud Foundry permissions)
# Includes permissions to create resource groups, manage users, and create access groups
#ibmcloud iam access-group-policy-create ${ACCESS_GROUP} --account-management --roles Administrator

# This command grants resource group capabilities only, not the rest of account management capabilities
# Provides ability to do this:
# "Managing resource groups"
# https://cloud.ibm.com/docs/resources?topic=resources-rgs
# All resource group - 38
# Editor role grants access to create and view resource groups; Administrators can also assign access
# Administrator role is needed so Account Managers can grant Environment Admins and Users access to their resource group
# Redundant with --account-management
ibmcloud iam access-group-policy-create ${ACCESS_GROUP} --resource-type "resource-group" --roles Administrator

# "Assigning access to account management services > User management"
# https://cloud.ibm.com/docs/iam?topic=iam-account-services#user-management-account-management
# Provides ability to do this:
# "Inviting users to an account"
# https://cloud.ibm.com/docs/iam?topic=iam-iamuserinv#invite-access
# User Management service - 50
# Editor role grants access to invite and remove users; Administrators can also assign access
# Administrator role is needed so Account Managers can grant other Account Managers access to this service
# Redundant with --account-management but independent of --resource-type "resource-group"
ibmcloud iam access-group-policy-create ${ACCESS_GROUP} --service-name user-management --roles Administrator

# "Assigning access to account management services > Access groups"
# https://cloud.ibm.com/docs/iam?topic=iam-account-services#access-groups-account-management
# Provides ability to do this:
# "Setting up access groups"
# https://cloud.ibm.com/docs/iam?topic=iam-groups
# IAM Access Groups Service service - 55
# Editor role grants access to create groups and add users; Administrators can also assign access
# Redundant with --account-management but independent of --resource-type "resource-group"
ibmcloud iam access-group-policy-create ${ACCESS_GROUP} --service-name iam-groups --roles Administrator


# IAM SERVICES POLICIES
# Similar to env admin policies, but for all resource groups
# Enables acct admin access to all resources in all regions and all resource groups

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
# Kubernetes Service service in All regions - 45
# Administrator role grants access to create and delete clusters
# Manager role grants access to manage clusters
# To create clusters, the user will also need Administrator access to the image registry
ibmcloud iam access-group-policy-create ${ACCESS_GROUP} --service-name containers-kubernetes --roles Administrator,Manager

# "IAM access"
# https://cloud.ibm.com/docs/iam?topic=iam-userroles
# All resources in account (including future IAM enabled services) in All regions - 40
# Administrator role grants access to create and delete service instances (any IAM service)
# Manager role grants access to manage service instances
ibmcloud iam access-group-policy-create ${ACCESS_GROUP} --roles Administrator,Manager


echo "Completed creating polices!"