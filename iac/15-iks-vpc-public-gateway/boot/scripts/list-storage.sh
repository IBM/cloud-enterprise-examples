#!/bin/bash

OUTPUT_FILE="$1"
if [[ -z "${OUTPUT_FILE}" ]]; then
  OUTPUT_FILE="cluster-storage.csv"
fi

CLUSTER_LIST_JSON="cluster-list.json"
ibmcloud ks cluster ls --json > ${CLUSTER_LIST_JSON}

echo "StorageType,StorageID,ClusterID,ClusterName,CapacityGB,Region,PV,PVC,Namespace"

STORAGE_TYPES="block file"
for STORAGE_TYPE in $STORAGE_TYPES; do
  ibmcloud sl "${STORAGE_TYPE}" volume-list \
    --column id \
    --column capacity_gb \
    --column notes \
    --sortby capacity_gb | \
  grep -vE "id *capacity_gb *notes" | \
  while read line; do 
    ID=$(echo "${line}" | sed -E "s/^([0-9]+) .*/\1/g"); 
    CAPACITY=$(echo "${line}" | sed -E "s/^[0-9]+ +([0-9]*) .*/\1/g"); 
    CLUSTER_JSON=$(echo "${line}" | sed -E "s/^[0-9]+ +[0-9]+ +(.*)/\1/g");

    REGION=$(echo "${CLUSTER_JSON}" | jq -r .region)
    export CLUSTER_ID=$(echo "${CLUSTER_JSON}" | jq -r .cluster)
    CLUSTER_NAME=$(cat ${CLUSTER_LIST_JSON} | jq -r 'first(.[] | select(.id==$ENV.CLUSTER_ID) | .name)')
    PV=$(echo "${CLUSTER_JSON}" | jq -r .pv)
    PVC=$(echo "${CLUSTER_JSON}" | jq -r .pvc)
    NAMESPACE=$(echo "${CLUSTER_JSON}" | jq -r .ns)

    if [[ -z "${CLUSTER_NAME}" ]]; then
      CLUSTER_NAME="<not found>"
    fi

    echo "${STORAGE_TYPE},${ID},${CLUSTER_ID},${CLUSTER_NAME},${CAPACITY},${REGION},${PV},${PVC},${NAMESPACE}"
  done
done