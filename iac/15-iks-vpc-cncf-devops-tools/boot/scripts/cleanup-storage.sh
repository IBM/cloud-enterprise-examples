#!/bin/bash

exec 3< /dev/stdin

FORCE=""
SKIP_ACL=""

while test $# -gt 0
do
    case "$1" in
        --force) FORCE="--force"
            ;;
        --skip-acl) SKIP_ACL="true"
            ;;
        --help)
            echo "Usage:"
            echo "cleanup-storage.sh [--force] [--skip-acl] [{file name}]"
            exit 0
            ;;
        *) FILE_NAME="$1"
            ;;
    esac
    shift
done

while read line; do
  STORAGE_TYPE=$(echo "${line}" | sed -E "s/^(file|block|StorageType),([0-9]+)(,.*|$)/\1/g")
  STORAGE_ID=$(echo "${line}" | sed -E "s/^(file|block|StorageType),([0-9]+)(,.*|$)/\2/g")

  if [[ "${STORAGE_TYPE}" == "StorageType" ]]; then
    continue
  fi
  
  ACL_ID=$(ibmcloud sl ${STORAGE_TYPE} access-list ${STORAGE_ID} --column id | grep -v id)
  if [[ -z "${SKIP_ACL}" ]] && [[ -n "${ACL_ID}" ]]; then
    echo "Storage volume still has ACLs: ${STORAGE_ID}. Skipping"
    continue
  fi

  echo "Canceling ${STORAGE_TYPE} volume: ${STORAGE_ID}"
  ibmcloud sl ${STORAGE_TYPE} volume-cancel ${STORAGE_ID} --immediate $FORCE <&3
done < "${FILE_NAME:-/dev/stdin}"