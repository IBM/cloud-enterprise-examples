#!/usr/bin/env bash

SCRIPT_DIR=$(cd $(dirname $0); pwd -P)

. ${SCRIPT_DIR}/../settings/environment.tfvars

FORCE=$(echo "$@" | grep -- "--force")

echo "Deleting cluster: ${cluster_name}"

if [[ -z "${FORCE}" ]]; then
    echo ""
    echo -n "Do you want to continue? [Y/n] "
    read input

    if [[ -z "${input}" ]] || [[ "${input}" =~ [yY] ]]; then
        echo -n ""
    else
        exit 0
    fi
fi

ibmcloud ks cluster rm --cluster "${cluster_name}" -f --force-delete-storage
