#############################################################################
# Bash script using Azure CLI to create am Azure DevOpsProject with ServiceConnection
# This script reads command line parameters to define:
# - $1 = Project Name
# - $2 = Organization Uri
#############################################################################

adoProjectName=$1
adoOrganizationUri=$2
resourceGroupName=$3

echo "adoProjectName: $adoProjectName"
echo "adoOrganizationUri: $adoOrganizationUri"
echo "resourceGroupName: $resourceGroupName"

subscriptionId=$(az account show | jq -r '.id')
subscriptionName=$(az account show | jq -r '.name')
name= "$adoProjectName-spn"

echo "subscriptionId: $subscriptionId"
echo "subscriptionName: $subscriptionName"
echo "name: $name"

response=$(az ad sp create-for-rbac -n $name --role contributor \
    --scopes /subscriptions/$subscriptionId/resourceGroups/$resourceGroupName)

appId=$(echo $response | jq -r '.appId')
tenantId=$(echo $response | jq -r '.tenant')
export AZURE_DEVOPS_EXT_AZURE_RM_SERVICE_PRINCIPAL_KEY=$(echo $response | jq -r '.password')

az devops service-endpoint azurerm create --azure-rm-service-principal-id "$appId" \
                                          --azure-rm-subscription-id "$subscriptionId" \
                                          --azure-rm-subscription-name "$subscriptionName" \
                                          --azure-rm-tenant-id "$tenantId" \
                                          --name "$name" \
                                          --project "$adoProjectName" \
                                          --organization "$adoOrganizationUri"
