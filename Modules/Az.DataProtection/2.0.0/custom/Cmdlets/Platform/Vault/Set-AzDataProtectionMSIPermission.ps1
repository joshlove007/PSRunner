function Set-AzDataProtectionMSIPermission {
    [OutputType('System.Object')]
    [CmdletBinding(PositionalBinding=$false, SupportsShouldProcess, ConfirmImpact = 'High')]
    [Microsoft.Azure.PowerShell.Cmdlets.DataProtection.Description('Grants required permissions to the backup vault and other resources for configure backup and restore scenarios')]

    param(
        [Parameter(ParameterSetName="SetPermissionsForBackup", Mandatory, HelpMessage='Backup instance request object which will be used to configure backup')]
        [Microsoft.Azure.PowerShell.Cmdlets.DataProtection.Models.Api202301.IBackupInstanceResource]
        ${BackupInstance},
        
        [Parameter(ParameterSetName="SetPermissionsForBackup", Mandatory=$false, HelpMessage='ID of the keyvault')]
        [ValidatePattern("/subscriptions/([A-z0-9\-]+)/resourceGroups/(?<rg>.+)/(?<id>.+)")]
        [System.String]
        ${KeyVaultId},

        [Parameter(Mandatory, HelpMessage='Resource group of the backup vault')]
        [System.String]
        ${VaultResourceGroup},
        
        [Parameter(Mandatory, HelpMessage='Name of the backup vault')]
        [System.String]
        ${VaultName},

        [Parameter(Mandatory, HelpMessage='Scope at which the permissions need to be granted')]
        [System.String]
        [ValidateSet("Resource","ResourceGroup","Subscription")]
        ${PermissionsScope},

        [Parameter(ParameterSetName="SetPermissionsForRestore", Mandatory, HelpMessage='Restore request object which will be used for restore')]
        [Microsoft.Azure.PowerShell.Cmdlets.DataProtection.Models.Api202301.IAzureBackupRestoreRequest]
        ${RestoreRequest},

        [Parameter(ParameterSetName="SetPermissionsForRestore", Mandatory, HelpMessage='Sanpshot Resource Group')]
        [System.String]
        [ValidatePattern("/subscriptions/([A-z0-9\-]+)/resourceGroups/(?<rg>.+)")]
        ${SnapshotResourceGroupId}
    )

    process {
          CheckResourcesModuleDependency
          
          $OriginalWarningPreference = $WarningPreference
          $WarningPreference = 'SilentlyContinue'
          
          $MissingRolesInitially = $false

          if($PsCmdlet.ParameterSetName -eq "SetPermissionsForRestore"){
              
              $DatasourceId = $RestoreRequest.RestoreTargetInfo.DatasourceInfo.ResourceId  
              $DatasourceType =  GetClientDatasourceType -ServiceDatasourceType $RestoreRequest.RestoreTargetInfo.DatasourceInfo.Type 
              $manifest = LoadManifest -DatasourceType $DatasourceType.ToString()
              
              $ResourceArray = $DataSourceId.Split("/")
              $ResourceRG = GetResourceGroupIdFromArmId -Id $DataSourceId
              $SubscriptionName = GetSubscriptionNameFromArmId -Id $DataSourceId
              $subscriptionId = $ResourceArray[2]

              $vault = Az.DataProtection\Get-AzDataProtectionBackupVault -VaultName $VaultName -ResourceGroupName $VaultResourceGroup -SubscriptionId $ResourceArray[2]

              if($DatasourceType -ne "AzureKubernetesService"){
                  $err = "Set permissions for restore is currently not supported for given DataSourceType"
                  throw $err
              }
                            
              if($SnapshotResourceGroupId -eq ""){
                  $warning = "SnapshotResourceGroupId parameter is required to assign permissions over snapshot resource group, skipping"
                  Write-Warning $warning
              }
              else{
                  foreach($Permission in $manifest.dataSourceOverSnapshotRGPermissions)
                  {
                      if($DatasourceType -eq "AzureKubernetesService"){                  
                          CheckAksModuleDependency
                                    
                          $aksCluster = Get-AzAksCluster -Id $RestoreRequest.RestoreTargetInfo.DataSourceInfo.ResourceId -SubscriptionId $subscriptionId
                          $dataSourceMSI = $aksCluster.Identity.PrincipalId
                          $dataSourceMSIRoles = Az.Resources\Get-AzRoleAssignment -ObjectId $dataSourceMSI
                      }

                      # CSR: $SubscriptionName might be different when we add cross subscription restore
                      $CheckPermission = $dataSourceMSIRoles | Where-Object { ($_.Scope -eq $SnapshotResourceGroupId -or $_.Scope -eq $SubscriptionName)  -and $_.RoleDefinitionName -eq $Permission}

                      if($CheckPermission -ne $null)
                      {
                          Write-Host "Required permission $($Permission) is already assigned to target resource with Id $($RestoreRequest.RestoreTargetInfo.DataSourceInfo.ResourceId) over snapshot resource group with Id $($SnapshotResourceGroupId)"
                      }
                      else
                      {
                          # can add snapshot resource group name in allow statement
                          if ($PSCmdlet.ShouldProcess("$($RestoreRequest.RestoreTargetInfo.DataSourceInfo.ResourceId)","Allow $($Permission) permission over snapshot resource group"))
                          {
                              $MissingRolesInitially = $true
                              
                              AssignMissingRoles -ObjectId $dataSourceMSI -Permission $Permission -PermissionsScope $PermissionsScope -Resource $SnapshotResourceGroupId -ResourceGroup $SnapshotResourceGroupId -Subscription $SubscriptionName
  
                              Write-Host "Assigned $($Permission) permission to target resource with Id $($RestoreRequest.RestoreTargetInfo.DataSourceInfo.ResourceId) over snapshot resource group with Id $($SnapshotResourceGroupId)"
                          }
                      }
                  }

                  foreach($Permission in $manifest.snapshotRGPermissions)
                  {
                      $AllRoles = Az.Resources\Get-AzRoleAssignment -ObjectId $vault.Identity.PrincipalId

                      # CSR: $SubscriptionName might be different when we add cross subscription restore
                      $CheckPermission = $AllRoles | Where-Object { ($_.Scope -eq $SnapshotResourceGroupId -or $_.Scope -eq $SubscriptionName) -and $_.RoleDefinitionName -eq $Permission}

                      if($CheckPermission -ne $null)
                      {
                          Write-Host "Required permission $($Permission) is already assigned to backup vault over snapshot resource group with Id $($SnapshotResourceGroupId)"
                      }

                      else
                      {
                          $MissingRolesInitially = $true

                          AssignMissingRoles -ObjectId $vault.Identity.PrincipalId -Permission $Permission -PermissionsScope $PermissionsScope -Resource $SnapshotResourceGroupId -ResourceGroup $SnapshotResourceGroupId -Subscription $SubscriptionName
  
                          Write-Host "Assigned $($Permission) permission to the backup vault over snapshot resource group with Id $($SnapshotResourceGroupId)"
                      }
                  }
              }

              foreach($Permission in $manifest.datasourcePermissions)
              {
                  # set context to the subscription where ObjectId is present
                  $AllRoles = Az.Resources\Get-AzRoleAssignment -ObjectId $vault.Identity.PrincipalId

                  $CheckPermission = $AllRoles | Where-Object { ($_.Scope -eq $DataSourceId -or $_.Scope -eq $ResourceRG -or  $_.Scope -eq $SubscriptionName) -and $_.RoleDefinitionName -eq $Permission}

                  if($CheckPermission -ne $null)
                  {   
                      Write-Host "Required permission $($Permission) is already assigned to backup vault over DataSource with Id $($DataSourceId)"
                  }

                  else
                  {
                      $MissingRolesInitially = $true
                   
                      AssignMissingRoles -ObjectId $vault.Identity.PrincipalId -Permission $Permission -PermissionsScope $PermissionsScope -Resource $DataSourceId -ResourceGroup $ResourceRG -Subscription $SubscriptionName

                      Write-Host "Assigned $($Permission) permission to the backup vault over DataSource with Id $($DataSourceId)"
                  }
              }
          }

          elseif($PsCmdlet.ParameterSetName -eq "SetPermissionsForBackup"){
              $DatasourceId = $BackupInstance.Property.DataSourceInfo.ResourceId
              $DatasourceType =  GetClientDatasourceType -ServiceDatasourceType $BackupInstance.Property.DataSourceInfo.Type 
              $manifest = LoadManifest -DatasourceType $DatasourceType.ToString()

              $ResourceArray = $DataSourceId.Split("/")
              $ResourceRG = GetResourceGroupIdFromArmId -Id $DataSourceId
              $SubscriptionName = GetSubscriptionNameFromArmId -Id $DataSourceId
              $subscriptionId = $ResourceArray[2]

              $vault = Az.DataProtection\Get-AzDataProtectionBackupVault -VaultName $VaultName -ResourceGroupName $VaultResourceGroup -SubscriptionId $ResourceArray[2]
          
              $AllRoles = Az.Resources\Get-AzRoleAssignment -ObjectId $vault.Identity.PrincipalId

              # If more DataSourceTypes support this then we can make it manifest driven
              if($DatasourceType -eq "AzureDatabaseForPostgreSQL")
              {
                  CheckPostgreSqlModuleDependency
                  CheckKeyVaultModuleDependency

                  if($KeyVaultId -eq "" -or $KeyVaultId -eq $null)
                  {
                      Write-Error "KeyVaultId not provided. Please provide the KeyVaultId parameter to successfully assign the permissions on the keyvault"
                  }

                  $KeyvaultName = GetResourceNameFromArmId -Id $KeyVaultId
                  $KeyvaultRGName = GetResourceGroupNameFromArmId -Id $KeyVaultId
                  $ServerName = GetResourceNameFromArmId -Id $DataSourceId
                  $ServerRG = GetResourceGroupNameFromArmId -Id $DataSourceId
                
                  $KeyvaultArray = $KeyVaultId.Split("/")
                  $KeyvaultRG = GetResourceGroupIdFromArmId -Id $KeyVaultId
                  $KeyvaultSubscriptionName = GetSubscriptionNameFromArmId -Id $KeyVaultId

                  if ($PSCmdlet.ShouldProcess("KeyVault: $($KeyvaultName) and PostgreSQLServer: $($ServerName)","
                              1.'Allow All Azure services' under network connectivity in the Postgres Server
                              2.'Allow Trusted Azure services' under network connectivity in the Key vault")) 
                  {                    
                      Update-AzPostgreSqlServer -ResourceGroupName $ServerRG -ServerName $ServerName -PublicNetworkAccess Enabled| Out-Null
                      New-AzPostgreSqlFirewallRule -Name AllowAllAzureIps -ResourceGroupName $ServerRG -ServerName $ServerName -EndIPAddress 0.0.0.0 -StartIPAddress 0.0.0.0 | Out-Null
                     
                      $SecretsList = ""
                      try{$SecretsList =  Get-AzKeyVaultSecret -VaultName $KeyvaultName}
                      catch{
                          $err = $_
                          throw $err
                      }
              
                      $SecretValid = $false
                      $GivenSecretUri = $BackupInstance.Property.DatasourceAuthCredentials.SecretStoreResource.Uri
              
                      foreach($Secret in $SecretsList)
                      {
                          $SecretArray = $Secret.Id.Split("/")
                          $SecretArray[2] = $SecretArray[2] -replace "....$"
                          $SecretUri = $SecretArray[0] + "/" + $SecretArray[1] + "/"+  $SecretArray[2] + "/" +  $SecretArray[3] + "/" + $SecretArray[4] 
                              
                          if($Secret.Enabled -eq "true" -and $SecretUri -eq $GivenSecretUri)
                          {
                              $SecretValid = $true
                          }
                      }

                      if($SecretValid -eq $false)
                      {
                          $err = "The Secret URI provided in the backup instance is not associated with the keyvault Id provided. Please provide a valid combination of Secret URI and keyvault Id"
                          throw $err
                      }

                      if($KeyVault.PublicNetworkAccess -eq "Disabled")
                      {
                          $err = "Keyvault needs to have public network access enabled"
                          throw $err
                      }
            
                      try{$KeyVault = Get-AzKeyVault -VaultName $KeyvaultName}
                      catch{
                          $err = $_
                          throw $err
                      }    
            
                      try{Update-AzKeyVaultNetworkRuleSet -VaultName $KeyvaultName -Bypass AzureServices -Confirm:$False}
                      catch{
                          $err = $_
                          throw $err
                      }
                  }
              }

              foreach($Permission in $manifest.keyVaultPermissions)
              {
                  if($KeyVault.EnableRbacAuthorization -eq $false )
                  {
                     try{                    
                          $KeyVault = Get-AzKeyVault -VaultName $KeyvaultName 
                          $KeyVaultAccessPolicies = $KeyVault.AccessPolicies

                          $KeyVaultAccessPolicy =  $KeyVaultAccessPolicies | Where-Object {$_.ObjectID -eq $vault.Identity.PrincipalId}

                          if($KeyVaultAccessPolicy -eq $null)
                          {                         
                            Set-AzKeyVaultAccessPolicy -VaultName $KeyvaultName -ObjectId $vault.Identity.PrincipalId -PermissionsToSecrets Get,List -Confirm:$False 
                            break
                          }

                          $KeyvaultAccessPolicyPermissions = $KeyVaultAccessPolicy."PermissionsToSecrets"
                          $KeyvaultAccessPolicyPermissions+="Get"
                          $KeyvaultAccessPolicyPermissions+="List"
                          [String[]]$FinalKeyvaultAccessPolicyPermissions = $KeyvaultAccessPolicyPermissions
                          $FinalKeyvaultAccessPolicyPermissions = $FinalKeyvaultAccessPolicyPermissions | select -uniq                      
                      
                          Set-AzKeyVaultAccessPolicy -VaultName $KeyvaultName -ObjectId $vault.Identity.PrincipalId -PermissionsToSecrets $FinalKeyvaultAccessPolicyPermissions -Confirm:$False 
                     }
                     catch{
                         $err = $_
                         throw $err
                     }
                  }

                  else
                  {
                      $CheckPermission = $AllRoles | Where-Object { ($_.Scope -eq $KeyVaultId -or $_.Scope -eq $KeyvaultRG -or  $_.Scope -eq $KeyvaultSubscription) -and $_.RoleDefinitionName -eq $Permission}

                      if($CheckPermission -ne $null)
                      {
                          Write-Host "Required permission $($Permission) is already assigned to backup vault over KeyVault with Id $($KeyVaultId)"
                      }

                      else
                      {
                          $MissingRolesInitially = $true
                                                    
                          AssignMissingRoles -ObjectId $vault.Identity.PrincipalId -Permission $Permission -PermissionsScope $PermissionsScope -Resource $KeyVaultId -ResourceGroup $KeyvaultRG -Subscription $KeyvaultSubscriptionName

                          Write-Host "Assigned $($Permission) permission to the backup vault over key vault with Id $($KeyVaultId)"
                      }
                  }
              }
              
              foreach($Permission in $manifest.dataSourceOverSnapshotRGPermissions)
              {
                  $SnapshotResourceGroupId = $BackupInstance.Property.PolicyInfo.PolicyParameter.DataStoreParametersList[0].ResourceGroupId              
              
                  if($DatasourceType -eq "AzureKubernetesService"){                  
                      CheckAksModuleDependency
                                    
                      $aksCluster = Get-AzAksCluster -Id $BackupInstance.Property.DataSourceInfo.ResourceId -SubscriptionId $subscriptionId
                      $dataSourceMSI = $aksCluster.Identity.PrincipalId
                      $dataSourceMSIRoles = Az.Resources\Get-AzRoleAssignment -ObjectId $dataSourceMSI
                  }

                  # CSR: $SubscriptionName might be different when we add cross subscription restore
                  $CheckPermission = $dataSourceMSIRoles | Where-Object { ($_.Scope -eq $SnapshotResourceGroupId -or $_.Scope -eq $SubscriptionName) -and $_.RoleDefinitionName -eq $Permission}

                  if($CheckPermission -ne $null)
                  {
                      Write-Host "Required permission $($Permission) is already assigned to DataSource with Id $($BackupInstance.Property.DataSourceInfo.ResourceId) over snapshot resource group with Id $($SnapshotResourceGroupId)"
                  }

                  else
                  {   
                      # can add snapshot resource group name in allow statement
                      if ($PSCmdlet.ShouldProcess("$($BackupInstance.Property.DataSourceInfo.ResourceId)","Allow $($Permission) permission over snapshot resource group"))
                      {
                          $MissingRolesInitially = $true
                          
                          AssignMissingRoles -ObjectId $dataSourceMSI -Permission $Permission -PermissionsScope $PermissionsScope -Resource $SnapshotResourceGroupId -ResourceGroup $SnapshotResourceGroupId -Subscription $SubscriptionName
  
                          Write-Host "Assigned $($Permission) permission to DataSource with Id $($BackupInstance.Property.DataSourceInfo.ResourceId) over snapshot resource group with Id $($SnapshotResourceGroupId)"
                      }                  
                  }
              }

              foreach($Permission in $manifest.snapshotRGPermissions)
              {
                  $SnapshotResourceGroupId = $BackupInstance.Property.PolicyInfo.PolicyParameter.DataStoreParametersList[0].ResourceGroupId
              
                  # CSR: $SubscriptionName might be different when we add cross subscription restore
                  $AllRoles = Az.Resources\Get-AzRoleAssignment -ObjectId $vault.Identity.PrincipalId
                  $CheckPermission = $AllRoles | Where-Object { ($_.Scope -eq $SnapshotResourceGroupId -or $_.Scope -eq $SubscriptionName)  -and $_.RoleDefinitionName -eq $Permission}

                  if($CheckPermission -ne $null)
                  {
                      Write-Host "Required permission $($Permission) is already assigned to backup vault over snapshot resource group with Id $($SnapshotResourceGroupId)"
                  }

                  else
                  {
                      $MissingRolesInitially = $true

                      AssignMissingRoles -ObjectId $vault.Identity.PrincipalId -Permission $Permission -PermissionsScope $PermissionsScope -Resource $SnapshotResourceGroupId -ResourceGroup $SnapshotResourceGroupId -Subscription $SubscriptionName
  
                      Write-Host "Assigned $($Permission) permission to the backup vault over snapshot resource group with Id $($SnapshotResourceGroupId)"
                  }
              }

              foreach($Permission in $manifest.datasourcePermissions)
              {
                  $AllRoles = Az.Resources\Get-AzRoleAssignment -ObjectId $vault.Identity.PrincipalId
                  $CheckPermission = $AllRoles | Where-Object { ($_.Scope -eq $DataSourceId -or $_.Scope -eq $ResourceRG -or  $_.Scope -eq $SubscriptionName) -and $_.RoleDefinitionName -eq $Permission}
              
                  if($CheckPermission -ne $null)
                  {
                      Write-Host "Required permission $($Permission) is already assigned to backup vault over DataSource with Id $($DataSourceId)"
                  }

                  else
                  {
                      $MissingRolesInitially = $true
                                            
                      AssignMissingRoles -ObjectId $vault.Identity.PrincipalId -Permission $Permission -PermissionsScope $PermissionsScope -Resource $DataSourceId -ResourceGroup $ResourceRG -Subscription $SubscriptionName

                      Write-Host "Assigned $($Permission) permission to the backup vault over DataSource with Id $($DataSourceId)"
                  }
              }
          }

          if($MissingRolesInitially -eq $true)
          {
              Write-Host "Waiting for 60 seconds for roles to propagate"
              Start-Sleep -Seconds 60
          }
          
          $WarningPreference = $OriginalWarningPreference          
    }
}
# SIG # Begin signature block
# MIInkwYJKoZIhvcNAQcCoIInhDCCJ4ACAQExDzANBglghkgBZQMEAgEFADB5Bgor
# BgEEAYI3AgEEoGswaTA0BgorBgEEAYI3AgEeMCYCAwEAAAQQH8w7YFlLCE63JNLG
# KX7zUQIBAAIBAAIBAAIBAAIBADAxMA0GCWCGSAFlAwQCAQUABCAoq1GvRepxM/7d
# R77aXdAFqEy5o0orMh3XW2GqZIdV7qCCDXYwggX0MIID3KADAgECAhMzAAADTrU8
# esGEb+srAAAAAANOMA0GCSqGSIb3DQEBCwUAMH4xCzAJBgNVBAYTAlVTMRMwEQYD
# VQQIEwpXYXNoaW5ndG9uMRAwDgYDVQQHEwdSZWRtb25kMR4wHAYDVQQKExVNaWNy
# b3NvZnQgQ29ycG9yYXRpb24xKDAmBgNVBAMTH01pY3Jvc29mdCBDb2RlIFNpZ25p
# bmcgUENBIDIwMTEwHhcNMjMwMzE2MTg0MzI5WhcNMjQwMzE0MTg0MzI5WjB0MQsw
# CQYDVQQGEwJVUzETMBEGA1UECBMKV2FzaGluZ3RvbjEQMA4GA1UEBxMHUmVkbW9u
# ZDEeMBwGA1UEChMVTWljcm9zb2Z0IENvcnBvcmF0aW9uMR4wHAYDVQQDExVNaWNy
# b3NvZnQgQ29ycG9yYXRpb24wggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIB
# AQDdCKiNI6IBFWuvJUmf6WdOJqZmIwYs5G7AJD5UbcL6tsC+EBPDbr36pFGo1bsU
# p53nRyFYnncoMg8FK0d8jLlw0lgexDDr7gicf2zOBFWqfv/nSLwzJFNP5W03DF/1
# 1oZ12rSFqGlm+O46cRjTDFBpMRCZZGddZlRBjivby0eI1VgTD1TvAdfBYQe82fhm
# WQkYR/lWmAK+vW/1+bO7jHaxXTNCxLIBW07F8PBjUcwFxxyfbe2mHB4h1L4U0Ofa
# +HX/aREQ7SqYZz59sXM2ySOfvYyIjnqSO80NGBaz5DvzIG88J0+BNhOu2jl6Dfcq
# jYQs1H/PMSQIK6E7lXDXSpXzAgMBAAGjggFzMIIBbzAfBgNVHSUEGDAWBgorBgEE
# AYI3TAgBBggrBgEFBQcDAzAdBgNVHQ4EFgQUnMc7Zn/ukKBsBiWkwdNfsN5pdwAw
# RQYDVR0RBD4wPKQ6MDgxHjAcBgNVBAsTFU1pY3Jvc29mdCBDb3Jwb3JhdGlvbjEW
# MBQGA1UEBRMNMjMwMDEyKzUwMDUxNjAfBgNVHSMEGDAWgBRIbmTlUAXTgqoXNzci
# tW2oynUClTBUBgNVHR8ETTBLMEmgR6BFhkNodHRwOi8vd3d3Lm1pY3Jvc29mdC5j
# b20vcGtpb3BzL2NybC9NaWNDb2RTaWdQQ0EyMDExXzIwMTEtMDctMDguY3JsMGEG
# CCsGAQUFBwEBBFUwUzBRBggrBgEFBQcwAoZFaHR0cDovL3d3dy5taWNyb3NvZnQu
# Y29tL3BraW9wcy9jZXJ0cy9NaWNDb2RTaWdQQ0EyMDExXzIwMTEtMDctMDguY3J0
# MAwGA1UdEwEB/wQCMAAwDQYJKoZIhvcNAQELBQADggIBAD21v9pHoLdBSNlFAjmk
# mx4XxOZAPsVxxXbDyQv1+kGDe9XpgBnT1lXnx7JDpFMKBwAyIwdInmvhK9pGBa31
# TyeL3p7R2s0L8SABPPRJHAEk4NHpBXxHjm4TKjezAbSqqbgsy10Y7KApy+9UrKa2
# kGmsuASsk95PVm5vem7OmTs42vm0BJUU+JPQLg8Y/sdj3TtSfLYYZAaJwTAIgi7d
# hzn5hatLo7Dhz+4T+MrFd+6LUa2U3zr97QwzDthx+RP9/RZnur4inzSQsG5DCVIM
# pA1l2NWEA3KAca0tI2l6hQNYsaKL1kefdfHCrPxEry8onJjyGGv9YKoLv6AOO7Oh
# JEmbQlz/xksYG2N/JSOJ+QqYpGTEuYFYVWain7He6jgb41JbpOGKDdE/b+V2q/gX
# UgFe2gdwTpCDsvh8SMRoq1/BNXcr7iTAU38Vgr83iVtPYmFhZOVM0ULp/kKTVoir
# IpP2KCxT4OekOctt8grYnhJ16QMjmMv5o53hjNFXOxigkQWYzUO+6w50g0FAeFa8
# 5ugCCB6lXEk21FFB1FdIHpjSQf+LP/W2OV/HfhC3uTPgKbRtXo83TZYEudooyZ/A
# Vu08sibZ3MkGOJORLERNwKm2G7oqdOv4Qj8Z0JrGgMzj46NFKAxkLSpE5oHQYP1H
# tPx1lPfD7iNSbJsP6LiUHXH1MIIHejCCBWKgAwIBAgIKYQ6Q0gAAAAAAAzANBgkq
# hkiG9w0BAQsFADCBiDELMAkGA1UEBhMCVVMxEzARBgNVBAgTCldhc2hpbmd0b24x
# EDAOBgNVBAcTB1JlZG1vbmQxHjAcBgNVBAoTFU1pY3Jvc29mdCBDb3Jwb3JhdGlv
# bjEyMDAGA1UEAxMpTWljcm9zb2Z0IFJvb3QgQ2VydGlmaWNhdGUgQXV0aG9yaXR5
# IDIwMTEwHhcNMTEwNzA4MjA1OTA5WhcNMjYwNzA4MjEwOTA5WjB+MQswCQYDVQQG
# EwJVUzETMBEGA1UECBMKV2FzaGluZ3RvbjEQMA4GA1UEBxMHUmVkbW9uZDEeMBwG
# A1UEChMVTWljcm9zb2Z0IENvcnBvcmF0aW9uMSgwJgYDVQQDEx9NaWNyb3NvZnQg
# Q29kZSBTaWduaW5nIFBDQSAyMDExMIICIjANBgkqhkiG9w0BAQEFAAOCAg8AMIIC
# CgKCAgEAq/D6chAcLq3YbqqCEE00uvK2WCGfQhsqa+laUKq4BjgaBEm6f8MMHt03
# a8YS2AvwOMKZBrDIOdUBFDFC04kNeWSHfpRgJGyvnkmc6Whe0t+bU7IKLMOv2akr
# rnoJr9eWWcpgGgXpZnboMlImEi/nqwhQz7NEt13YxC4Ddato88tt8zpcoRb0Rrrg
# OGSsbmQ1eKagYw8t00CT+OPeBw3VXHmlSSnnDb6gE3e+lD3v++MrWhAfTVYoonpy
# 4BI6t0le2O3tQ5GD2Xuye4Yb2T6xjF3oiU+EGvKhL1nkkDstrjNYxbc+/jLTswM9
# sbKvkjh+0p2ALPVOVpEhNSXDOW5kf1O6nA+tGSOEy/S6A4aN91/w0FK/jJSHvMAh
# dCVfGCi2zCcoOCWYOUo2z3yxkq4cI6epZuxhH2rhKEmdX4jiJV3TIUs+UsS1Vz8k
# A/DRelsv1SPjcF0PUUZ3s/gA4bysAoJf28AVs70b1FVL5zmhD+kjSbwYuER8ReTB
# w3J64HLnJN+/RpnF78IcV9uDjexNSTCnq47f7Fufr/zdsGbiwZeBe+3W7UvnSSmn
# Eyimp31ngOaKYnhfsi+E11ecXL93KCjx7W3DKI8sj0A3T8HhhUSJxAlMxdSlQy90
# lfdu+HggWCwTXWCVmj5PM4TasIgX3p5O9JawvEagbJjS4NaIjAsCAwEAAaOCAe0w
# ggHpMBAGCSsGAQQBgjcVAQQDAgEAMB0GA1UdDgQWBBRIbmTlUAXTgqoXNzcitW2o
# ynUClTAZBgkrBgEEAYI3FAIEDB4KAFMAdQBiAEMAQTALBgNVHQ8EBAMCAYYwDwYD
# VR0TAQH/BAUwAwEB/zAfBgNVHSMEGDAWgBRyLToCMZBDuRQFTuHqp8cx0SOJNDBa
# BgNVHR8EUzBRME+gTaBLhklodHRwOi8vY3JsLm1pY3Jvc29mdC5jb20vcGtpL2Ny
# bC9wcm9kdWN0cy9NaWNSb29DZXJBdXQyMDExXzIwMTFfMDNfMjIuY3JsMF4GCCsG
# AQUFBwEBBFIwUDBOBggrBgEFBQcwAoZCaHR0cDovL3d3dy5taWNyb3NvZnQuY29t
# L3BraS9jZXJ0cy9NaWNSb29DZXJBdXQyMDExXzIwMTFfMDNfMjIuY3J0MIGfBgNV
# HSAEgZcwgZQwgZEGCSsGAQQBgjcuAzCBgzA/BggrBgEFBQcCARYzaHR0cDovL3d3
# dy5taWNyb3NvZnQuY29tL3BraW9wcy9kb2NzL3ByaW1hcnljcHMuaHRtMEAGCCsG
# AQUFBwICMDQeMiAdAEwAZQBnAGEAbABfAHAAbwBsAGkAYwB5AF8AcwB0AGEAdABl
# AG0AZQBuAHQALiAdMA0GCSqGSIb3DQEBCwUAA4ICAQBn8oalmOBUeRou09h0ZyKb
# C5YR4WOSmUKWfdJ5DJDBZV8uLD74w3LRbYP+vj/oCso7v0epo/Np22O/IjWll11l
# hJB9i0ZQVdgMknzSGksc8zxCi1LQsP1r4z4HLimb5j0bpdS1HXeUOeLpZMlEPXh6
# I/MTfaaQdION9MsmAkYqwooQu6SpBQyb7Wj6aC6VoCo/KmtYSWMfCWluWpiW5IP0
# wI/zRive/DvQvTXvbiWu5a8n7dDd8w6vmSiXmE0OPQvyCInWH8MyGOLwxS3OW560
# STkKxgrCxq2u5bLZ2xWIUUVYODJxJxp/sfQn+N4sOiBpmLJZiWhub6e3dMNABQam
# ASooPoI/E01mC8CzTfXhj38cbxV9Rad25UAqZaPDXVJihsMdYzaXht/a8/jyFqGa
# J+HNpZfQ7l1jQeNbB5yHPgZ3BtEGsXUfFL5hYbXw3MYbBL7fQccOKO7eZS/sl/ah
# XJbYANahRr1Z85elCUtIEJmAH9AAKcWxm6U/RXceNcbSoqKfenoi+kiVH6v7RyOA
# 9Z74v2u3S5fi63V4GuzqN5l5GEv/1rMjaHXmr/r8i+sLgOppO6/8MO0ETI7f33Vt
# Y5E90Z1WTk+/gFcioXgRMiF670EKsT/7qMykXcGhiJtXcVZOSEXAQsmbdlsKgEhr
# /Xmfwb1tbWrJUnMTDXpQzTGCGXMwghlvAgEBMIGVMH4xCzAJBgNVBAYTAlVTMRMw
# EQYDVQQIEwpXYXNoaW5ndG9uMRAwDgYDVQQHEwdSZWRtb25kMR4wHAYDVQQKExVN
# aWNyb3NvZnQgQ29ycG9yYXRpb24xKDAmBgNVBAMTH01pY3Jvc29mdCBDb2RlIFNp
# Z25pbmcgUENBIDIwMTECEzMAAANOtTx6wYRv6ysAAAAAA04wDQYJYIZIAWUDBAIB
# BQCgga4wGQYJKoZIhvcNAQkDMQwGCisGAQQBgjcCAQQwHAYKKwYBBAGCNwIBCzEO
# MAwGCisGAQQBgjcCARUwLwYJKoZIhvcNAQkEMSIEINIIlzFh8ISv2sOmbkPlo50j
# DDwNMK4/uLeVFSMxtsWjMEIGCisGAQQBgjcCAQwxNDAyoBSAEgBNAGkAYwByAG8A
# cwBvAGYAdKEagBhodHRwOi8vd3d3Lm1pY3Jvc29mdC5jb20wDQYJKoZIhvcNAQEB
# BQAEggEAB10qTQRgyuRZoCtx8XFu7M9RCpHifV1n8n++ukNxKC76MFCOND2bS6UH
# VuPeyRVPcUrSBJ7atGINqZlunQdyQX76NXGZpztjFksrJjiHPQVaOECIMeOSTbPu
# 55LuXB17BbvT74KtL1mEPBsXeTaCTiVT+hmtxwfMORkAqEZSW6qU02QBCAxhM2iM
# SCfwy6BJqKNNLDk/0svY+qQC3Z46ujjee3cTRmsLFNr+merTwlRb8FAuHEvUgg4K
# F67O8esOJQFItMJqAcxegcfI4GOMiuBpohmdypD/5nYZYek53Qfd/1jmD23gXn8b
# cXBDZTvM2CKyE+0T3kFauzJQIvaa66GCFv0wghb5BgorBgEEAYI3AwMBMYIW6TCC
# FuUGCSqGSIb3DQEHAqCCFtYwghbSAgEDMQ8wDQYJYIZIAWUDBAIBBQAwggFRBgsq
# hkiG9w0BCRABBKCCAUAEggE8MIIBOAIBAQYKKwYBBAGEWQoDATAxMA0GCWCGSAFl
# AwQCAQUABCCzeI9VU385ZnSzBnAb4kcQ6k7YvMfVndK3SramnLcIJgIGZF0emZwP
# GBMyMDIzMDUyMjExNDU0Mi42NDZaMASAAgH0oIHQpIHNMIHKMQswCQYDVQQGEwJV
# UzETMBEGA1UECBMKV2FzaGluZ3RvbjEQMA4GA1UEBxMHUmVkbW9uZDEeMBwGA1UE
# ChMVTWljcm9zb2Z0IENvcnBvcmF0aW9uMSUwIwYDVQQLExxNaWNyb3NvZnQgQW1l
# cmljYSBPcGVyYXRpb25zMSYwJAYDVQQLEx1UaGFsZXMgVFNTIEVTTjpBRTJDLUUz
# MkItMUFGQzElMCMGA1UEAxMcTWljcm9zb2Z0IFRpbWUtU3RhbXAgU2VydmljZaCC
# EVQwggcMMIIE9KADAgECAhMzAAABv99uuQQVUihYAAEAAAG/MA0GCSqGSIb3DQEB
# CwUAMHwxCzAJBgNVBAYTAlVTMRMwEQYDVQQIEwpXYXNoaW5ndG9uMRAwDgYDVQQH
# EwdSZWRtb25kMR4wHAYDVQQKExVNaWNyb3NvZnQgQ29ycG9yYXRpb24xJjAkBgNV
# BAMTHU1pY3Jvc29mdCBUaW1lLVN0YW1wIFBDQSAyMDEwMB4XDTIyMTEwNDE5MDEy
# NFoXDTI0MDIwMjE5MDEyNFowgcoxCzAJBgNVBAYTAlVTMRMwEQYDVQQIEwpXYXNo
# aW5ndG9uMRAwDgYDVQQHEwdSZWRtb25kMR4wHAYDVQQKExVNaWNyb3NvZnQgQ29y
# cG9yYXRpb24xJTAjBgNVBAsTHE1pY3Jvc29mdCBBbWVyaWNhIE9wZXJhdGlvbnMx
# JjAkBgNVBAsTHVRoYWxlcyBUU1MgRVNOOkFFMkMtRTMyQi0xQUZDMSUwIwYDVQQD
# ExxNaWNyb3NvZnQgVGltZS1TdGFtcCBTZXJ2aWNlMIICIjANBgkqhkiG9w0BAQEF
# AAOCAg8AMIICCgKCAgEAuExh0n1UxKMzBvkPHer47nryD4UK2GVy1X6bOVC+hLVh
# DlsIWQ1uX/9a8IRI3zXo/y1oTDuj+rJHyX4OZQn42E0iu7x6swPvM34zIOSPn8lg
# nWzGEAsRtz9zBrLW9+4w/YhWlXI8hvc7ovqupuL3TXte8BbmNOUDSL+Ou2bBfObG
# zsH3yY/BELvqwO13KZ9Z1OxKacnqq1u9E9Rhai90STog22lR2MVRSx55FHi/emnZ
# A/IKvsAtEH2K6JmgOyQ7/mDQrWNEA5roUjhQqLQw1/3wz/CIvc9+FPxX2dxR0nvv
# Ye5VLqv8Q99cOkO6z6V4stGDyFDuO8CwtiSvCC3QrOOugAl33aPD9YZswywWRk+Y
# GyLI+Fw+kCCUY6h1qOjTj5glz0esmds3ue45WaI2hI9usForM8gy//5tDZXj0KKU
# 1BxA04xpfEy91RZUbc6pdAvEkpYrN2jlpXhMvTD7pgdYyxkVSaWZv7kWp5y9NjWP
# /CTDGXTC6DWiGcXwPQO66QdVNWxuiGdpfPaEUnWXcKnDVua1khBAxO4m9wg/1qM6
# f7HwXf/pHifMej+qB7SUZOiJScX+1HmffmZRAFiJXS0qUDk0ZAZW3oX2xLyl0044
# eHI7Y95GPaw8OlSTeNiNAKl+MyH5OaifsUuyVHOf4rsrE+ZyAuS9e9ERqu5H/10C
# AwEAAaOCATYwggEyMB0GA1UdDgQWBBRVAolUT3eV3wK/+Luf/wawCPMYpzAfBgNV
# HSMEGDAWgBSfpxVdAF5iXYP05dJlpxtTNRnpcjBfBgNVHR8EWDBWMFSgUqBQhk5o
# dHRwOi8vd3d3Lm1pY3Jvc29mdC5jb20vcGtpb3BzL2NybC9NaWNyb3NvZnQlMjBU
# aW1lLVN0YW1wJTIwUENBJTIwMjAxMCgxKS5jcmwwbAYIKwYBBQUHAQEEYDBeMFwG
# CCsGAQUFBzAChlBodHRwOi8vd3d3Lm1pY3Jvc29mdC5jb20vcGtpb3BzL2NlcnRz
# L01pY3Jvc29mdCUyMFRpbWUtU3RhbXAlMjBQQ0ElMjAyMDEwKDEpLmNydDAMBgNV
# HRMBAf8EAjAAMBMGA1UdJQQMMAoGCCsGAQUFBwMIMA0GCSqGSIb3DQEBCwUAA4IC
# AQAjCREvjT6yXwJYdvkFUqTGGh6RizAY+ciuB6UOBUm0yqq5QC+5pCEa9WSMvbUG
# zxDCEFBgD93gWGnkiyYcHCazlgZK+E7WxtI3bP++Fb4RJZiWLo/IC9hX12hCZZwY
# XIGVzC9BVAcNx/zsFqI/9u8u/bhGjDHPad47C4OQNCHrkNqzGYxb4GQq6Psw6o7c
# Ety3MU3Jd4uzBazaFhPRvmBfSn+Ufd6pTNZLgIX9BjrLmZblc/d2LIAurEr5W29W
# fW5RMRIEZzO9TaMr/zzdmW/cV6VdaDTygy5g4O3UXadt1DraUpn5jcD10TVWNnyz
# /paeleHojrGCCksqexpelMkUsiYP0HX9pFUgNglWU10r1wEzFwZM9aX2Rqq3fFRr
# N3gu8tCX+H1nKK2AobW1vmsKLTH6PyX1LkyvRwTj45a1paeHIR8TGzm3+iY7wpC1
# MHuzqAqAdDeaIVdVlch807VJJ4hDive6AiOQCV9MwiUyhf5v4P8jTGof8CqjDb3P
# nLlNSnFm2BFhMZ35oNTEosc37GZHScM83hTN1E481sLYJrrhhcdtcyNB60juMjqG
# UD6uQ/7DbMvtv93tFj5WjxVhMCkkY66EEYgpfFLOCb2ngJJWFuJCIGsCiDfDxGwE
# 4RVYAnoFzoa2OfSqijYg2drdZfpptRRvKxMsAzu3oxkS/TCCB3EwggVZoAMCAQIC
# EzMAAAAVxedrngKbSZkAAAAAABUwDQYJKoZIhvcNAQELBQAwgYgxCzAJBgNVBAYT
# AlVTMRMwEQYDVQQIEwpXYXNoaW5ndG9uMRAwDgYDVQQHEwdSZWRtb25kMR4wHAYD
# VQQKExVNaWNyb3NvZnQgQ29ycG9yYXRpb24xMjAwBgNVBAMTKU1pY3Jvc29mdCBS
# b290IENlcnRpZmljYXRlIEF1dGhvcml0eSAyMDEwMB4XDTIxMDkzMDE4MjIyNVoX
# DTMwMDkzMDE4MzIyNVowfDELMAkGA1UEBhMCVVMxEzARBgNVBAgTCldhc2hpbmd0
# b24xEDAOBgNVBAcTB1JlZG1vbmQxHjAcBgNVBAoTFU1pY3Jvc29mdCBDb3Jwb3Jh
# dGlvbjEmMCQGA1UEAxMdTWljcm9zb2Z0IFRpbWUtU3RhbXAgUENBIDIwMTAwggIi
# MA0GCSqGSIb3DQEBAQUAA4ICDwAwggIKAoICAQDk4aZM57RyIQt5osvXJHm9DtWC
# 0/3unAcH0qlsTnXIyjVX9gF/bErg4r25PhdgM/9cT8dm95VTcVrifkpa/rg2Z4VG
# Iwy1jRPPdzLAEBjoYH1qUoNEt6aORmsHFPPFdvWGUNzBRMhxXFExN6AKOG6N7dcP
# 2CZTfDlhAnrEqv1yaa8dq6z2Nr41JmTamDu6GnszrYBbfowQHJ1S/rboYiXcag/P
# XfT+jlPP1uyFVk3v3byNpOORj7I5LFGc6XBpDco2LXCOMcg1KL3jtIckw+DJj361
# VI/c+gVVmG1oO5pGve2krnopN6zL64NF50ZuyjLVwIYwXE8s4mKyzbnijYjklqwB
# Sru+cakXW2dg3viSkR4dPf0gz3N9QZpGdc3EXzTdEonW/aUgfX782Z5F37ZyL9t9
# X4C626p+Nuw2TPYrbqgSUei/BQOj0XOmTTd0lBw0gg/wEPK3Rxjtp+iZfD9M269e
# wvPV2HM9Q07BMzlMjgK8QmguEOqEUUbi0b1qGFphAXPKZ6Je1yh2AuIzGHLXpyDw
# wvoSCtdjbwzJNmSLW6CmgyFdXzB0kZSU2LlQ+QuJYfM2BjUYhEfb3BvR/bLUHMVr
# 9lxSUV0S2yW6r1AFemzFER1y7435UsSFF5PAPBXbGjfHCBUYP3irRbb1Hode2o+e
# FnJpxq57t7c+auIurQIDAQABo4IB3TCCAdkwEgYJKwYBBAGCNxUBBAUCAwEAATAj
# BgkrBgEEAYI3FQIEFgQUKqdS/mTEmr6CkTxGNSnPEP8vBO4wHQYDVR0OBBYEFJ+n
# FV0AXmJdg/Tl0mWnG1M1GelyMFwGA1UdIARVMFMwUQYMKwYBBAGCN0yDfQEBMEEw
# PwYIKwYBBQUHAgEWM2h0dHA6Ly93d3cubWljcm9zb2Z0LmNvbS9wa2lvcHMvRG9j
# cy9SZXBvc2l0b3J5Lmh0bTATBgNVHSUEDDAKBggrBgEFBQcDCDAZBgkrBgEEAYI3
# FAIEDB4KAFMAdQBiAEMAQTALBgNVHQ8EBAMCAYYwDwYDVR0TAQH/BAUwAwEB/zAf
# BgNVHSMEGDAWgBTV9lbLj+iiXGJo0T2UkFvXzpoYxDBWBgNVHR8ETzBNMEugSaBH
# hkVodHRwOi8vY3JsLm1pY3Jvc29mdC5jb20vcGtpL2NybC9wcm9kdWN0cy9NaWNS
# b29DZXJBdXRfMjAxMC0wNi0yMy5jcmwwWgYIKwYBBQUHAQEETjBMMEoGCCsGAQUF
# BzAChj5odHRwOi8vd3d3Lm1pY3Jvc29mdC5jb20vcGtpL2NlcnRzL01pY1Jvb0Nl
# ckF1dF8yMDEwLTA2LTIzLmNydDANBgkqhkiG9w0BAQsFAAOCAgEAnVV9/Cqt4Swf
# ZwExJFvhnnJL/Klv6lwUtj5OR2R4sQaTlz0xM7U518JxNj/aZGx80HU5bbsPMeTC
# j/ts0aGUGCLu6WZnOlNN3Zi6th542DYunKmCVgADsAW+iehp4LoJ7nvfam++Kctu
# 2D9IdQHZGN5tggz1bSNU5HhTdSRXud2f8449xvNo32X2pFaq95W2KFUn0CS9QKC/
# GbYSEhFdPSfgQJY4rPf5KYnDvBewVIVCs/wMnosZiefwC2qBwoEZQhlSdYo2wh3D
# YXMuLGt7bj8sCXgU6ZGyqVvfSaN0DLzskYDSPeZKPmY7T7uG+jIa2Zb0j/aRAfbO
# xnT99kxybxCrdTDFNLB62FD+CljdQDzHVG2dY3RILLFORy3BFARxv2T5JL5zbcqO
# Cb2zAVdJVGTZc9d/HltEAY5aGZFrDZ+kKNxnGSgkujhLmm77IVRrakURR6nxt67I
# 6IleT53S0Ex2tVdUCbFpAUR+fKFhbHP+CrvsQWY9af3LwUFJfn6Tvsv4O+S3Fb+0
# zj6lMVGEvL8CwYKiexcdFYmNcP7ntdAoGokLjzbaukz5m/8K6TT4JDVnK+ANuOaM
# mdbhIurwJ0I9JZTmdHRbatGePu1+oDEzfbzL6Xu/OHBE0ZDxyKs6ijoIYn/ZcGNT
# TY3ugm2lBRDBcQZqELQdVTNYs6FwZvKhggLLMIICNAIBATCB+KGB0KSBzTCByjEL
# MAkGA1UEBhMCVVMxEzARBgNVBAgTCldhc2hpbmd0b24xEDAOBgNVBAcTB1JlZG1v
# bmQxHjAcBgNVBAoTFU1pY3Jvc29mdCBDb3Jwb3JhdGlvbjElMCMGA1UECxMcTWlj
# cm9zb2Z0IEFtZXJpY2EgT3BlcmF0aW9uczEmMCQGA1UECxMdVGhhbGVzIFRTUyBF
# U046QUUyQy1FMzJCLTFBRkMxJTAjBgNVBAMTHE1pY3Jvc29mdCBUaW1lLVN0YW1w
# IFNlcnZpY2WiIwoBATAHBgUrDgMCGgMVADgEd+JNrp4dpvFKMZi91txbfic3oIGD
# MIGApH4wfDELMAkGA1UEBhMCVVMxEzARBgNVBAgTCldhc2hpbmd0b24xEDAOBgNV
# BAcTB1JlZG1vbmQxHjAcBgNVBAoTFU1pY3Jvc29mdCBDb3Jwb3JhdGlvbjEmMCQG
# A1UEAxMdTWljcm9zb2Z0IFRpbWUtU3RhbXAgUENBIDIwMTAwDQYJKoZIhvcNAQEF
# BQACBQDoFXSgMCIYDzIwMjMwNTIyMTI1NzA0WhgPMjAyMzA1MjMxMjU3MDRaMHQw
# OgYKKwYBBAGEWQoEATEsMCowCgIFAOgVdKACAQAwBwIBAAICDnIwBwIBAAICEhIw
# CgIFAOgWxiACAQAwNgYKKwYBBAGEWQoEAjEoMCYwDAYKKwYBBAGEWQoDAqAKMAgC
# AQACAwehIKEKMAgCAQACAwGGoDANBgkqhkiG9w0BAQUFAAOBgQBVYV9rfo1dbuTO
# /HXcuv2vd9kchrEjFEdgsrR595hQvoZtcL6b7/jf3AQRhsWSmjIg3eYfvEO4wElq
# SZ+VNiduUWYV7IjbNOEn8hjhxVa1b1KeEbfgA/5t74PAZGaTlQ2gESGS0jx9hZIM
# eFm+0qWP9s23Z9bR/n3gI4KUN6J5pzGCBA0wggQJAgEBMIGTMHwxCzAJBgNVBAYT
# AlVTMRMwEQYDVQQIEwpXYXNoaW5ndG9uMRAwDgYDVQQHEwdSZWRtb25kMR4wHAYD
# VQQKExVNaWNyb3NvZnQgQ29ycG9yYXRpb24xJjAkBgNVBAMTHU1pY3Jvc29mdCBU
# aW1lLVN0YW1wIFBDQSAyMDEwAhMzAAABv99uuQQVUihYAAEAAAG/MA0GCWCGSAFl
# AwQCAQUAoIIBSjAaBgkqhkiG9w0BCQMxDQYLKoZIhvcNAQkQAQQwLwYJKoZIhvcN
# AQkEMSIEILiNbAAm+q4RJIupbuqwuxw+2vm8IrFTco4Zr2HdocAfMIH6BgsqhkiG
# 9w0BCRACLzGB6jCB5zCB5DCBvQQg/Q4tRz63EiRj4K+19yNUwogBIOsp44CIuBfn
# ZHCvBa4wgZgwgYCkfjB8MQswCQYDVQQGEwJVUzETMBEGA1UECBMKV2FzaGluZ3Rv
# bjEQMA4GA1UEBxMHUmVkbW9uZDEeMBwGA1UEChMVTWljcm9zb2Z0IENvcnBvcmF0
# aW9uMSYwJAYDVQQDEx1NaWNyb3NvZnQgVGltZS1TdGFtcCBQQ0EgMjAxMAITMwAA
# Ab/fbrkEFVIoWAABAAABvzAiBCDLYvqRJMQsupogrjsOa5IXDlMDe4BChmY+p/h4
# 7MKIYTANBgkqhkiG9w0BAQsFAASCAgApzufw2HUb4lVwU70fFvx8cdlzPd79gdqK
# yloDD0shUVMlUhYC1mO7Y+QW6h5KVUBLfAV7dFwmRgXbMcIXa14vbdf1BTByxGaF
# Fj6DimaDnnq56/QM9FYUUZ1q0gUuUsVN7QLo96riuUnPp78dvRSXTbTUiDqJeYZr
# h1eHpStxu3kYHtTFBIrq/Qx4QWP2DES68lRjCL6n1DKXYu/CB6b+FtWciNvf6DdS
# ZD1D4kM14fOl/92MCnFaGGFKmcQKU2bTTN+i1blAiUtk4OrEKwUwN0dTICg2fnPk
# SEkN5rFJ+lJAUmx0I6sJ5NTEdcDOvcIhLwWJBq3oOA5HEeQ2x6kRsPV0lOH7+8jg
# u3jwlUoCurgiGm+MyZXctSzXrbxlOtaN2BwCXa3Hs5tKbAmySRrSYDGXxO8aJXAc
# JGt14xTEwZUZtD1EiAIMSW9GO33AwXYkKE93yCnEXRYeLoTn6CIqS3YwWitSliIe
# 3IF0CYrk8zXlhS0PWJfrqLITodUz4KtIBbFmvwpU6TkDtv7qOYz7CR+aMeLFT/ad
# YfDtwJEQ66BJu2PVP5dUnBJUXp75Htk9Lmeh6+TPIO8E7nC0hI4K5OddzkuUF6ZL
# zDnn8CSCpyvacWNhLzmJj4ktiH/gUlAUWyDccfawoR5vF90RO3eZMEGL4WT3m3Ld
# vl5T1hCOtA==
# SIG # End signature block
