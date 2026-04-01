# ============================================================
# Azure Environment Setup Script
# Automates: Users, Group, Resources, and Role Assignments
# ============================================================
# Prerequisites: Azure CLI installed and logged in (az login)
# Usage: .\setup-azure-environment.ps1
# ============================================================

# -----------------------------------------------------------
# CONFIGURATION - Update these values for your new subscription
# -----------------------------------------------------------
$SUBSCRIPTION_ID   = "<YOUR_NEW_SUBSCRIPTION_ID>"   # Update after creating new subscription
$LOCATION          = "southindia"
$RESOURCE_GROUP    = "adwm"
$GROUP_NAME        = "DataEngineers"
$DOMAIN            = "benarjikumar7gmail.onmicrosoft.com"  # Your Entra ID domain

# Resource Names
$STORAGE_ACCOUNT_1 = "adwmstrg1"
$STORAGE_ACCOUNT_2 = "adwmstrg2"
$KEY_VAULT_NAME    = "adwm-kv"
$ADF_NAME          = "adwm-etl-dev"

# Users to create (displayName, mailNickname, password)
$USERS = @(
    @{ displayName = "sharif";   mailNickname = "sharif";   password = "P@ssw0rd!2026" },
    @{ displayName = "akhil";    mailNickname = "akhil";    password = "P@ssw0rd!2026" },
    @{ displayName = "aliaya";   mailNickname = "aliaya";   password = "P@ssw0rd!2026" },
    @{ displayName = "madhan";   mailNickname = "madhan";   password = "P@ssw0rd!2026" },
    @{ displayName = "rajurao";  mailNickname = "rajurao";  password = "P@ssw0rd!2026" },
    @{ displayName = "shravya";  mailNickname = "shravya";  password = "P@ssw0rd!2026" },
    @{ displayName = "trinadh";  mailNickname = "trinadh";  password = "P@ssw0rd!2026" },
    @{ displayName = "victoria"; mailNickname = "victoria"; password = "P@ssw0rd!2026" }
)

# -----------------------------------------------------------
# STEP 0: Login and Set Subscription
# -----------------------------------------------------------
Write-Host "`n========== STEP 0: Setting Subscription ==========" -ForegroundColor Cyan
az account set --subscription $SUBSCRIPTION_ID
Write-Host "Subscription set to: $SUBSCRIPTION_ID" -ForegroundColor Green

# -----------------------------------------------------------
# STEP 1: Create Resource Group
# -----------------------------------------------------------
Write-Host "`n========== STEP 1: Creating Resource Group ==========" -ForegroundColor Cyan
az group create --name $RESOURCE_GROUP --location $LOCATION -o none
Write-Host "Resource Group '$RESOURCE_GROUP' created in '$LOCATION'" -ForegroundColor Green

# -----------------------------------------------------------
# STEP 2: Create Users in Entra ID
# -----------------------------------------------------------
Write-Host "`n========== STEP 2: Creating Users ==========" -ForegroundColor Cyan
$userObjectIds = @{}

foreach ($user in $USERS) {
    $upn = "$($user.mailNickname)@$DOMAIN"
    
    # Check if user already exists
    $existingUser = az ad user show --id $upn --query "id" -o tsv 2>$null
    
    if ($existingUser) {
        Write-Host "User '$upn' already exists (ID: $existingUser)" -ForegroundColor Yellow
        $userObjectIds[$user.mailNickname] = $existingUser
    } else {
        $userId = az ad user create `
            --display-name $user.displayName `
            --user-principal-name $upn `
            --password $user.password `
            --force-change-password-next-sign-in false `
            --query "id" -o tsv
        Write-Host "Created user '$upn' (ID: $userId)" -ForegroundColor Green
        $userObjectIds[$user.mailNickname] = $userId
    }
}

# -----------------------------------------------------------
# STEP 3: Create Entra ID Group
# -----------------------------------------------------------
Write-Host "`n========== STEP 3: Creating Group ==========" -ForegroundColor Cyan

$existingGroup = az ad group show --group $GROUP_NAME --query "id" -o tsv 2>$null

if ($existingGroup) {
    Write-Host "Group '$GROUP_NAME' already exists (ID: $existingGroup)" -ForegroundColor Yellow
    $groupObjectId = $existingGroup
} else {
    $groupObjectId = az ad group create `
        --display-name $GROUP_NAME `
        --mail-nickname $GROUP_NAME `
        --query "id" -o tsv
    Write-Host "Created group '$GROUP_NAME' (ID: $groupObjectId)" -ForegroundColor Green
}

# -----------------------------------------------------------
# STEP 4: Add Users to Group
# -----------------------------------------------------------
Write-Host "`n========== STEP 4: Adding Users to Group ==========" -ForegroundColor Cyan

foreach ($user in $USERS) {
    $memberId = $userObjectIds[$user.mailNickname]
    
    # Check if already a member
    $isMember = az ad group member check --group $GROUP_NAME --member-id $memberId --query "value" -o tsv 2>$null
    
    if ($isMember -eq "true") {
        Write-Host "$($user.displayName) is already a member of '$GROUP_NAME'" -ForegroundColor Yellow
    } else {
        az ad group member add --group $GROUP_NAME --member-id $memberId 2>$null
        Write-Host "Added $($user.displayName) to '$GROUP_NAME'" -ForegroundColor Green
    }
}

# Also add the account owner (external user) if exists
$ownerUpn = "benarjikumar7_gmail.com#EXT#@$DOMAIN"
$ownerId = az ad user show --id $ownerUpn --query "id" -o tsv 2>$null
if ($ownerId) {
    $isMember = az ad group member check --group $GROUP_NAME --member-id $ownerId --query "value" -o tsv 2>$null
    if ($isMember -ne "true") {
        az ad group member add --group $GROUP_NAME --member-id $ownerId 2>$null
        Write-Host "Added Benarji Kumar (owner) to '$GROUP_NAME'" -ForegroundColor Green
    } else {
        Write-Host "Benarji Kumar (owner) is already a member of '$GROUP_NAME'" -ForegroundColor Yellow
    }
}

# -----------------------------------------------------------
# STEP 5: Create Storage Accounts
# -----------------------------------------------------------
Write-Host "`n========== STEP 5: Creating Storage Accounts ==========" -ForegroundColor Cyan

az storage account create --name $STORAGE_ACCOUNT_1 --resource-group $RESOURCE_GROUP --location $LOCATION --sku Standard_LRS -o none
Write-Host "Storage Account '$STORAGE_ACCOUNT_1' created" -ForegroundColor Green

az storage account create --name $STORAGE_ACCOUNT_2 --resource-group $RESOURCE_GROUP --location $LOCATION --sku Standard_LRS -o none
Write-Host "Storage Account '$STORAGE_ACCOUNT_2' created" -ForegroundColor Green

# -----------------------------------------------------------
# STEP 6: Create Key Vault (with RBAC authorization)
# -----------------------------------------------------------
Write-Host "`n========== STEP 6: Creating Key Vault ==========" -ForegroundColor Cyan

az keyvault create `
    --name $KEY_VAULT_NAME `
    --resource-group $RESOURCE_GROUP `
    --location $LOCATION `
    --enable-rbac-authorization true `
    -o none
Write-Host "Key Vault '$KEY_VAULT_NAME' created with RBAC authorization" -ForegroundColor Green

# -----------------------------------------------------------
# STEP 7: Create Azure Data Factory
# -----------------------------------------------------------
Write-Host "`n========== STEP 7: Creating Azure Data Factory ==========" -ForegroundColor Cyan

az resource create `
    --resource-group $RESOURCE_GROUP `
    --resource-type "Microsoft.DataFactory/factories" `
    --name $ADF_NAME `
    --location $LOCATION `
    --properties '{"publicNetworkAccess":"Enabled"}' `
    -o none
Write-Host "Azure Data Factory '$ADF_NAME' created" -ForegroundColor Green

# Get ADF Managed Identity
$adfPrincipalId = az resource show `
    --ids "/subscriptions/$SUBSCRIPTION_ID/resourceGroups/$RESOURCE_GROUP/providers/Microsoft.DataFactory/factories/$ADF_NAME" `
    --query "identity.principalId" -o tsv
Write-Host "ADF Managed Identity: $adfPrincipalId" -ForegroundColor Green

# -----------------------------------------------------------
# STEP 8: Assign Roles
# -----------------------------------------------------------
Write-Host "`n========== STEP 8: Assigning Roles ==========" -ForegroundColor Cyan

# 8a. DataEngineers group -> Owner at subscription level
Write-Host "Assigning Owner to DataEngineers group (subscription scope)..." -ForegroundColor White
az role assignment create `
    --role "Owner" `
    --assignee-object-id $groupObjectId `
    --assignee-principal-type Group `
    --scope "/subscriptions/$SUBSCRIPTION_ID" `
    -o none
Write-Host "  -> Owner assigned to DataEngineers group" -ForegroundColor Green

# 8b. DataEngineers group -> Key Vault Secrets Officer on Key Vault
Write-Host "Assigning Key Vault Secrets Officer to DataEngineers group..." -ForegroundColor White
az role assignment create `
    --role "Key Vault Secrets Officer" `
    --assignee-object-id $groupObjectId `
    --assignee-principal-type Group `
    --scope "/subscriptions/$SUBSCRIPTION_ID/resourcegroups/$RESOURCE_GROUP/providers/Microsoft.KeyVault/vaults/$KEY_VAULT_NAME" `
    -o none
Write-Host "  -> Key Vault Secrets Officer assigned on $KEY_VAULT_NAME" -ForegroundColor Green

# 8c. DataEngineers group -> Storage Blob Data Owner on Storage Accounts
Write-Host "Assigning Storage Blob Data Owner to DataEngineers group..." -ForegroundColor White
foreach ($storageAccount in @($STORAGE_ACCOUNT_1, $STORAGE_ACCOUNT_2)) {
    az role assignment create `
        --role "Storage Blob Data Owner" `
        --assignee-object-id $groupObjectId `
        --assignee-principal-type Group `
        --scope "/subscriptions/$SUBSCRIPTION_ID/resourceGroups/$RESOURCE_GROUP/providers/Microsoft.Storage/storageAccounts/$storageAccount" `
        -o none
    Write-Host "  -> Storage Blob Data Owner assigned on $storageAccount" -ForegroundColor Green
}

# 8d. ADF Managed Identity -> Storage Blob Data Contributor on Storage Accounts
Write-Host "Assigning Storage Blob Data Contributor to ADF managed identity..." -ForegroundColor White
foreach ($storageAccount in @($STORAGE_ACCOUNT_1, $STORAGE_ACCOUNT_2)) {
    az role assignment create `
        --role "Storage Blob Data Contributor" `
        --assignee-object-id $adfPrincipalId `
        --assignee-principal-type ServicePrincipal `
        --scope "/subscriptions/$SUBSCRIPTION_ID/resourceGroups/$RESOURCE_GROUP/providers/Microsoft.Storage/storageAccounts/$storageAccount" `
        -o none
    Write-Host "  -> Storage Blob Data Contributor assigned on $storageAccount" -ForegroundColor Green
}

# 8e. ADF Managed Identity -> Key Vault Secrets User on Key Vault
Write-Host "Assigning Key Vault Secrets User to ADF managed identity..." -ForegroundColor White
az role assignment create `
    --role "Key Vault Secrets User" `
    --assignee-object-id $adfPrincipalId `
    --assignee-principal-type ServicePrincipal `
    --scope "/subscriptions/$SUBSCRIPTION_ID/resourcegroups/$RESOURCE_GROUP/providers/Microsoft.KeyVault/vaults/$KEY_VAULT_NAME" `
    -o none
Write-Host "  -> Key Vault Secrets User assigned on $KEY_VAULT_NAME" -ForegroundColor Green

# -----------------------------------------------------------
# SUMMARY
# -----------------------------------------------------------
Write-Host "`n============================================" -ForegroundColor Cyan
Write-Host "  SETUP COMPLETE!" -ForegroundColor Green
Write-Host "============================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "Resources Created:" -ForegroundColor White
Write-Host "  - Resource Group: $RESOURCE_GROUP ($LOCATION)"
Write-Host "  - Storage Account: $STORAGE_ACCOUNT_1"
Write-Host "  - Storage Account: $STORAGE_ACCOUNT_2"
Write-Host "  - Key Vault: $KEY_VAULT_NAME (RBAC enabled)"
Write-Host "  - Data Factory: $ADF_NAME"
Write-Host ""
Write-Host "Users: $($USERS.Count) users created and added to '$GROUP_NAME' group" -ForegroundColor White
Write-Host ""
Write-Host "Role Assignments:" -ForegroundColor White
Write-Host "  - DataEngineers -> Owner (subscription)"
Write-Host "  - DataEngineers -> Key Vault Secrets Officer ($KEY_VAULT_NAME)"
Write-Host "  - DataEngineers -> Storage Blob Data Owner ($STORAGE_ACCOUNT_1, $STORAGE_ACCOUNT_2)"
Write-Host "  - ADF ($ADF_NAME) -> Storage Blob Data Contributor ($STORAGE_ACCOUNT_1, $STORAGE_ACCOUNT_2)"
Write-Host "  - ADF ($ADF_NAME) -> Key Vault Secrets User ($KEY_VAULT_NAME)"
Write-Host ""
Write-Host "NOTE: Role assignments may take 5-10 minutes to propagate." -ForegroundColor Yellow
Write-Host "============================================" -ForegroundColor Cyan
