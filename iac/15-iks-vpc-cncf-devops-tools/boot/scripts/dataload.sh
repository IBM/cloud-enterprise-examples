#!/bin/sh
# Cloudant Database Data Load Utility

# Load data from a file by passing the file name as the first (and only) argument 
# OR provide the database contents via stdin (e.g. `./dataload.sh < file` or `cat file | ./dataload.sh`

# Credentials from IBM Cloud add API_KEY and USERNAME from Cloudant
CLOUDANT_API_KEY=
CLOUDANT_USERNAME=

# Add name of database to load data into
DATABASE=

# input validation
if [ -z "${CLOUDANT_API_KEY}" ]; then
    echo "Please provide your CLOUDANT_API_KEY."
    exit
fi

# input validation
if [ -z "${CLOUDANT_USERNAME}" ]; then
    echo "Please provide your CLOUDANT_USERNAME."
    exit
fi


# Get a Bearer Token from IBM Cloud IAM
IAM_AUTH=$(curl -s -k -X POST \
  --header "Content-Type: application/x-www-form-urlencoded" \
  --header "Accept: application/json" \
  --data-urlencode "grant_type=urn:ibm:params:oauth:grant-type:apikey" \
  --data-urlencode "apikey=${CLOUDANT_API_KEY}" \
  "https://iam.cloud.ibm.com/identity/token")

# Extract the Bearer Token from IAM response
TOKEN=$(echo $IAM_AUTH |  jq '.access_token' | tr -d '"')
BEARER_TOKEN="Bearer ${TOKEN}"


# credentials to post data to cloudant for bulk document upload
ACURL="curl -s --proto '=https' -g -H 'Authorization: ${BEARER_TOKEN}'"
HOST="https://${CLOUDANT_USERNAME}.cloudantnosqldb.appdomain.cloud"

# Inventory
echo "Deleting existing database: ${DATABASE}"
echo "  \c"
eval ${ACURL} -X DELETE "${HOST}/${DATABASE}"

echo "Creating new database: ${DATABASE}"
echo "  \c"
eval ${ACURL} -X PUT "${HOST}/${DATABASE}"

if [[ "${1:--}" == "-" ]]; then
  echo "Loading data into database from stdin"
else
  echo "Loading data into database from ${1}"
fi
echo "  \c"
eval ${ACURL} -H "Content-Type:application/json" -d "@${1:--}" -X POST "${HOST}/${DATABASE}/_bulk_docs"

