# ============================================================
# Azure Environment Export Script
# Scans your current Azure environment and generates a setup
# script that can recreate everything from scratch.
# ============================================================
# Prerequisites: Azure CLI installed and logged in (az login)
# Usage: .\export-azure-environment.ps1
# Output: setup-azure-environment-generated.ps1
# ============================================================

$OUTPUT_FILE = ".\setup-azure-environment-generated.ps1"

Write-Host "`n========== Exporting Azure Environment ==========" -ForegroundColor Cyan

# -----------------------------------------------------------
# Gather current subscription info
# -----------------------------------------------------------
$subInfo = az account show -o json | ConvertFrom-Json
$SUBSCRIPTION_ID = $subInfo.id
$TENANT_ID = $subInfo.tenantId
Write-Host "Subscription: $($subInfo.name) ($SUBSCRIPTION_ID)" -ForegroundColor Green

# -----------------------------------------------------------
# Gather all resource groups
# -----------------------------------------------------------
Write-Host "Scanning resource groups..." -ForegroundColor White
$resourceGroups = az group list --query "[].{name:name, location:location}" -o json | ConvertFrom-Json

# -----------------------------------------------------------
# Gather all resources
# -----------------------------------------------------------
Write-Host "Scanning resources..." -ForegroundColor White
$resources = az resource list --query "[].{name:name, type:type, resourceGroup:resourceGroup, location:location, id:id}" -o json | ConvertFrom-Json

# -----------------------------------------------------------
# Gather all users
# -----------------------------------------------------------
Write-Host "Scanning users..." -ForegroundColor White
$users = az ad user list --query "[].{displayName:displayName, userPrincipalName:userPrincipalName, id:id}" -o json | ConvertFrom-Json

# -----------------------------------------------------------
# Gather all groups and their members
# -----------------------------------------------------------
Write-Host "Scanning groups..." -ForegroundColor White
$groups = az ad group list --query "[].{displayName:displayName, id:id, mailNickname:mailNickname}" -o json | ConvertFrom-Json

$groupMembers = @{}
foreach ($group in $groups) {
    $members = az ad group member list --group $group.displayName --query "[].{displayName:displayName, userPrincipalName:userPrincipalName, id:id}" -o json | ConvertFrom-Json
    $groupMembers[$group.displayName] = $members
}

# -----------------------------------------------------------
# Gather all role assignments
# -----------------------------------------------------------
Write-Host "Scanning role assignments..." -ForegroundColor White
$roleAssignments = az role assignment list --all --query "[].{principalName:principalName, principalType:principalType, roleDefinitionName:roleDefinitionName, scope:scope, principalId:principalId}" -o json | ConvertFrom-Json

# -----------------------------------------------------------
# Gather Key Vault configurations
# -----------------------------------------------------------
Write-Host "Scanning Key Vault configurations..." -ForegroundColor White
$keyVaults = $resources | Where-Object { $_.type -eq "Microsoft.KeyVault/vaults" }
$kvConfigs = @{}
foreach ($kv in $keyVaults) {
    $kvDetail = az keyvault show --name $kv.name --query "{enableRbacAuthorization:properties.enableRbacAuthorization, enableSoftDelete:properties.enableSoftDelete}" -o json 2>$null | ConvertFrom-Json
    $kvConfigs[$kv.name] = $kvDetail
}

# -----------------------------------------------------------
# Gather Storage Account configurations
# -----------------------------------------------------------
Write-Host "Scanning Storage Account configurations..." -ForegroundColor White
$storageAccounts = $resources | Where-Object { $_.type -eq "Microsoft.Storage/storageAccounts" }
$saConfigs = @{}
foreach ($sa in $storageAccounts) {
    $saDetail = az storage account show --name $sa.name --resource-group $sa.resourceGroup --query "{sku:sku.name, kind:kind, accessTier:accessTier}" -o json 2>$null | ConvertFrom-Json
    $saConfigs[$sa.name] = $saDetail
}

# -----------------------------------------------------------
# Gather ADF Managed Identities
# -----------------------------------------------------------
Write-Host "Scanning Data Factory identities..." -ForegroundColor White
$adfResources = $resources | Where-Object { $_.type -eq "Microsoft.DataFactory/factories" }
$adfIdentities = @{}
foreach ($adf in $adfResources) {
    $adfId = az resource show --ids $adf.id --query "identity.principalId" -o tsv 2>$null
    $adfIdentities[$adf.name] = $adfId
}

# -----------------------------------------------------------
# Gather Databricks Workspaces
# -----------------------------------------------------------
Write-Host "Scanning Databricks workspaces..." -ForegroundColor White
$databricksWorkspaces = $resources | Where-Object { $_.type -eq "Microsoft.Databricks/workspaces" }
$databricksConnectors = $resources | Where-Object { $_.type -eq "Microsoft.Databricks/accessConnectors" }

# -----------------------------------------------------------
# Generate the setup script
# -----------------------------------------------------------
Write-Host "`nGenerating setup script: $OUTPUT_FILE" -ForegroundColor Cyan

$script = @"
# ============================================================
# Azure Environment Setup Script (Auto-Generated)
# Generated on: $(Get-Date -Format "yyyy-MM-dd HH:mm:ss")
# Source Subscription: $($subInfo.name) ($SUBSCRIPTION_ID)
# ============================================================
# Prerequisites: Azure CLI installed and logged in (az login)
# Usage: .\setup-azure-environment-generated.ps1
# ============================================================
# IMPORTANT: Update SUBSCRIPTION_ID before running!
# ============================================================

`$SUBSCRIPTION_ID = "<YOUR_NEW_SUBSCRIPTION_ID>"  # <-- UPDATE THIS

# -----------------------------------------------------------
# STEP 0: Set Subscription
# -----------------------------------------------------------
Write-Host "``n========== STEP 0: Setting Subscription ==========" -ForegroundColor Cyan
az account set --subscription `$SUBSCRIPTION_ID
Write-Host "Subscription set to: `$SUBSCRIPTION_ID" -ForegroundColor Green

"@

# --- Resource Groups ---
$script += @"

# -----------------------------------------------------------
# STEP 1: Create Resource Groups
# -----------------------------------------------------------
Write-Host "``n========== STEP 1: Creating Resource Groups ==========" -ForegroundColor Cyan

"@

foreach ($rg in $resourceGroups) {
    $script += "az group create --name `"$($rg.name)`" --location `"$($rg.location)`" -o none`n"
    $script += "Write-Host `"Created resource group: $($rg.name) ($($rg.location))`" -ForegroundColor Green`n`n"
}

# --- Users ---
$script += @"
# -----------------------------------------------------------
# STEP 2: Create Users
# -----------------------------------------------------------
Write-Host "``n========== STEP 2: Creating Users ==========" -ForegroundColor Cyan

"@

foreach ($user in $users) {
    # Skip external users (they need to be invited, not created)
    if ($user.userPrincipalName -match "#EXT#") {
        $script += "# External user (invite manually): $($user.displayName) ($($user.userPrincipalName))`n"
        continue
    }
    $script += @"
`$existing = az ad user show --id `"$($user.userPrincipalName)`" --query `"id`" -o tsv 2>`$null
if (-not `$existing) {
    az ad user create --display-name `"$($user.displayName)`" --user-principal-name `"$($user.userPrincipalName)`" --password `"P@ssw0rd!Change`" --force-change-password-next-sign-in false -o none
    Write-Host `"Created user: $($user.displayName)`" -ForegroundColor Green
} else {
    Write-Host `"User already exists: $($user.displayName)`" -ForegroundColor Yellow
}

"@
}

# --- Groups ---
$script += @"
# -----------------------------------------------------------
# STEP 3: Create Groups and Add Members
# -----------------------------------------------------------
Write-Host "``n========== STEP 3: Creating Groups ==========" -ForegroundColor Cyan

"@

foreach ($group in $groups) {
    $script += @"
`$groupId = az ad group show --group `"$($group.displayName)`" --query `"id`" -o tsv 2>`$null
if (-not `$groupId) {
    `$groupId = az ad group create --display-name `"$($group.displayName)`" --mail-nickname `"$($group.mailNickname)`" --query `"id`" -o tsv
    Write-Host `"Created group: $($group.displayName)`" -ForegroundColor Green
} else {
    Write-Host `"Group already exists: $($group.displayName)`" -ForegroundColor Yellow
}

"@

    # Add members
    $members = $groupMembers[$group.displayName]
    if ($members) {
        $script += "# Add members to $($group.displayName)`n"
        foreach ($member in $members) {
            if ($member.userPrincipalName) {
                $script += @"
`$memberId = az ad user show --id `"$($member.userPrincipalName)`" --query `"id`" -o tsv 2>`$null
if (`$memberId) {
    `$isMember = az ad group member check --group `"$($group.displayName)`" --member-id `$memberId --query `"value`" -o tsv 2>`$null
    if (`$isMember -ne `"true`") {
        az ad group member add --group `"$($group.displayName)`" --member-id `$memberId 2>`$null
        Write-Host `"  Added $($member.displayName) to $($group.displayName)`" -ForegroundColor Green
    }
}

"@
            }
        }
    }
}

# --- Resources ---
$script += @"
# -----------------------------------------------------------
# STEP 4: Create Resources
# -----------------------------------------------------------
Write-Host "``n========== STEP 4: Creating Resources ==========" -ForegroundColor Cyan

"@

# Storage Accounts
foreach ($sa in $storageAccounts) {
    $sku = if ($saConfigs[$sa.name]) { $saConfigs[$sa.name].sku } else { "Standard_LRS" }
    $script += "az storage account create --name `"$($sa.name)`" --resource-group `"$($sa.resourceGroup)`" --location `"$($sa.location)`" --sku `"$sku`" -o none`n"
    $script += "Write-Host `"Created storage account: $($sa.name)`" -ForegroundColor Green`n`n"
}

# Key Vaults
foreach ($kv in $keyVaults) {
    $rbacFlag = if ($kvConfigs[$kv.name] -and $kvConfigs[$kv.name].enableRbacAuthorization) { "--enable-rbac-authorization true" } else { "" }
    $script += "az keyvault create --name `"$($kv.name)`" --resource-group `"$($kv.resourceGroup)`" --location `"$($kv.location)`" $rbacFlag -o none`n"
    $script += "Write-Host `"Created Key Vault: $($kv.name)`" -ForegroundColor Green`n`n"
}

# Data Factories
foreach ($adf in $adfResources) {
    $script += "az resource create --resource-group `"$($adf.resourceGroup)`" --resource-type `"Microsoft.DataFactory/factories`" --name `"$($adf.name)`" --location `"$($adf.location)`" --properties '{`"publicNetworkAccess`":`"Enabled`"}' -o none`n"
    $script += "Write-Host `"Created Data Factory: $($adf.name)`" -ForegroundColor Green`n`n"
}

# Databricks Workspaces
foreach ($db in $databricksWorkspaces) {
    $script += "# Create Databricks Workspace: $($db.name)`n"
    $script += "az resource create --resource-group `"$($db.resourceGroup)`" --resource-type `"Microsoft.Databricks/workspaces`" --name `"$($db.name)`" --location `"$($db.location)`" --properties '{`"managedResourceGroupId`":`"/subscriptions/`$SUBSCRIPTION_ID/resourceGroups/$($db.resourceGroup)-managed`"}' -o none`n"
    $script += "Write-Host `"Created Databricks Workspace: $($db.name)`" -ForegroundColor Green`n`n"
}

# Databricks Access Connectors
foreach ($dac in $databricksConnectors) {
    $script += "# Create Databricks Access Connector: $($dac.name)`n"
    $script += "az resource create --resource-group `"$($dac.resourceGroup)`" --resource-type `"Microsoft.Databricks/accessConnectors`" --name `"$($dac.name)`" --location `"$($dac.location)`" --properties '{}' -o none`n"
    $script += "Write-Host `"Created Databricks Access Connector: $($dac.name)`" -ForegroundColor Green`n`n"
}

# Other resources
$knownTypes = @("Microsoft.Storage/storageAccounts", "Microsoft.KeyVault/vaults", "Microsoft.DataFactory/factories", "Microsoft.Databricks/workspaces", "Microsoft.Databricks/accessConnectors")
$otherResources = $resources | Where-Object { $_.type -notin $knownTypes }
foreach ($res in $otherResources) {
    $script += "# TODO: Manually create resource: $($res.name) (Type: $($res.type))`n"
}

# --- Role Assignments ---
$script += @"

# -----------------------------------------------------------
# STEP 5: Assign Roles
# -----------------------------------------------------------
Write-Host "``n========== STEP 5: Assigning Roles ==========" -ForegroundColor Cyan

"@

foreach ($ra in $roleAssignments) {
    # Replace the old subscription ID with variable
    $scope = $ra.scope -replace $SUBSCRIPTION_ID, '${SUBSCRIPTION_ID}'
    
    if ($ra.principalType -eq "Group") {
        $script += @"
`$groupId = az ad group show --group `"$($ra.principalName)`" --query `"id`" -o tsv 2>`$null
if (`$groupId) {
    az role assignment create --role `"$($ra.roleDefinitionName)`" --assignee-object-id `$groupId --assignee-principal-type Group --scope `"/subscriptions/`$SUBSCRIPTION_ID$($scope -replace '/subscriptions/\$\{SUBSCRIPTION_ID\}', '')`" -o none
    Write-Host `"Assigned '$($ra.roleDefinitionName)' to group '$($ra.principalName)'`" -ForegroundColor Green
}

"@
    } elseif ($ra.principalType -eq "ServicePrincipal") {
        # Find which resource this service principal belongs to
        $adfMatch = $adfIdentities.GetEnumerator() | Where-Object { $_.Value -eq $ra.principalId }
        if ($adfMatch) {
            $script += @"
`$adfPrincipalId = az resource show --ids `"/subscriptions/`$SUBSCRIPTION_ID/resourceGroups/$($adfMatch.Name.Split('/')[0])/providers/Microsoft.DataFactory/factories/$($adfMatch.Key)`" --query `"identity.principalId`" -o tsv 2>`$null
if (`$adfPrincipalId) {
    az role assignment create --role `"$($ra.roleDefinitionName)`" --assignee-object-id `$adfPrincipalId --assignee-principal-type ServicePrincipal --scope `"/subscriptions/`$SUBSCRIPTION_ID$($scope -replace '/subscriptions/\$\{SUBSCRIPTION_ID\}', '')`" -o none
    Write-Host `"Assigned '$($ra.roleDefinitionName)' to ADF '$($adfMatch.Key)' managed identity`" -ForegroundColor Green
}

"@
        }
    } elseif ($ra.principalType -eq "User") {
        $script += @"
`$userId = az ad user show --id `"$($ra.principalName)`" --query `"id`" -o tsv 2>`$null
if (`$userId) {
    az role assignment create --role `"$($ra.roleDefinitionName)`" --assignee-object-id `$userId --assignee-principal-type User --scope `"/subscriptions/`$SUBSCRIPTION_ID$($scope -replace '/subscriptions/\$\{SUBSCRIPTION_ID\}', '')`" -o none
    Write-Host `"Assigned '$($ra.roleDefinitionName)' to user '$($ra.principalName)'`" -ForegroundColor Green
}

"@
    }
}

# --- Summary ---
$script += @"

# -----------------------------------------------------------
# SUMMARY
# -----------------------------------------------------------
Write-Host "``n============================================" -ForegroundColor Cyan
Write-Host "  SETUP COMPLETE!" -ForegroundColor Green
Write-Host "============================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "Resources: $($resources.Count) resources created" -ForegroundColor White
Write-Host "Users: $($users.Count) users" -ForegroundColor White
Write-Host "Groups: $($groups.Count) groups" -ForegroundColor White
Write-Host "Role Assignments: $($roleAssignments.Count) assignments" -ForegroundColor White
Write-Host ""
Write-Host "NOTE: Role assignments may take 5-10 minutes to propagate." -ForegroundColor Yellow
Write-Host "============================================" -ForegroundColor Cyan
"@

# Write the script to file
$script | Out-File -FilePath $OUTPUT_FILE -Encoding UTF8
Write-Host "`n========== Export Complete ==========" -ForegroundColor Green
Write-Host "Generated script: $OUTPUT_FILE" -ForegroundColor Green
Write-Host "Resources: $($resources.Count)" -ForegroundColor White
Write-Host "Users: $($users.Count)" -ForegroundColor White
Write-Host "Groups: $($groups.Count)" -ForegroundColor White
Write-Host "Role Assignments: $($roleAssignments.Count)" -ForegroundColor White
Write-Host "`nTo use: Update SUBSCRIPTION_ID in '$OUTPUT_FILE' and run it." -ForegroundColor Yellow
