#############################################################################
# Bash script using Azure CLI to create am Azure DevOpsProject with ServiceConnection
# This script reads command line parameters to define:
# - $1 = Project Name
# - $2 = Organization Uri
#############################################################################

adoProjectName=$1
adoOrganizationUri=$2

echo "adoProjectName: $adoProjectName"
echo "adoOrganizationUri: $adoOrganizationUri"

az devops project create --name $adoProjectName --organization $adoOrganizationUri