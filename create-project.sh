#############################################################################
# Bash script using Azure CLI to create am Azure DevOpsProject with ServiceConnection
# This script reads command line parameters to define:
# - $1 = Project Name
#############################################################################

adoProjectName=$1

echo "adoProjectName: $adoProjectName"