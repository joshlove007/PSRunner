#
# Module manifest for module 'Az.RecoveryServices'
#
# Generated by: Microsoft Corporation
#
# Generated on: 06/29/2023
#

@{

# Script module or binary module file associated with this manifest.
RootModule = 'Az.RecoveryServices.psm1'

# Version number of this module.
ModuleVersion = '6.5.0'

# Supported PSEditions
CompatiblePSEditions = 'Core', 'Desktop'

# ID used to uniquely identify this module
GUID = '5af71f43-17ca-45bd-b534-34524b801ade'

# Author of this module
Author = 'Microsoft Corporation'

# Company or vendor of this module
CompanyName = 'Microsoft Corporation'

# Copyright statement for this module
Copyright = 'Microsoft Corporation. All rights reserved.'

# Description of the functionality provided by this module
Description = 'Microsoft Azure PowerShell - Recovery Services cmdlets for Azure Resource Manager in Windows PowerShell and PowerShell Core.

For more information on Recovery Services Backup, please visit the following: https://learn.microsoft.com/azure/backup/
For more information on Site Recovery, please visit the following: https://learn.microsoft.com/azure/site-recovery/'

# Minimum version of the PowerShell engine required by this module
PowerShellVersion = '5.1'

# Name of the PowerShell host required by this module
# PowerShellHostName = ''

# Minimum version of the PowerShell host required by this module
# PowerShellHostVersion = ''

# Minimum version of Microsoft .NET Framework required by this module. This prerequisite is valid for the PowerShell Desktop edition only.
DotNetFrameworkVersion = '4.7.2'

# Minimum version of the common language runtime (CLR) required by this module. This prerequisite is valid for the PowerShell Desktop edition only.
# ClrVersion = ''

# Processor architecture (None, X86, Amd64) required by this module
# ProcessorArchitecture = ''

# Modules that must be imported into the global environment prior to importing this module
RequiredModules = @()

# Assemblies that must be loaded prior to importing this module
RequiredAssemblies = 'Microsoft.Azure.PowerShell.AutoMapper.dll', 
               'Microsoft.Azure.PowerShell.Cmdlets.RecoveryServices.Backup.Models.dll', 
               'Microsoft.Azure.PowerShell.Cmdlets.RecoveryServices.Backup.Helpers.dll', 
               'Microsoft.Azure.PowerShell.Cmdlets.RecoveryServices.Backup.Logger.dll', 
               'Microsoft.Azure.PowerShell.Cmdlets.RecoveryServices.Backup.Providers.dll', 
               'Microsoft.Azure.PowerShell.Cmdlets.RecoveryServices.Backup.ServiceClientAdapter.dll', 
               'Microsoft.Azure.PowerShell.RecoveryServices.Management.Sdk.dll', 
               'Microsoft.Azure.PowerShell.RecoveryServices.Backup.Management.Sdk.dll', 
               'Microsoft.Azure.PowerShell.RecoveryServices.Backup.CrossRegionRestore.Management.Sdk.dll', 
               'Microsoft.Azure.PowerShell.RecoveryServices.SiteRecovery.Management.Sdk.dll', 
               'System.Configuration.ConfigurationManager.dll', 
               'TimeZoneConverter.dll'

# Script files (.ps1) that are run in the caller's environment prior to importing this module.
# ScriptsToProcess = @()

# Type files (.ps1xml) to be loaded when importing this module
# TypesToProcess = @()

# Format files (.ps1xml) to be loaded when importing this module
FormatsToProcess = 'RecoveryServices.Backup.format.ps1xml'

# Modules to import as nested modules of the module specified in RootModule/ModuleToProcess
NestedModules = @()

# Functions to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no functions to export.
FunctionsToExport = @()

# Cmdlets to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no cmdlets to export.
CmdletsToExport = 'Get-AzRecoveryServicesBackupProperty', 
               'Get-AzRecoveryServicesVault', 
               'Get-AzRecoveryServicesVaultSettingsFile', 
               'New-AzRecoveryServicesVault', 'Remove-AzRecoveryServicesVault', 
               'Add-AzRecoveryServicesAsrReplicationProtectedItemDisk', 
               'Edit-AzRecoveryServicesAsrRecoveryPlan', 
               'Get-AzRecoveryServicesAsrAlertSetting', 
               'Get-AzRecoveryServicesAsrEvent', 'Get-AzRecoveryServicesAsrFabric', 
               'Get-AzRecoveryServicesAsrJob', 'Get-AzRecoveryServicesAsrNetwork', 
               'Get-AzRecoveryServicesAsrNetworkMapping', 
               'Get-AzRecoveryServicesAsrPolicy', 
               'Get-AzRecoveryServicesAsrProtectableItem', 
               'Get-AzRecoveryServicesAsrProtectionContainer', 
               'Get-AzRecoveryServicesAsrProtectionContainerMapping', 
               'Get-AzRecoveryServicesAsrRecoveryPlan', 
               'Get-AzRecoveryServicesAsrRecoveryPoint', 
               'Get-AzRecoveryServicesAsrReplicationProtectedItem', 
               'Get-AzRecoveryServicesAsrServicesProvider', 
               'Get-AzRecoveryServicesAsrStorageClassification', 
               'Get-AzRecoveryServicesAsrStorageClassificationMapping', 
               'Get-AzRecoveryServicesAsrVaultContext', 
               'Get-AzRecoveryServicesAsrvCenter', 
               'Import-AzRecoveryServicesAsrVaultSettingsFile', 
               'New-AzRecoveryServicesAsrFabric', 
               'New-AzRecoveryServicesAsrInMageAzureV2DiskInput', 
               'New-AzRecoveryServicesAsrNetworkMapping', 
               'New-AzRecoveryServicesAsrPolicy', 
               'New-AzRecoveryServicesAsrProtectableItem', 
               'New-AzRecoveryServicesAsrProtectionContainer', 
               'New-AzRecoveryServicesAsrProtectionContainerMapping', 
               'New-AzRecoveryServicesAsrRecoveryPlan', 
               'New-AzRecoveryServicesAsrReplicationProtectedItem', 
               'New-AzRecoveryServicesAsrStorageClassificationMapping', 
               'New-AzRecoveryServicesAsrvCenter', 
               'New-AzRecoveryServicesAsrAzureToAzureDiskReplicationConfig', 
               'New-AzRecoveryServicesAsrVMNicConfig', 
               'New-AzRecoveryServicesAsrVMNicIPConfig', 
               'Remove-AzRecoveryServicesAsrFabric', 
               'Remove-AzRecoveryServicesAsrNetworkMapping', 
               'Remove-AzRecoveryServicesAsrPolicy', 
               'Remove-AzRecoveryServicesAsrProtectionContainer', 
               'Remove-AzRecoveryServicesAsrProtectionContainerMapping', 
               'Remove-AzRecoveryServicesAsrRecoveryPlan', 
               'Remove-AzRecoveryServicesAsrReplicationProtectedItem', 
               'Remove-AzRecoveryServicesAsrReplicationProtectedItemDisk', 
               'Remove-AzRecoveryServicesAsrServicesProvider', 
               'Remove-AzRecoveryServicesAsrStorageClassificationMapping', 
               'Remove-AzRecoveryServicesAsrvCenter', 
               'Restart-AzRecoveryServicesAsrJob', 
               'Resume-AzRecoveryServicesAsrJob', 
               'Set-AzRecoveryServicesAsrAlertSetting', 
               'Set-AzRecoveryServicesAsrReplicationProtectedItem', 
               'Set-AzRecoveryServicesAsrVaultContext', 
               'Start-AzRecoveryServicesAsrApplyRecoveryPoint', 
               'Start-AzRecoveryServicesAsrCommitFailoverJob', 
               'Start-AzRecoveryServicesAsrPlannedFailoverJob', 
               'Start-AzRecoveryServicesAsrResynchronizeReplicationJob', 
               'Start-AzRecoveryServicesAsrSwitchAppliance', 
               'Start-AzRecoveryServicesAsrSwitchProcessServerJob', 
               'Start-AzRecoveryServicesAsrTestFailoverCleanupJob', 
               'Start-AzRecoveryServicesAsrTestFailoverJob', 
               'Start-AzRecoveryServicesAsrUnplannedFailoverJob', 
               'Stop-AzRecoveryServicesAsrJob', 
               'Update-AzRecoveryServicesAsrMobilityService', 
               'Update-AzRecoveryServicesAsrNetworkMapping', 
               'Update-AzRecoveryServicesAsrPolicy', 
               'Update-AzRecoveryServicesAsrProtectionContainerMapping', 
               'Update-AzRecoveryServicesAsrProtectionDirection', 
               'Update-AzRecoveryServicesAsrRecoveryPlan', 
               'Update-AzRecoveryServicesAsrServicesProvider', 
               'Update-AzRecoveryServicesAsrvCenter', 
               'Set-AzRecoveryServicesBackupProperty', 
               'Set-AzRecoveryServicesVaultContext', 
               'Backup-AzRecoveryServicesBackupItem', 
               'Get-AzRecoveryServicesBackupManagementServer', 
               'Get-AzRecoveryServicesBackupContainer', 
               'Register-AzRecoveryServicesBackupContainer', 
               'Unregister-AzRecoveryServicesBackupContainer', 
               'Disable-AzRecoveryServicesBackupProtection', 
               'Enable-AzRecoveryServicesBackupProtection', 
               'Enable-AzRecoveryServicesBackupAutoProtection', 
               'Disable-AzRecoveryServicesBackupAutoProtection', 
               'Get-AzRecoveryServicesBackupItem', 
               'Get-AzRecoveryServicesBackupProtectableItem', 
               'Initialize-AzRecoveryServicesBackupProtectableItem', 
               'Get-AzRecoveryServicesBackupJob', 
               'Get-AzRecoveryServicesBackupJobDetail', 
               'Stop-AzRecoveryServicesBackupJob', 
               'Wait-AzRecoveryServicesBackupJob', 
               'Get-AzRecoveryServicesBackupProtectionPolicy', 
               'Get-AzRecoveryServicesBackupRetentionPolicyObject', 
               'Get-AzRecoveryServicesBackupSchedulePolicyObject', 
               'New-AzRecoveryServicesBackupProtectionPolicy', 
               'Remove-AzRecoveryServicesBackupProtectionPolicy', 
               'Set-AzRecoveryServicesBackupProtectionPolicy', 
               'Get-AzRecoveryServicesBackupRecoveryPoint', 
               'Get-AzRecoveryServicesBackupRecoveryLogChain', 
               'Restore-AzRecoveryServicesBackupItem', 
               'Get-AzRecoveryServicesBackupWorkloadRecoveryConfig', 
               'Unregister-AzRecoveryServicesBackupManagementServer', 
               'Get-AzRecoveryServicesBackupRPMountScript', 
               'Disable-AzRecoveryServicesBackupRPMountScript', 
               'Get-AzRecoveryServicesBackupStatus', 
               'Undo-AzRecoveryServicesBackupItemDeletion', 
               'Set-AzRecoveryServicesVaultProperty', 
               'Get-AzRecoveryServicesVaultProperty', 
               'Copy-AzRecoveryServicesVault', 'Update-AzRecoveryServicesVault', 
               'New-AzRecoveryServicesAsrInMageRcmDiskInput', 
               'Start-AzRecoveryServicesAsrCancelFailoverJob', 
               'Test-AzRecoveryServicesDSMove', 
               'Initialize-AzRecoveryServicesDSMove', 
               'Get-AzRecoveryServicesBackupRecommendedArchivableRPGroup', 
               'Move-AzRecoveryServicesBackupRecoveryPoint', 
               'Get-AzRecoveryServicesResourceGuardMapping', 
               'Remove-AzRecoveryServicesResourceGuardMapping', 
               'Set-AzRecoveryServicesResourceGuardMapping'

# Variables to export from this module
# VariablesToExport = @()

# Aliases to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no aliases to export.
AliasesToExport = 'Get-AzRecoveryServicesBackupProperties', 
               'Add-ASRReplicationProtectedItemDisk', 'Edit-ASRRP', 
               'Edit-ASRRecoveryPlan', 'Get-ASRAlertSetting', 'Get-ASREvent', 
               'Get-ASRFabric', 'Get-ASRJob', 'Get-ASRNetwork', 
               'Get-ASRNetworkMapping', 'Get-ASRNotificationSetting', 
               'Get-ASRPolicy', 'Get-ASRProtectableItem', 
               'Get-ASRProtectionContainer', 'Get-ASRProtectionContainerMapping', 
               'Get-ASRRP', 'Get-ASRRecoveryPlan', 'Get-ASRRecoveryPoint', 
               'Get-ASRReplicationProtectedItem', 'Get-ASRServicesProvider', 
               'Get-ASRStorageClassification', 
               'Get-ASRStorageClassificationMapping', 'Set-ASRVaultContext', 
               'Set-ASRVaultSettings', 'Get-ASRvCenter', 
               'Get-AzRecoveryServicesAsrNotificationSetting', 
               'Get-AzRecoveryServicesAsrVaultSettings', 'New-ASRFabric', 
               'New-AsrInMageAzureV2DiskInput', 'New-ASRNetworkMapping', 
               'New-ASRPolicy', 'New-ASRProtectableItem', 
               'New-ASRProtectionContainerMapping', 'New-ASRRP', 
               'New-ASRRecoveryPlan', 'New-ASRReplicationProtectedItem', 
               'New-ASRStorageClassificationMapping', 'New-ASRvCenter', 
               'New-ASRVMNicConfig', 'Remove-ASRFabric', 'Remove-ASRNetworkMapping', 
               'Remove-ASRPolicy', 'Remove-ASRProtectionContainerMapping', 
               'Remove-ASRRP', 'Remove-ASRRecoveryPlan', 
               'Remove-ASRReplicationProtectedItem', 'Remove-ASRServicesProvider', 
               'Remove-ASRReplicationProtectedItemDisk', 
               'Remove-ASRStorageClassificationMapping', 'Remove-ASRvCenter', 
               'Restart-ASRJob', 'Resume-ASRJob', 'Set-ASRAlertSetting', 
               'Set-ASRNotificationSetting', 'Set-ASRReplicationProtectedItem', 
               'Set-AzRecoveryServicesAsrNotificationSetting', 
               'Set-AzRecoveryServicesAsrVaultSettings', 
               'Start-ASRApplyRecoveryPoint', 'Start-ASRCommitFailover', 
               'Start-ASRCommitFailoverJob', 'Start-ASRFO', 'Start-ASRPFO', 
               'Start-ASRPlannedFailoverJob', 'Start-ASRResyncJob', 
               'Start-ASRResynchronizeReplicationJob', 
               'Start-ASRSwitchProcessServerJob', 'Start-ASRTFO', 
               'Start-ASRTFOCleanupJob', 'Start-ASRTestFailoverCleanupJob', 
               'Start-ASRTestFailoverJob', 'Start-ASRUnplannedFailoverJob', 
               'Stop-ASRJob', 'Update-ASRMobilityService', 'Update-ASRPolicy', 
               'Update-ASRProtectionContainerMapping', 
               'Update-ASRProtectionDirection', 'Update-ASRRecoveryPlan', 
               'Update-ASRServicesProvider', 'Update-ASRvCenter', 
               'New-ASRInMageRcmDiskInput', 'Start-ASRCancelFailover', 
               'Start-ASRCancelFailoverJob', 'Start-ASRSwitchAppliance'

# DSC resources to export from this module
# DscResourcesToExport = @()

# List of all modules packaged with this module
# ModuleList = @()

# List of all files packaged with this module
# FileList = @()

# Private data to pass to the module specified in RootModule/ModuleToProcess. This may also contain a PSData hashtable with additional module metadata used by PowerShell.
PrivateData = @{

    PSData = @{

        # Tags applied to this module. These help with module discovery in online galleries.
        Tags = 'Azure','ResourceManager','ARM','RecoveryServices'

        # A URL to the license for this module.
        LicenseUri = 'https://aka.ms/azps-license'

        # A URL to the main website for this project.
        ProjectUri = 'https://github.com/Azure/azure-powershell'

        # A URL to an icon representing this module.
        # IconUri = ''

        # ReleaseNotes of this module
        ReleaseNotes = '* Added CRR support for new regions malaysiasouth, chinanorth3, chinaeast3, jioindiacentral, jioindiawest.
* Regenerated CRR SDK. Fixed issues with SQL CRR.
* Fixed bug with rp expiry time, making 30 days expiry time for adhoc backup as default from client side.
* Added example to fetch pruned recovery points after modify policy.
* Fixed the documentation for suspend backups with immutability.'

        # Prerelease string of this module
        # Prerelease = ''

        # Flag to indicate whether the module requires explicit user acceptance for install/update/save
        # RequireLicenseAcceptance = $false

        # External dependent modules of this module
        # ExternalModuleDependencies = @()

    } # End of PSData hashtable

 } # End of PrivateData hashtable

# HelpInfo URI of this module
# HelpInfoURI = ''

# Default prefix for commands exported from this module. Override the default prefix using Import-Module -Prefix.
# DefaultCommandPrefix = ''

}


# SIG # Begin signature block
# MIInvwYJKoZIhvcNAQcCoIInsDCCJ6wCAQExDzANBglghkgBZQMEAgEFADB5Bgor
# BgEEAYI3AgEEoGswaTA0BgorBgEEAYI3AgEeMCYCAwEAAAQQH8w7YFlLCE63JNLG
# KX7zUQIBAAIBAAIBAAIBAAIBADAxMA0GCWCGSAFlAwQCAQUABCA3LylT3/x+F2RV
# e2ZFf3+0yFl5Bk+vr+qctJeiyjinFaCCDXYwggX0MIID3KADAgECAhMzAAADTrU8
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
# /Xmfwb1tbWrJUnMTDXpQzTGCGZ8wghmbAgEBMIGVMH4xCzAJBgNVBAYTAlVTMRMw
# EQYDVQQIEwpXYXNoaW5ndG9uMRAwDgYDVQQHEwdSZWRtb25kMR4wHAYDVQQKExVN
# aWNyb3NvZnQgQ29ycG9yYXRpb24xKDAmBgNVBAMTH01pY3Jvc29mdCBDb2RlIFNp
# Z25pbmcgUENBIDIwMTECEzMAAANOtTx6wYRv6ysAAAAAA04wDQYJYIZIAWUDBAIB
# BQCgga4wGQYJKoZIhvcNAQkDMQwGCisGAQQBgjcCAQQwHAYKKwYBBAGCNwIBCzEO
# MAwGCisGAQQBgjcCARUwLwYJKoZIhvcNAQkEMSIEIKmTAYxs8Y+feoFyDW9tY6jn
# fwVl53lk/Oo/YQ5MWiRBMEIGCisGAQQBgjcCAQwxNDAyoBSAEgBNAGkAYwByAG8A
# cwBvAGYAdKEagBhodHRwOi8vd3d3Lm1pY3Jvc29mdC5jb20wDQYJKoZIhvcNAQEB
# BQAEggEAO51YQ7u0C4AbB8nzpK8n2wOhph5mycoKhwb9eckgkID+Y89J3PLpF1Q6
# Iw24cUWir5MBPf0UDlSBBL7rSKCQz7dL3nQELEG9F6DZQD058urlPCpzxdY6D2u1
# f8Ocy60C77LuRg6QgAsOTPHl0zXkJ6akPcsU5/WCmrsliVQYQ5SXDbkD1/1JRsf2
# samsKxv4qni9OA8uW/IGvX8etHfLS3OF98G0nNHNpmFsWH1HGAVZvxggcumMy+zK
# kP8QU276ge23BJjXC6v3NOw6vgCA6YuR6Qd0uXpOyrSUje5I348A59B/3HhNEeLB
# lj8awhNKPz6j+AGCLZW6W+fSD0HGu6GCFykwghclBgorBgEEAYI3AwMBMYIXFTCC
# FxEGCSqGSIb3DQEHAqCCFwIwghb+AgEDMQ8wDQYJYIZIAWUDBAIBBQAwggFZBgsq
# hkiG9w0BCRABBKCCAUgEggFEMIIBQAIBAQYKKwYBBAGEWQoDATAxMA0GCWCGSAFl
# AwQCAQUABCBN41iNXp+cmpX0DIQv1hb9WhtydE3z2f4bR1HjQw6gaQIGZJLlY1XI
# GBMyMDIzMDYyOTA4NTA1My4yOTJaMASAAgH0oIHYpIHVMIHSMQswCQYDVQQGEwJV
# UzETMBEGA1UECBMKV2FzaGluZ3RvbjEQMA4GA1UEBxMHUmVkbW9uZDEeMBwGA1UE
# ChMVTWljcm9zb2Z0IENvcnBvcmF0aW9uMS0wKwYDVQQLEyRNaWNyb3NvZnQgSXJl
# bGFuZCBPcGVyYXRpb25zIExpbWl0ZWQxJjAkBgNVBAsTHVRoYWxlcyBUU1MgRVNO
# OjJBRDQtNEI5Mi1GQTAxMSUwIwYDVQQDExxNaWNyb3NvZnQgVGltZS1TdGFtcCBT
# ZXJ2aWNloIIReDCCBycwggUPoAMCAQICEzMAAAGxypBD7gvwA6sAAQAAAbEwDQYJ
# KoZIhvcNAQELBQAwfDELMAkGA1UEBhMCVVMxEzARBgNVBAgTCldhc2hpbmd0b24x
# EDAOBgNVBAcTB1JlZG1vbmQxHjAcBgNVBAoTFU1pY3Jvc29mdCBDb3Jwb3JhdGlv
# bjEmMCQGA1UEAxMdTWljcm9zb2Z0IFRpbWUtU3RhbXAgUENBIDIwMTAwHhcNMjIw
# OTIwMjAyMTU5WhcNMjMxMjE0MjAyMTU5WjCB0jELMAkGA1UEBhMCVVMxEzARBgNV
# BAgTCldhc2hpbmd0b24xEDAOBgNVBAcTB1JlZG1vbmQxHjAcBgNVBAoTFU1pY3Jv
# c29mdCBDb3Jwb3JhdGlvbjEtMCsGA1UECxMkTWljcm9zb2Z0IElyZWxhbmQgT3Bl
# cmF0aW9ucyBMaW1pdGVkMSYwJAYDVQQLEx1UaGFsZXMgVFNTIEVTTjoyQUQ0LTRC
# OTItRkEwMTElMCMGA1UEAxMcTWljcm9zb2Z0IFRpbWUtU3RhbXAgU2VydmljZTCC
# AiIwDQYJKoZIhvcNAQEBBQADggIPADCCAgoCggIBAIaiqz7V7BvH7IOMPEeDM2Uw
# CpM8LxAUPeJ7Uvu9q0RiDBdBgshC/SDre3/YJBqGpn27a7XWOMviiBUfMNff51Nx
# KFoSX62Gpq36YLRZk2hN1wigrCO656z5pVTjJp3Q8jdYAJX3ruJea3ccfTgxAgT3
# Uv/sP4w0+yZAYa2JZalV3MBgIFi3VwKFA4ClQcr+V4SpGzqz8faqabmYypuJ35Zn
# 8G/201pAN2jDEOu7QaDC0rGyDdwSTVmXcHM46EFV6N2F69nwfj2DZh74gnA1DB7N
# FcZn+4v1kqQWn7AzBJ+lmOxvKrURlV/u19Mw1YP+zVQyzKn5/4r/vuYSRj/thZr+
# FmZAUtTAacLzouBENuaSBuOY1k330eMp8nndSNUsUjj/nn7gcdFqzdQNudJb+Xxm
# Rwi9LwjA0/8PlOsKTZ8Xw6EEWPVLfNojSuWpZMTaMzz/wzSPp5J02kpYmkdl50lw
# yGRLO5X7iWINKmoXySdQmRdiGMTkvRStXKxIoEm/EJxCaI+k4S3+BWKWC07EV5T3
# UG7wbFb4LfvgbbaKM58HytAyjDnO9fEi0vrp8JFTtGhdtwhEEkraMtGVt+CvnG0Z
# lH4mvpPRPuJbqE509e6CqmHwzTuUZPFMFWvJn4fPv0d32Ws9jv2YYmE/0WR1fULs
# +TxxpWgn1z0PAOsxSZRPAgMBAAGjggFJMIIBRTAdBgNVHQ4EFgQU9Jtnke8NrYSK
# 9fFnoVE0pr0OOZMwHwYDVR0jBBgwFoAUn6cVXQBeYl2D9OXSZacbUzUZ6XIwXwYD
# VR0fBFgwVjBUoFKgUIZOaHR0cDovL3d3dy5taWNyb3NvZnQuY29tL3BraW9wcy9j
# cmwvTWljcm9zb2Z0JTIwVGltZS1TdGFtcCUyMFBDQSUyMDIwMTAoMSkuY3JsMGwG
# CCsGAQUFBwEBBGAwXjBcBggrBgEFBQcwAoZQaHR0cDovL3d3dy5taWNyb3NvZnQu
# Y29tL3BraW9wcy9jZXJ0cy9NaWNyb3NvZnQlMjBUaW1lLVN0YW1wJTIwUENBJTIw
# MjAxMCgxKS5jcnQwDAYDVR0TAQH/BAIwADAWBgNVHSUBAf8EDDAKBggrBgEFBQcD
# CDAOBgNVHQ8BAf8EBAMCB4AwDQYJKoZIhvcNAQELBQADggIBANjnN5JqpeVShIrQ
# IaAQnNVOv1cDEmCkD6oQufX9NGOX28Jw/gdkGtMJyagA0lVbumwQla5LPhBm5LjI
# UW/5aYhzSlZ7lxeDykw57wp2AqoMAJm7bXcXtJt/HyaRlN35hAhBV+DmGnBIRcE5
# C2bSFFY3asD50KUSCPmKl/0NFadPeoNqbj5ZUna8VAfMSDsdxeyxjs8r/9Vpqy8l
# gIVBqRrXtFt6n1+GFpJ+2AjPspfPO7Y+Y/ozv5dTEYum5eDLDdD1thQmHkW8s0BB
# DbIOT3d+dWdPETkf50fM/nALkMEdvYo2gyiJrOSG0a9Z2S/6mbJBUrgrkgPp2HjL
# kycR4Nhwl67ehAhWxJGKD2gRk88T2KKXLiRHAoYTZVpHbgkYLspBLJs9C77ZkuxX
# uvIOGaId7EJCBOVRMJygtx8FXpoSu3jWEdau0WBMXxhVAzEHTu7UKW3Dw+KGgW7R
# Rlhrt589SK8lrPSvPM6PPnqEFf6PUsTVO0bOkzKnC3TOgui4JhlWliigtEtg1SlP
# MxcdMuc9uYdWSe1/2YWmr9ZrV1RuvpSSKvJLSYDlOf6aJrpnX7YKLMRoyKdzTkcv
# Xw1JZfikJeGJjfRs2cT2JIbiNEGK4i5srQbVCvgCvdYVEVZXVW1Iz/LJLK9XbIkM
# MjmECJEsa07oadKcO4ed9vY6YYBGMIIHcTCCBVmgAwIBAgITMwAAABXF52ueAptJ
# mQAAAAAAFTANBgkqhkiG9w0BAQsFADCBiDELMAkGA1UEBhMCVVMxEzARBgNVBAgT
# Cldhc2hpbmd0b24xEDAOBgNVBAcTB1JlZG1vbmQxHjAcBgNVBAoTFU1pY3Jvc29m
# dCBDb3Jwb3JhdGlvbjEyMDAGA1UEAxMpTWljcm9zb2Z0IFJvb3QgQ2VydGlmaWNh
# dGUgQXV0aG9yaXR5IDIwMTAwHhcNMjEwOTMwMTgyMjI1WhcNMzAwOTMwMTgzMjI1
# WjB8MQswCQYDVQQGEwJVUzETMBEGA1UECBMKV2FzaGluZ3RvbjEQMA4GA1UEBxMH
# UmVkbW9uZDEeMBwGA1UEChMVTWljcm9zb2Z0IENvcnBvcmF0aW9uMSYwJAYDVQQD
# Ex1NaWNyb3NvZnQgVGltZS1TdGFtcCBQQ0EgMjAxMDCCAiIwDQYJKoZIhvcNAQEB
# BQADggIPADCCAgoCggIBAOThpkzntHIhC3miy9ckeb0O1YLT/e6cBwfSqWxOdcjK
# NVf2AX9sSuDivbk+F2Az/1xPx2b3lVNxWuJ+Slr+uDZnhUYjDLWNE893MsAQGOhg
# fWpSg0S3po5GawcU88V29YZQ3MFEyHFcUTE3oAo4bo3t1w/YJlN8OWECesSq/XJp
# rx2rrPY2vjUmZNqYO7oaezOtgFt+jBAcnVL+tuhiJdxqD89d9P6OU8/W7IVWTe/d
# vI2k45GPsjksUZzpcGkNyjYtcI4xyDUoveO0hyTD4MmPfrVUj9z6BVWYbWg7mka9
# 7aSueik3rMvrg0XnRm7KMtXAhjBcTyziYrLNueKNiOSWrAFKu75xqRdbZ2De+JKR
# Hh09/SDPc31BmkZ1zcRfNN0Sidb9pSB9fvzZnkXftnIv231fgLrbqn427DZM9itu
# qBJR6L8FA6PRc6ZNN3SUHDSCD/AQ8rdHGO2n6Jl8P0zbr17C89XYcz1DTsEzOUyO
# ArxCaC4Q6oRRRuLRvWoYWmEBc8pnol7XKHYC4jMYctenIPDC+hIK12NvDMk2ZItb
# oKaDIV1fMHSRlJTYuVD5C4lh8zYGNRiER9vcG9H9stQcxWv2XFJRXRLbJbqvUAV6
# bMURHXLvjflSxIUXk8A8FdsaN8cIFRg/eKtFtvUeh17aj54WcmnGrnu3tz5q4i6t
# AgMBAAGjggHdMIIB2TASBgkrBgEEAYI3FQEEBQIDAQABMCMGCSsGAQQBgjcVAgQW
# BBQqp1L+ZMSavoKRPEY1Kc8Q/y8E7jAdBgNVHQ4EFgQUn6cVXQBeYl2D9OXSZacb
# UzUZ6XIwXAYDVR0gBFUwUzBRBgwrBgEEAYI3TIN9AQEwQTA/BggrBgEFBQcCARYz
# aHR0cDovL3d3dy5taWNyb3NvZnQuY29tL3BraW9wcy9Eb2NzL1JlcG9zaXRvcnku
# aHRtMBMGA1UdJQQMMAoGCCsGAQUFBwMIMBkGCSsGAQQBgjcUAgQMHgoAUwB1AGIA
# QwBBMAsGA1UdDwQEAwIBhjAPBgNVHRMBAf8EBTADAQH/MB8GA1UdIwQYMBaAFNX2
# VsuP6KJcYmjRPZSQW9fOmhjEMFYGA1UdHwRPME0wS6BJoEeGRWh0dHA6Ly9jcmwu
# bWljcm9zb2Z0LmNvbS9wa2kvY3JsL3Byb2R1Y3RzL01pY1Jvb0NlckF1dF8yMDEw
# LTA2LTIzLmNybDBaBggrBgEFBQcBAQROMEwwSgYIKwYBBQUHMAKGPmh0dHA6Ly93
# d3cubWljcm9zb2Z0LmNvbS9wa2kvY2VydHMvTWljUm9vQ2VyQXV0XzIwMTAtMDYt
# MjMuY3J0MA0GCSqGSIb3DQEBCwUAA4ICAQCdVX38Kq3hLB9nATEkW+Geckv8qW/q
# XBS2Pk5HZHixBpOXPTEztTnXwnE2P9pkbHzQdTltuw8x5MKP+2zRoZQYIu7pZmc6
# U03dmLq2HnjYNi6cqYJWAAOwBb6J6Gngugnue99qb74py27YP0h1AdkY3m2CDPVt
# I1TkeFN1JFe53Z/zjj3G82jfZfakVqr3lbYoVSfQJL1AoL8ZthISEV09J+BAljis
# 9/kpicO8F7BUhUKz/AyeixmJ5/ALaoHCgRlCGVJ1ijbCHcNhcy4sa3tuPywJeBTp
# kbKpW99Jo3QMvOyRgNI95ko+ZjtPu4b6MhrZlvSP9pEB9s7GdP32THJvEKt1MMU0
# sHrYUP4KWN1APMdUbZ1jdEgssU5HLcEUBHG/ZPkkvnNtyo4JvbMBV0lUZNlz138e
# W0QBjloZkWsNn6Qo3GcZKCS6OEuabvshVGtqRRFHqfG3rsjoiV5PndLQTHa1V1QJ
# sWkBRH58oWFsc/4Ku+xBZj1p/cvBQUl+fpO+y/g75LcVv7TOPqUxUYS8vwLBgqJ7
# Fx0ViY1w/ue10CgaiQuPNtq6TPmb/wrpNPgkNWcr4A245oyZ1uEi6vAnQj0llOZ0
# dFtq0Z4+7X6gMTN9vMvpe784cETRkPHIqzqKOghif9lwY1NNje6CbaUFEMFxBmoQ
# tB1VM1izoXBm8qGCAtQwggI9AgEBMIIBAKGB2KSB1TCB0jELMAkGA1UEBhMCVVMx
# EzARBgNVBAgTCldhc2hpbmd0b24xEDAOBgNVBAcTB1JlZG1vbmQxHjAcBgNVBAoT
# FU1pY3Jvc29mdCBDb3Jwb3JhdGlvbjEtMCsGA1UECxMkTWljcm9zb2Z0IElyZWxh
# bmQgT3BlcmF0aW9ucyBMaW1pdGVkMSYwJAYDVQQLEx1UaGFsZXMgVFNTIEVTTjoy
# QUQ0LTRCOTItRkEwMTElMCMGA1UEAxMcTWljcm9zb2Z0IFRpbWUtU3RhbXAgU2Vy
# dmljZaIjCgEBMAcGBSsOAwIaAxUA7WSxvqQDbA7vyy69Tn0wP5BGxyuggYMwgYCk
# fjB8MQswCQYDVQQGEwJVUzETMBEGA1UECBMKV2FzaGluZ3RvbjEQMA4GA1UEBxMH
# UmVkbW9uZDEeMBwGA1UEChMVTWljcm9zb2Z0IENvcnBvcmF0aW9uMSYwJAYDVQQD
# Ex1NaWNyb3NvZnQgVGltZS1TdGFtcCBQQ0EgMjAxMDANBgkqhkiG9w0BAQUFAAIF
# AOhHRZ8wIhgPMjAyMzA2MjkwNzQ5NTFaGA8yMDIzMDYzMDA3NDk1MVowdDA6Bgor
# BgEEAYRZCgQBMSwwKjAKAgUA6EdFnwIBADAHAgEAAgIVZDAHAgEAAgI+iTAKAgUA
# 6EiXHwIBADA2BgorBgEEAYRZCgQCMSgwJjAMBgorBgEEAYRZCgMCoAowCAIBAAID
# B6EgoQowCAIBAAIDAYagMA0GCSqGSIb3DQEBBQUAA4GBAFNXjWIsWInafIvVnm4O
# AeQpp8awRZSYrGy/WBjxt8kRmhrmti7Q5jm1RjiZThfxdss69Sw6GIgxNgAgIdaR
# 85O7jjIZD26l9yDRY9j1Tk1JOnCaI6Jh2W6x1Lk+3Q6wa+4pW/OukRwGWsHKJLtS
# Fx07qvieNBj/UXThKHTTo1LdMYIEDTCCBAkCAQEwgZMwfDELMAkGA1UEBhMCVVMx
# EzARBgNVBAgTCldhc2hpbmd0b24xEDAOBgNVBAcTB1JlZG1vbmQxHjAcBgNVBAoT
# FU1pY3Jvc29mdCBDb3Jwb3JhdGlvbjEmMCQGA1UEAxMdTWljcm9zb2Z0IFRpbWUt
# U3RhbXAgUENBIDIwMTACEzMAAAGxypBD7gvwA6sAAQAAAbEwDQYJYIZIAWUDBAIB
# BQCgggFKMBoGCSqGSIb3DQEJAzENBgsqhkiG9w0BCRABBDAvBgkqhkiG9w0BCQQx
# IgQgXVSDpaYr6wBq0Ae7IaJyk7ogUVuEAE+ziz++RSRPZZcwgfoGCyqGSIb3DQEJ
# EAIvMYHqMIHnMIHkMIG9BCCD7Q2LFFvfqeDoy9gpu35t6dYerrDO0cMTlOIomzTP
# bDCBmDCBgKR+MHwxCzAJBgNVBAYTAlVTMRMwEQYDVQQIEwpXYXNoaW5ndG9uMRAw
# DgYDVQQHEwdSZWRtb25kMR4wHAYDVQQKExVNaWNyb3NvZnQgQ29ycG9yYXRpb24x
# JjAkBgNVBAMTHU1pY3Jvc29mdCBUaW1lLVN0YW1wIFBDQSAyMDEwAhMzAAABscqQ
# Q+4L8AOrAAEAAAGxMCIEIHku8I/ovzi/D/lWOvu1XECs7ypvVTmWFPWfF4qx3D7r
# MA0GCSqGSIb3DQEBCwUABIICACJXULm25cKfZk67AXBYYEAS9cwJv/boOV7KmRRm
# qdC2yGwWqzguo9bKLqrc/bXZuzPd//NBsshxD5+xn638NAXQvs4zGpG89RzOWFJY
# /ER8+dEOo1DVKNgxsryZmsEIihcLodzvp41/dWVEpdo/WJyuTHROs4HtjvmX45EG
# 9DSjlOQtb6Db6wldWEKAf8Yf0YysxlhfQ5GpEuZqaEy2BNNwIAoh/kORIv8/6o8b
# d4eFzbvpjozaNmDcIKuOd1DfgvzbRwBCQ7E5jMMIrXVYU6UeGWS/uPXcGzDHKXhT
# Q5iUk8/0zvEvGf/AzYIPaM1uh+tg58uz2+Yevh1E1LqYyeSiOUG+fETDTT9I+5ja
# Q6UCn+QgUiO6AoifIHvUUnYg9qafpPwSN/xF/GxEzAUE/nagC2eyf40Ip65NzYim
# 8HNtCwDMVZdiQ9F2wXbuaZON5Rd3iaK+RoH04hE3W3M6tLCwV76cENzhJpljB9Mw
# bVxuKqxjQ9TZcNd5makYv+51qC8tJsNpNc3lLPRRmdQrU7I6qId3nKRcBQaYPXcM
# 0RXe1KRm7tQp87cX06PXpJQrABc2ojO/h8dWUTpoDI+jQzsRGVVXuUNAQHVpp01x
# P+iowvdg2dT7YmXgCEHvHkLJWxnpavm7p0o5/Ztu+2u0k0iKVvOzveSNk7NmE1Rc
# 3WIy
# SIG # End signature block
