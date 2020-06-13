#!/usr/bin/env bash

SCRIPT_DIR=$(cd $(dirname $0); pwd -P)

function join_by { local IFS="$1"; shift; echo "$*"; }

. ${SCRIPT_DIR}/../settings/environment.tfvars

if [[ -n "${name_prefix}" ]]; then
  PREFIX="${name_prefix}"
else
  PREFIX="${resource_group_name}"
fi

echo "Looking for services in resource group: ${PREFIX}"

SERVICES=$(ibmcloud resource service-instances -g "${resource_group_name}" | grep -E "^${PREFIX}" | sed -E "s/(${PREFIX}[^ ]*).*/\1/g" | sort | uniq)

FILTER=$(join_by "|" $@)
FORCE=$(echo "$@" | grep -- "--force")

if [[ -n "${FILTER}" ]]; then
    FILTERED_LIST=$(echo "${SERVICES}" | grep -E -v -- "${FILTER}")
else
    FILTERED_LIST="${SERVICES}"
fi

if [[ -z "${FILTERED_LIST}" ]]; then
    echo "No services found"
    exit 0
fi

echo "The following services will be deleted:"
echo "${FILTERED_LIST}" | while read service; do
    echo " - ${service}"
done

if [[ -z "${FILTER}" ]]; then
    echo ""
    echo "Note: if you want to exclude any of these services, pass part of the name as an argument (e.g. destroy-services.sh postgres)"
fi

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

echo "${FILTERED_LIST}" | while read service; do
    SERVICE_IDS=$(ibmcloud resource service-instance "${service}" -g "${resource_group_name}" --id | grep -E "^crn" | sed -E "s/(.*::).*/\1/g")

    echo "${SERVICE_IDS}" | while read -r service_id; do
      echo "Service: ${service}, ID: ${service_id}"
      ibmcloud resource service-instance-delete "${service_id}" --recursive -f
    done
done
