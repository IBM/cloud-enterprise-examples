#!/usr/bin/env bash

# This script is provided in support of the Jenkinsfile to be able to run the terraform
# in a pipeline. The pipeline defined in the Jenkinsfile expects to find three resources
# in the namespace when it runs, listed below. This script creates those resources from
# the files available when it is run.
#
# - environment-tfvars ConfigMap with the contents of environment.tfvars
# - vlan-tfvars ConfigMap with the contents of vlan.tfvars
# - terraform-credentials Secret with the contents of credentials.properties
#
# The script is intended to be run from the terraform/settings directory after the
# environment.tfvars and vlan.tfvars files have been configured to your liking for
# the cluster that will be created. It also expects that the credentials.properties file
# has been updated with the necessary credentials (e.g. the classic credentials are
# provided if a new cluster will be created)

SCRIPT_DIR=$(cd $(dirname $0); pwd -P)

NAMESPACE="${1}"
if [[ -z "${NAMESPACE}" ]]; then
  echo "The target namespace is required as the first parameter"
  exit 1
fi

CREDENTIAL_FILE="${SCRIPT_DIR}/../../credentials.properties"

function prop {
    grep "${1}" "${CREDENTIAL_FILE}" | cut -d'=' -f2
}

if [[ -f "${CREDENTIAL_FILE}" ]]; then
    # Load the credentials
    IBMCLOUD_API_KEY=$(prop 'ibmcloud.api.key')
    CLASSIC_API_KEY=$(prop 'classic.api.key')
    CLASSIC_USERNAME=$(prop 'classic.username')
else
    echo "The credentials.properties file is not found"
    exit 1
fi

kubectl delete configmap/terraform-tfvars -n "${NAMESPACE}" 1> /dev/null 2> /dev/null
kubectl delete secret/terraform-credentials -n "${NAMESPACE}" 1> /dev/null 2> /dev/null

set +x

kubectl create configmap terraform-tfvars -n "${NAMESPACE}" \
  --from-file=environment.tfvars \
  --from-file=vlan.tfvars
cat <<EOF | kubectl apply -n "${NAMESPACE}" -f -
apiVersion: v1
kind: Secret
metadata:
  name: terraform-credentials
stringData:
  ibmcloud.api.key: $IBMCLOUD_API_KEY
  classic.api.key: $CLASSIC_API_KEY
  classic.username: $CLASSIC_USERNAME
EOF
