#!/bin/bash
# --------------------------------------------------------------------------------------------------------
# Name : Kubernetes RBAC Roles
#
# Description: Add roles and bindings in Kubernetes RBAC to control
# which access group's users can create namespaces and access secrets.
#
# --------------------------------------------------------------------------------------------------------
#
# input validation
if [ -z "$1" ]; then
    echo "Usage: rbac.sh <ACCESS_GROUP>"
    echo "Limit namespace and secrets access to administrators"
    echo "<ACCESS_GROUP> - The name of the admin group (i.e. <resource_group>-ADMIN)"
    exit
fi

ACCESS_GROUP=$1

# input validation
if [ -z "${ACCESS_GROUP}" ]; then
    echo "Usage: rbac.sh <ACCESS_GROUP>"
    echo "Please provide the name of the admin group (i.e. <resource_group>-ADMIN)"
    exit
fi


# Define permissions for actions that only administrators can perform
cat rbac-roles.yaml | sed "s/#RG-TEAM/#${ACCESS_GROUP}/g" | kubectl apply -f -
