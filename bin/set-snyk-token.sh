#!/bin/bash -e

SCRIPTDIR=$CODESPACE_VSCODE_FOLDER/bin

if [ -z "$PIPELINE" ]
then
    printf "Missing PIPELINE environment variable.\nValue must match a file in the ./bin/config folder\n"
    return 1
fi

CONFIG_FILE="$SCRIPTDIR/config/$PIPELINE.cfg"

if [ ! -f  "$CONFIG_FILE" ]
then
    printf "Unable to find config file %s\n" "$CONFIG_FILE"
    return 1
fi

source "$CONFIG_FILE" 2> /dev/null


printf "Successfully reading config file (%s)\n" "$CONFIG_FILE"

printf "Logging in to Azure CLI with Service Principal %s\n" "$CFG_SP_ID"

if [ ! -n "$VAULT_ACCESS" ]; 
then
    printf "Missing VAULT_ACCESS environment variable.\n Unable to login to Azure CLI.\n"
    return 1
fi

az login --service-principal --username $CFG_SP_ID --tenant $CFG_AZURE_TENANT_ID --password $VAULT_ACCESS -o none

printf "Retrieving and setting the SNYK_TOKEN environment variable\n"

export SNYK_TOKEN=$(az keyvault secret show --id $CFG_VAULT_SNYK_SECRET_ID --query value --output tsv)

