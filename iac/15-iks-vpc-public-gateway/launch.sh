#!/bin/bash

# IBM Cloud Garage, Catalyst Team

SCRIPT_DIR="$(cd $(dirname $0); pwd -P)"
SRC_DIR="$(cd "${SCRIPT_DIR}/boot" ; pwd -P)"

DOCKER_IMAGE="ibmgaragecloud/cli-tools:0.3.1-lite"

helpFunction()
{
    RED='\033[0;31m'
    CYAN='\033[0;36m'
    LIGHT_GRAY='\033[0;37m'
    GREEN='\033[0;32m'
    NC='\033[0m' # No Color

    error="$1"

    echo "Iteration Zero Setup"
    echo -e "This script will help setup setup a development environment and tools on the IBM Public Kubernetes Service"
    echo ""
    echo -e "${CYAN}Usage:${NC} $0"
    echo ""
    if [[ "${error}" =~ "file is not found" ]]; then
        echo -e "${RED}${error}${NC}"
        echo -e "Credentials should be provided in a file named ${CYAN}'${ENV}.properties'${NC}"
    else
        echo -e "${RED}${error}${NC}"
        echo -e "The ${ENV}.properties file should contain the following values:"
        echo -e "   ${GREEN}ibmcloud.api.key${NC} is the IBM Cloud api key"
        echo -e "   ${GREEN}classic.username${NC} is the Classic Infrastructure user name or API user name (e.g. 282165_joe@us.ibm.com)"
        echo -e "   ${GREEN}classic.api.key${NC} is the Classic Infrastructure api key"
    fi

   echo ""
   exit 1 # Exit script after printing help
}

ENV="credentials"

function prop {
    grep "${1}" ${ENV}.properties | cut -d'=' -f2
}

if [[ -f "${ENV}.properties" ]]; then
    # Load the credentials
    IBMCLOUD_API_KEY=$(prop 'ibmcloud.api.key')
    CLASSIC_API_KEY=$(prop 'classic.api.key')
    CLASSIC_USERNAME=$(prop 'classic.username')
else
    helpFunction "The ${ENV}.properties file is not found."
fi

# Print helpFunction in case parameters are empty
if [[ -z "${IBMCLOUD_API_KEY}" ]] || [[ -z "${CLASSIC_USERNAME}" ]] || [[ -z "${CLASSIC_API_KEY}" ]]
then
    helpFunction "Some of the credentials values are empty. "
fi

SUFFIX=$(echo $(basename ${SCRIPT_DIR}) | base64 | sed -E "s/[^a-zA-Z0-9_.-]//g" | sed -E "s/.*(.{5})/\1/g")
CONTAINER_NAME="ibm-garage-cli-tools-${SUFFIX}"

echo "Cleaning up old container: ${CONTAINER_NAME}"

DOCKER_CMD="docker"
${DOCKER_CMD} kill ${CONTAINER_NAME} 1> /dev/null 2> /dev/null
${DOCKER_CMD} rm ${CONTAINER_NAME} 1> /dev/null 2> /dev/null

if [[ -n "$1" ]]; then
    echo "Pulling container image: ${DOCKER_IMAGE}"
    ${DOCKER_CMD} pull "${DOCKER_IMAGE}"
fi

echo "Initializing container ${CONTAINER_NAME} from ${DOCKER_IMAGE}"
${DOCKER_CMD} run -itd --name ${CONTAINER_NAME} \
   -v ${SRC_DIR}:/home/devops/src \
   -e TF_VAR_ibmcloud_api_key="${IBMCLOUD_API_KEY}" \
   -e IBMCLOUD_API_KEY="${IBMCLOUD_API_KEY}" \
   -e IAAS_CLASSIC_USERNAME="${CLASSIC_USERNAME}" \
   -e IAAS_CLASSIC_API_KEY="${CLASSIC_API_KEY}" \
   -w /home/devops/src \
   ${DOCKER_IMAGE}

echo "Attaching to running container..."
${DOCKER_CMD} attach ${CONTAINER_NAME}
