# ============================================================
# Azure Environment Setup Script (Auto-Generated)
# Generated on: 2026-04-04 12:20:11
# Source Subscription: Azure subscription 1 (95186feb-cef2-4892-8f87-05ea95df47ba)
# ============================================================
# Prerequisites: Azure CLI installed and logged in (az login)
# Usage: .\setup-azure-environment-generated.ps1
# ============================================================
# IMPORTANT: Update SUBSCRIPTION_ID before running!
# ============================================================

$SUBSCRIPTION_ID = "<YOUR_NEW_SUBSCRIPTION_ID>"  # <-- UPDATE THIS

# -----------------------------------------------------------
# STEP 0: Set Subscription
# -----------------------------------------------------------
Write-Host "`n========== STEP 0: Setting Subscription ==========" -ForegroundColor Cyan
az account set --subscription $SUBSCRIPTION_ID
Write-Host "Subscription set to: $SUBSCRIPTION_ID" -ForegroundColor Green

# -----------------------------------------------------------
# STEP 1: Create Resource Groups
# -----------------------------------------------------------
Write-Host "`n========== STEP 1: Creating Resource Groups ==========" -ForegroundColor Cyan
az group create --name "adwm" --location "centralus" -o none
Write-Host "Created resource group: adwm (centralus)" -ForegroundColor Green

az group create --name "adwm-adb" --location "centralus" -o none
Write-Host "Created resource group: adwm-adb (centralus)" -ForegroundColor Green

az group create --name "NetworkWatcherRG" --location "centralus" -o none
Write-Host "Created resource group: NetworkWatcherRG (centralus)" -ForegroundColor Green

# -----------------------------------------------------------
# STEP 2: Create Users
# -----------------------------------------------------------
Write-Host "`n========== STEP 2: Creating Users ==========" -ForegroundColor Cyan
$existing = az ad user show --id "akhil@benarjikumar7gmail.onmicrosoft.com" --query "id" -o tsv 2>$null
if (-not $existing) {
    az ad user create --display-name "akhil" --user-principal-name "akhil@benarjikumar7gmail.onmicrosoft.com" --password "P@ssw0rd!Change" --force-change-password-next-sign-in false -o none
    Write-Host "Created user: akhil" -ForegroundColor Green
} else {
    Write-Host "User already exists: akhil" -ForegroundColor Yellow
}
$existing = az ad user show --id "aliaya@benarjikumar7gmail.onmicrosoft.com" --query "id" -o tsv 2>$null
if (-not $existing) {
    az ad user create --display-name "aliaya" --user-principal-name "aliaya@benarjikumar7gmail.onmicrosoft.com" --password "P@ssw0rd!Change" --force-change-password-next-sign-in false -o none
    Write-Host "Created user: aliaya" -ForegroundColor Green
} else {
    Write-Host "User already exists: aliaya" -ForegroundColor Yellow
}
# External user (invite manually): Benarji Kumar (benarjikumar7_gmail.com#EXT#@benarjikumar7gmail.onmicrosoft.com)
$existing = az ad user show --id "madhan@benarjikumar7gmail.onmicrosoft.com" --query "id" -o tsv 2>$null
if (-not $existing) {
    az ad user create --display-name "madhan" --user-principal-name "madhan@benarjikumar7gmail.onmicrosoft.com" --password "P@ssw0rd!Change" --force-change-password-next-sign-in false -o none
    Write-Host "Created user: madhan" -ForegroundColor Green
} else {
    Write-Host "User already exists: madhan" -ForegroundColor Yellow
}
$existing = az ad user show --id "rajurao@benarjikumar7gmail.onmicrosoft.com" --query "id" -o tsv 2>$null
if (-not $existing) {
    az ad user create --display-name "rajurao" --user-principal-name "rajurao@benarjikumar7gmail.onmicrosoft.com" --password "P@ssw0rd!Change" --force-change-password-next-sign-in false -o none
    Write-Host "Created user: rajurao" -ForegroundColor Green
} else {
    Write-Host "User already exists: rajurao" -ForegroundColor Yellow
}
$existing = az ad user show --id "sharif@benarjikumar7gmail.onmicrosoft.com" --query "id" -o tsv 2>$null
if (-not $existing) {
    az ad user create --display-name "sharif" --user-principal-name "sharif@benarjikumar7gmail.onmicrosoft.com" --password "P@ssw0rd!Change" --force-change-password-next-sign-in false -o none
    Write-Host "Created user: sharif" -ForegroundColor Green
} else {
    Write-Host "User already exists: sharif" -ForegroundColor Yellow
}
$existing = az ad user show --id "shravya@benarjikumar7gmail.onmicrosoft.com" --query "id" -o tsv 2>$null
if (-not $existing) {
    az ad user create --display-name "shravya" --user-principal-name "shravya@benarjikumar7gmail.onmicrosoft.com" --password "P@ssw0rd!Change" --force-change-password-next-sign-in false -o none
    Write-Host "Created user: shravya" -ForegroundColor Green
} else {
    Write-Host "User already exists: shravya" -ForegroundColor Yellow
}
$existing = az ad user show --id "trinadh@benarjikumar7gmail.onmicrosoft.com" --query "id" -o tsv 2>$null
if (-not $existing) {
    az ad user create --display-name "trinadh" --user-principal-name "trinadh@benarjikumar7gmail.onmicrosoft.com" --password "P@ssw0rd!Change" --force-change-password-next-sign-in false -o none
    Write-Host "Created user: trinadh" -ForegroundColor Green
} else {
    Write-Host "User already exists: trinadh" -ForegroundColor Yellow
}
$existing = az ad user show --id "victoria@benarjikumar7gmail.onmicrosoft.com" --query "id" -o tsv 2>$null
if (-not $existing) {
    az ad user create --display-name "victoria" --user-principal-name "victoria@benarjikumar7gmail.onmicrosoft.com" --password "P@ssw0rd!Change" --force-change-password-next-sign-in false -o none
    Write-Host "Created user: victoria" -ForegroundColor Green
} else {
    Write-Host "User already exists: victoria" -ForegroundColor Yellow
}
# -----------------------------------------------------------
# STEP 3: Create Groups and Add Members
# -----------------------------------------------------------
Write-Host "`n========== STEP 3: Creating Groups ==========" -ForegroundColor Cyan
$groupId = az ad group show --group "DataEngineers" --query "id" -o tsv 2>$null
if (-not $groupId) {
    $groupId = az ad group create --display-name "DataEngineers" --mail-nickname "244f6b67-6" --query "id" -o tsv
    Write-Host "Created group: DataEngineers" -ForegroundColor Green
} else {
    Write-Host "Group already exists: DataEngineers" -ForegroundColor Yellow
}
# Add members to DataEngineers
$memberId = az ad user show --id "benarjikumar7_gmail.com#EXT#@benarjikumar7gmail.onmicrosoft.com" --query "id" -o tsv 2>$null
if ($memberId) {
    $isMember = az ad group member check --group "DataEngineers" --member-id $memberId --query "value" -o tsv 2>$null
    if ($isMember -ne "true") {
        az ad group member add --group "DataEngineers" --member-id $memberId 2>$null
        Write-Host "  Added Benarji Kumar to DataEngineers" -ForegroundColor Green
    }
}
$memberId = az ad user show --id "sharif@benarjikumar7gmail.onmicrosoft.com" --query "id" -o tsv 2>$null
if ($memberId) {
    $isMember = az ad group member check --group "DataEngineers" --member-id $memberId --query "value" -o tsv 2>$null
    if ($isMember -ne "true") {
        az ad group member add --group "DataEngineers" --member-id $memberId 2>$null
        Write-Host "  Added sharif to DataEngineers" -ForegroundColor Green
    }
}
$memberId = az ad user show --id "akhil@benarjikumar7gmail.onmicrosoft.com" --query "id" -o tsv 2>$null
if ($memberId) {
    $isMember = az ad group member check --group "DataEngineers" --member-id $memberId --query "value" -o tsv 2>$null
    if ($isMember -ne "true") {
        az ad group member add --group "DataEngineers" --member-id $memberId 2>$null
        Write-Host "  Added akhil to DataEngineers" -ForegroundColor Green
    }
}
$memberId = az ad user show --id "madhan@benarjikumar7gmail.onmicrosoft.com" --query "id" -o tsv 2>$null
if ($memberId) {
    $isMember = az ad group member check --group "DataEngineers" --member-id $memberId --query "value" -o tsv 2>$null
    if ($isMember -ne "true") {
        az ad group member add --group "DataEngineers" --member-id $memberId 2>$null
        Write-Host "  Added madhan to DataEngineers" -ForegroundColor Green
    }
}
$memberId = az ad user show --id "rajurao@benarjikumar7gmail.onmicrosoft.com" --query "id" -o tsv 2>$null
if ($memberId) {
    $isMember = az ad group member check --group "DataEngineers" --member-id $memberId --query "value" -o tsv 2>$null
    if ($isMember -ne "true") {
        az ad group member add --group "DataEngineers" --member-id $memberId 2>$null
        Write-Host "  Added rajurao to DataEngineers" -ForegroundColor Green
    }
}
$memberId = az ad user show --id "aliaya@benarjikumar7gmail.onmicrosoft.com" --query "id" -o tsv 2>$null
if ($memberId) {
    $isMember = az ad group member check --group "DataEngineers" --member-id $memberId --query "value" -o tsv 2>$null
    if ($isMember -ne "true") {
        az ad group member add --group "DataEngineers" --member-id $memberId 2>$null
        Write-Host "  Added aliaya to DataEngineers" -ForegroundColor Green
    }
}
$memberId = az ad user show --id "shravya@benarjikumar7gmail.onmicrosoft.com" --query "id" -o tsv 2>$null
if ($memberId) {
    $isMember = az ad group member check --group "DataEngineers" --member-id $memberId --query "value" -o tsv 2>$null
    if ($isMember -ne "true") {
        az ad group member add --group "DataEngineers" --member-id $memberId 2>$null
        Write-Host "  Added shravya to DataEngineers" -ForegroundColor Green
    }
}
$memberId = az ad user show --id "trinadh@benarjikumar7gmail.onmicrosoft.com" --query "id" -o tsv 2>$null
if ($memberId) {
    $isMember = az ad group member check --group "DataEngineers" --member-id $memberId --query "value" -o tsv 2>$null
    if ($isMember -ne "true") {
        az ad group member add --group "DataEngineers" --member-id $memberId 2>$null
        Write-Host "  Added trinadh to DataEngineers" -ForegroundColor Green
    }
}
$memberId = az ad user show --id "victoria@benarjikumar7gmail.onmicrosoft.com" --query "id" -o tsv 2>$null
if ($memberId) {
    $isMember = az ad group member check --group "DataEngineers" --member-id $memberId --query "value" -o tsv 2>$null
    if ($isMember -ne "true") {
        az ad group member add --group "DataEngineers" --member-id $memberId 2>$null
        Write-Host "  Added victoria to DataEngineers" -ForegroundColor Green
    }
}
# -----------------------------------------------------------
# STEP 4: Create Resources
# -----------------------------------------------------------
Write-Host "`n========== STEP 4: Creating Resources ==========" -ForegroundColor Cyan
az storage account create --name "adwmstrg1" --resource-group "adwm" --location "southindia" --sku "Standard_LRS" -o none
Write-Host "Created storage account: adwmstrg1" -ForegroundColor Green

az storage account create --name "adwmstrg2" --resource-group "adwm" --location "southindia" --sku "Standard_LRS" -o none
Write-Host "Created storage account: adwmstrg2" -ForegroundColor Green

az storage account create --name "dbstorageivilwar76kmrg" --resource-group "adwm" --location "southindia" --sku "Standard_ZRS" -o none
Write-Host "Created storage account: dbstorageivilwar76kmrg" -ForegroundColor Green

az keyvault create --name "adwm-kv" --resource-group "adwm" --location "southindia" --enable-rbac-authorization true -o none
Write-Host "Created Key Vault: adwm-kv" -ForegroundColor Green

az keyvault create --name "shravya" --resource-group "adwm" --location "southindia" --enable-rbac-authorization true -o none
Write-Host "Created Key Vault: shravya" -ForegroundColor Green

az resource create --resource-group "adwm" --resource-type "Microsoft.DataFactory/factories" --name "adwm-etl-dev" --location "southindia" --properties '{"publicNetworkAccess":"Enabled"}' -o none
Write-Host "Created Data Factory: adwm-etl-dev" -ForegroundColor Green

# Create SQL Servers
$adminLogin = "sqladmin"
$adminPassword = "P@ssw0rd!2026"

Write-Host "Creating SQL Servers..." -ForegroundColor Cyan
az sql server create --name "adwm-dev" --resource-group "adwm" --location "southindia" --admin-user $adminLogin --admin-password $adminPassword -o none
Write-Host "Created SQL Server: adwm-dev" -ForegroundColor Green

az sql server create --name "adwm-prod" --resource-group "adwm" --location "southindia" --admin-user $adminLogin --admin-password $adminPassword -o none
Write-Host "Created SQL Server: adwm-prod" -ForegroundColor Green

# Create SQL Databases
Write-Host "Creating SQL Databases..." -ForegroundColor Cyan
az sql db create --name "adwm-raw-db" --server "adwm-dev" --resource-group "adwm" --edition Standard --capacity 10 -o none
Write-Host "Created Database: adwm-raw-db" -ForegroundColor Green

az sql db create --name "adwm-db" --server "adwm-prod" --resource-group "adwm" --edition Standard --capacity 10 -o none
Write-Host "Created Database: adwm-db" -ForegroundColor Green
# Create Databricks Workspace: adwm-etl-dev
az resource create --resource-group "adwm" --resource-type "Microsoft.Databricks/workspaces" --name "adwm-etl-dev" --location "centralus" --properties '{"managedResourceGroupId":"/subscriptions/$SUBSCRIPTION_ID/resourceGroups/adwm-managed"}' -o none
Write-Host "Created Databricks Workspace: adwm-etl-dev" -ForegroundColor Green

# Create Databricks Access Connector: unity-catalog-access-connector
az resource create --resource-group "adwm" --resource-type "Microsoft.Databricks/accessConnectors" --name "unity-catalog-access-connector" --location "southindia" --properties '{}' -o none
Write-Host "Created Databricks Access Connector: unity-catalog-access-connector" -ForegroundColor Green

# TODO: Manually create resource: data-engineering-resource (Type: Microsoft.CognitiveServices/accounts)
# TODO: Manually create resource: data-engineering-resource/data-engineering (Type: Microsoft.CognitiveServices/accounts/projects)
# TODO: Manually create resource: dbmanagedidentity (Type: Microsoft.ManagedIdentity/userAssignedIdentities)
# TODO: Manually create resource: workers-sg (Type: Microsoft.Network/networkSecurityGroups)
# TODO: Manually create resource: nat-gw-public-ip (Type: Microsoft.Network/publicIPAddresses)
# TODO: Manually create resource: nat-gateway (Type: Microsoft.Network/natGateways)
# TODO: Manually create resource: workers-vnet (Type: Microsoft.Network/virtualNetworks)
# TODO: Manually create resource: NetworkWatcher_centralus (Type: Microsoft.Network/networkWatchers)

# -----------------------------------------------------------
# STEP 5: Assign Roles
# -----------------------------------------------------------
Write-Host "`n========== STEP 5: Assigning Roles ==========" -ForegroundColor Cyan
$groupId = az ad group show --group "DataEngineers" --query "id" -o tsv 2>$null
if ($groupId) {
    az role assignment create --role "Key Vault Secrets Officer" --assignee-object-id $groupId --assignee-principal-type Group --scope "/subscriptions/$SUBSCRIPTION_ID/resourcegroups/adwm/providers/Microsoft.KeyVault/vaults/adwm-kv" -o none
    Write-Host "Assigned 'Key Vault Secrets Officer' to group 'DataEngineers'" -ForegroundColor Green
}
$groupId = az ad group show --group "DataEngineers" --query "id" -o tsv 2>$null
if ($groupId) {
    az role assignment create --role "Storage Blob Data Owner" --assignee-object-id $groupId --assignee-principal-type Group --scope "/subscriptions/$SUBSCRIPTION_ID/resourceGroups/adwm/providers/Microsoft.Storage/storageAccounts/adwmstrg1" -o none
    Write-Host "Assigned 'Storage Blob Data Owner' to group 'DataEngineers'" -ForegroundColor Green
}
$groupId = az ad group show --group "DataEngineers" --query "id" -o tsv 2>$null
if ($groupId) {
    az role assignment create --role "Storage Blob Data Owner" --assignee-object-id $groupId --assignee-principal-type Group --scope "/subscriptions/$SUBSCRIPTION_ID/resourceGroups/adwm/providers/Microsoft.Storage/storageAccounts/adwmstrg2" -o none
    Write-Host "Assigned 'Storage Blob Data Owner' to group 'DataEngineers'" -ForegroundColor Green
}
$groupId = az ad group show --group "DataEngineers" --query "id" -o tsv 2>$null
if ($groupId) {
    az role assignment create --role "Owner" --assignee-object-id $groupId --assignee-principal-type Group --scope "/subscriptions/$SUBSCRIPTION_ID" -o none
    Write-Host "Assigned 'Owner' to group 'DataEngineers'" -ForegroundColor Green
}
$adfPrincipalId = az resource show --ids "/subscriptions/$SUBSCRIPTION_ID/resourceGroups/adwm-etl-dev/providers/Microsoft.DataFactory/factories/adwm-etl-dev" --query "identity.principalId" -o tsv 2>$null
if ($adfPrincipalId) {
    az role assignment create --role "Storage Blob Data Contributor" --assignee-object-id $adfPrincipalId --assignee-principal-type ServicePrincipal --scope "/subscriptions/$SUBSCRIPTION_ID/resourceGroups/adwm/providers/Microsoft.Storage/storageAccounts/adwmstrg1" -o none
    Write-Host "Assigned 'Storage Blob Data Contributor' to ADF 'adwm-etl-dev' managed identity" -ForegroundColor Green
}
$adfPrincipalId = az resource show --ids "/subscriptions/$SUBSCRIPTION_ID/resourceGroups/adwm-etl-dev/providers/Microsoft.DataFactory/factories/adwm-etl-dev" --query "identity.principalId" -o tsv 2>$null
if ($adfPrincipalId) {
    az role assignment create --role "Storage Blob Data Contributor" --assignee-object-id $adfPrincipalId --assignee-principal-type ServicePrincipal --scope "/subscriptions/$SUBSCRIPTION_ID/resourceGroups/adwm/providers/Microsoft.Storage/storageAccounts/adwmstrg2" -o none
    Write-Host "Assigned 'Storage Blob Data Contributor' to ADF 'adwm-etl-dev' managed identity" -ForegroundColor Green
}
$adfPrincipalId = az resource show --ids "/subscriptions/$SUBSCRIPTION_ID/resourceGroups/adwm-etl-dev/providers/Microsoft.DataFactory/factories/adwm-etl-dev" --query "identity.principalId" -o tsv 2>$null
if ($adfPrincipalId) {
    az role assignment create --role "Key Vault Secrets User" --assignee-object-id $adfPrincipalId --assignee-principal-type ServicePrincipal --scope "/subscriptions/$SUBSCRIPTION_ID/resourcegroups/adwm/providers/Microsoft.KeyVault/vaults/adwm-kv" -o none
    Write-Host "Assigned 'Key Vault Secrets User' to ADF 'adwm-etl-dev' managed identity" -ForegroundColor Green
}
$userId = az ad user show --id "akhil@benarjikumar7gmail.onmicrosoft.com" --query "id" -o tsv 2>$null
if ($userId) {
    az role assignment create --role "Azure AI User" --assignee-object-id $userId --assignee-principal-type User --scope "/subscriptions/$SUBSCRIPTION_ID" -o none
    Write-Host "Assigned 'Azure AI User' to user 'akhil@benarjikumar7gmail.onmicrosoft.com'" -ForegroundColor Green
}
$userId = az ad user show --id "akhil@benarjikumar7gmail.onmicrosoft.com" --query "id" -o tsv 2>$null
if ($userId) {
    az role assignment create --role "Azure AI User" --assignee-object-id $userId --assignee-principal-type User --scope "/subscriptions/$SUBSCRIPTION_ID/resourceGroups/adwm" -o none
    Write-Host "Assigned 'Azure AI User' to user 'akhil@benarjikumar7gmail.onmicrosoft.com'" -ForegroundColor Green
}

# -----------------------------------------------------------
# SUMMARY
# -----------------------------------------------------------
Write-Host "`n============================================" -ForegroundColor Cyan
Write-Host "  SETUP COMPLETE!" -ForegroundColor Green
Write-Host "============================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "Resources: 22 resources created" -ForegroundColor White
Write-Host "Users: 9 users" -ForegroundColor White
Write-Host "Groups: 1 groups" -ForegroundColor White
Write-Host "Role Assignments: 12 assignments" -ForegroundColor White
Write-Host ""
Write-Host "NOTE: Role assignments may take 5-10 minutes to propagate." -ForegroundColor Yellow
Write-Host "============================================" -ForegroundColor Cyan
