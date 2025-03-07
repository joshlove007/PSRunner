#
# Module manifest for module 'Microsoft.Graph.Identity.DirectoryManagement'
#
# Generated by: Microsoft Corporation
#
# Generated on: 8/10/2023
#

@{

# Script module or binary module file associated with this manifest.
RootModule = './Microsoft.Graph.Identity.DirectoryManagement.psm1'

# Version number of this module.
ModuleVersion = '2.3.0'

# Supported PSEditions
CompatiblePSEditions = 'Core', 'Desktop'

# ID used to uniquely identify this module
GUID = 'c767240d-585c-42cb-bb2f-6e76e6d639d4'

# Author of this module
Author = 'Microsoft Corporation'

# Company or vendor of this module
CompanyName = 'Microsoft Corporation'

# Copyright statement for this module
Copyright = 'Microsoft Corporation. All rights reserved.'

# Description of the functionality provided by this module
Description = 'Microsoft Graph PowerShell Cmdlets'

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
RequiredModules = @(@{ModuleName = 'Microsoft.Graph.Authentication'; RequiredVersion = '2.3.0'; })

# Assemblies that must be loaded prior to importing this module
RequiredAssemblies = './bin/Microsoft.Graph.Identity.DirectoryManagement.private.dll'

# Script files (.ps1) that are run in the caller's environment prior to importing this module.
# ScriptsToProcess = @()

# Type files (.ps1xml) to be loaded when importing this module
# TypesToProcess = @()

# Format files (.ps1xml) to be loaded when importing this module
FormatsToProcess = './Microsoft.Graph.Identity.DirectoryManagement.format.ps1xml'

# Modules to import as nested modules of the module specified in RootModule/ModuleToProcess
# NestedModules = @()

# Functions to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no functions to export.
FunctionsToExport = 'Confirm-MgContactMemberGroup', 'Confirm-MgContactMemberObject', 
               'Confirm-MgContractMemberGroup', 'Confirm-MgContractMemberObject', 
               'Confirm-MgDeviceMemberGroup', 'Confirm-MgDeviceMemberObject', 
               'Confirm-MgDirectoryDeletedItemMemberGroup', 
               'Confirm-MgDirectoryDeletedItemMemberObject', 
               'Confirm-MgDirectoryRoleMemberGroup', 
               'Confirm-MgDirectoryRoleMemberObject', 
               'Confirm-MgDirectoryRoleTemplateMemberGroup', 
               'Confirm-MgDirectoryRoleTemplateMemberObject', 'Confirm-MgDomain', 
               'Confirm-MgOrganizationMemberGroup', 
               'Confirm-MgOrganizationMemberObject', 'Get-MgContact', 
               'Get-MgContactById', 'Get-MgContactCount', 'Get-MgContactDelta', 
               'Get-MgContactDirectReport', 
               'Get-MgContactDirectReportAsOrgContact', 
               'Get-MgContactDirectReportAsUser', 'Get-MgContactDirectReportCount', 
               'Get-MgContactDirectReportCountAsOrgContact', 
               'Get-MgContactDirectReportCountAsUser', 'Get-MgContactManager', 
               'Get-MgContactMemberGroup', 'Get-MgContactMemberObject', 
               'Get-MgContactMemberOf', 
               'Get-MgContactMemberOfAsAdministrativeUnit', 
               'Get-MgContactMemberOfAsGroup', 'Get-MgContactMemberOfCount', 
               'Get-MgContactMemberOfCountAsAdministrativeUnit', 
               'Get-MgContactMemberOfCountAsGroup', 
               'Get-MgContactTransitiveMemberOf', 
               'Get-MgContactTransitiveMemberOfAsAdministrativeUnit', 
               'Get-MgContactTransitiveMemberOfAsGroup', 
               'Get-MgContactTransitiveMemberOfCount', 
               'Get-MgContactTransitiveMemberOfCountAsAdministrativeUnit', 
               'Get-MgContactTransitiveMemberOfCountAsGroup', 'Get-MgContract', 
               'Get-MgContractById', 'Get-MgContractCount', 'Get-MgContractDelta', 
               'Get-MgContractMemberGroup', 'Get-MgContractMemberObject', 
               'Get-MgDevice', 'Get-MgDeviceByDeviceId', 'Get-MgDeviceById', 
               'Get-MgDeviceCount', 'Get-MgDeviceDelta', 'Get-MgDeviceExtension', 
               'Get-MgDeviceExtensionCount', 'Get-MgDeviceMemberGroup', 
               'Get-MgDeviceMemberObject', 'Get-MgDeviceMemberOf', 
               'Get-MgDeviceMemberOfAsAdministrativeUnit', 
               'Get-MgDeviceMemberOfAsGroup', 'Get-MgDeviceMemberOfCount', 
               'Get-MgDeviceMemberOfCountAsAdministrativeUnit', 
               'Get-MgDeviceMemberOfCountAsGroup', 'Get-MgDeviceRegisteredOwner', 
               'Get-MgDeviceRegisteredOwnerAsAppRoleAssignment', 
               'Get-MgDeviceRegisteredOwnerAsEndpoint', 
               'Get-MgDeviceRegisteredOwnerAsServicePrincipal', 
               'Get-MgDeviceRegisteredOwnerAsUser', 
               'Get-MgDeviceRegisteredOwnerByRef', 
               'Get-MgDeviceRegisteredOwnerCount', 
               'Get-MgDeviceRegisteredOwnerCountAsAppRoleAssignment', 
               'Get-MgDeviceRegisteredOwnerCountAsEndpoint', 
               'Get-MgDeviceRegisteredOwnerCountAsServicePrincipal', 
               'Get-MgDeviceRegisteredOwnerCountAsUser', 
               'Get-MgDeviceRegisteredUser', 
               'Get-MgDeviceRegisteredUserAsAppRoleAssignment', 
               'Get-MgDeviceRegisteredUserAsEndpoint', 
               'Get-MgDeviceRegisteredUserAsServicePrincipal', 
               'Get-MgDeviceRegisteredUserAsUser', 
               'Get-MgDeviceRegisteredUserByRef', 
               'Get-MgDeviceRegisteredUserCount', 
               'Get-MgDeviceRegisteredUserCountAsAppRoleAssignment', 
               'Get-MgDeviceRegisteredUserCountAsEndpoint', 
               'Get-MgDeviceRegisteredUserCountAsServicePrincipal', 
               'Get-MgDeviceRegisteredUserCountAsUser', 
               'Get-MgDeviceTransitiveMemberOf', 
               'Get-MgDeviceTransitiveMemberOfAsAdministrativeUnit', 
               'Get-MgDeviceTransitiveMemberOfAsGroup', 
               'Get-MgDeviceTransitiveMemberOfCount', 
               'Get-MgDeviceTransitiveMemberOfCountAsAdministrativeUnit', 
               'Get-MgDeviceTransitiveMemberOfCountAsGroup', 'Get-MgDirectory', 
               'Get-MgDirectoryAdministrativeUnit', 
               'Get-MgDirectoryAdministrativeUnitCount', 
               'Get-MgDirectoryAdministrativeUnitDelta', 
               'Get-MgDirectoryAdministrativeUnitExtension', 
               'Get-MgDirectoryAdministrativeUnitExtensionCount', 
               'Get-MgDirectoryAdministrativeUnitMember', 
               'Get-MgDirectoryAdministrativeUnitMemberAsApplication', 
               'Get-MgDirectoryAdministrativeUnitMemberAsDevice', 
               'Get-MgDirectoryAdministrativeUnitMemberAsGroup', 
               'Get-MgDirectoryAdministrativeUnitMemberAsOrgContact', 
               'Get-MgDirectoryAdministrativeUnitMemberAsServicePrincipal', 
               'Get-MgDirectoryAdministrativeUnitMemberAsUser', 
               'Get-MgDirectoryAdministrativeUnitMemberByRef', 
               'Get-MgDirectoryAdministrativeUnitMemberCount', 
               'Get-MgDirectoryAdministrativeUnitMemberCountAsApplication', 
               'Get-MgDirectoryAdministrativeUnitMemberCountAsDevice', 
               'Get-MgDirectoryAdministrativeUnitMemberCountAsGroup', 
               'Get-MgDirectoryAdministrativeUnitMemberCountAsOrgContact', 
               'Get-MgDirectoryAdministrativeUnitMemberCountAsServicePrincipal', 
               'Get-MgDirectoryAdministrativeUnitMemberCountAsUser', 
               'Get-MgDirectoryAdministrativeUnitScopedRoleMember', 
               'Get-MgDirectoryAdministrativeUnitScopedRoleMemberCount', 
               'Get-MgDirectoryAttributeSet', 'Get-MgDirectoryAttributeSetCount', 
               'Get-MgDirectoryCustomSecurityAttributeDefinition', 
               'Get-MgDirectoryCustomSecurityAttributeDefinitionAllowedValue', 
               'Get-MgDirectoryCustomSecurityAttributeDefinitionAllowedValueCount', 
               'Get-MgDirectoryCustomSecurityAttributeDefinitionCount', 
               'Get-MgDirectoryDeletedItem', 
               'Get-MgDirectoryDeletedItemAsAdministrativeUnit', 
               'Get-MgDirectoryDeletedItemAsApplication', 
               'Get-MgDirectoryDeletedItemAsDevice', 
               'Get-MgDirectoryDeletedItemAsGroup', 
               'Get-MgDirectoryDeletedItemAsServicePrincipal', 
               'Get-MgDirectoryDeletedItemAsUser', 
               'Get-MgDirectoryDeletedItemById', 
               'Get-MgDirectoryDeletedItemCountAsAdministrativeUnit', 
               'Get-MgDirectoryDeletedItemCountAsApplication', 
               'Get-MgDirectoryDeletedItemCountAsDevice', 
               'Get-MgDirectoryDeletedItemCountAsGroup', 
               'Get-MgDirectoryDeletedItemCountAsServicePrincipal', 
               'Get-MgDirectoryDeletedItemCountAsUser', 
               'Get-MgDirectoryDeletedItemMemberGroup', 
               'Get-MgDirectoryDeletedItemMemberObject', 
               'Get-MgDirectoryFederationConfiguration', 
               'Get-MgDirectoryFederationConfigurationCount', 
               'Get-MgDirectoryOnPremiseSynchronization', 
               'Get-MgDirectoryOnPremiseSynchronizationCount', 
               'Get-MgDirectoryRole', 'Get-MgDirectoryRoleById', 
               'Get-MgDirectoryRoleByRoleTemplateId', 'Get-MgDirectoryRoleCount', 
               'Get-MgDirectoryRoleDelta', 'Get-MgDirectoryRoleMember', 
               'Get-MgDirectoryRoleMemberAsApplication', 
               'Get-MgDirectoryRoleMemberAsDevice', 
               'Get-MgDirectoryRoleMemberAsGroup', 
               'Get-MgDirectoryRoleMemberAsOrgContact', 
               'Get-MgDirectoryRoleMemberAsServicePrincipal', 
               'Get-MgDirectoryRoleMemberAsUser', 'Get-MgDirectoryRoleMemberByRef', 
               'Get-MgDirectoryRoleMemberCount', 
               'Get-MgDirectoryRoleMemberCountAsApplication', 
               'Get-MgDirectoryRoleMemberCountAsDevice', 
               'Get-MgDirectoryRoleMemberCountAsGroup', 
               'Get-MgDirectoryRoleMemberCountAsOrgContact', 
               'Get-MgDirectoryRoleMemberCountAsServicePrincipal', 
               'Get-MgDirectoryRoleMemberCountAsUser', 
               'Get-MgDirectoryRoleMemberGroup', 'Get-MgDirectoryRoleMemberObject', 
               'Get-MgDirectoryRoleScopedMember', 
               'Get-MgDirectoryRoleScopedMemberCount', 
               'Get-MgDirectoryRoleTemplate', 'Get-MgDirectoryRoleTemplateById', 
               'Get-MgDirectoryRoleTemplateCount', 
               'Get-MgDirectoryRoleTemplateDelta', 
               'Get-MgDirectoryRoleTemplateMemberGroup', 
               'Get-MgDirectoryRoleTemplateMemberObject', 'Get-MgDomain', 
               'Get-MgDomainCount', 'Get-MgDomainFederationConfiguration', 
               'Get-MgDomainFederationConfigurationCount', 
               'Get-MgDomainNameReference', 'Get-MgDomainNameReferenceCount', 
               'Get-MgDomainServiceConfigurationRecord', 
               'Get-MgDomainServiceConfigurationRecordCount', 
               'Get-MgDomainVerificationDnsRecord', 
               'Get-MgDomainVerificationDnsRecordCount', 'Get-MgOrganization', 
               'Get-MgOrganizationBranding', 
               'Get-MgOrganizationBrandingBackgroundImage', 
               'Get-MgOrganizationBrandingBannerLogo', 
               'Get-MgOrganizationBrandingCustomCss', 
               'Get-MgOrganizationBrandingFavicon', 
               'Get-MgOrganizationBrandingHeaderLogo', 
               'Get-MgOrganizationBrandingLocalization', 
               'Get-MgOrganizationBrandingLocalizationBackgroundImage', 
               'Get-MgOrganizationBrandingLocalizationBannerLogo', 
               'Get-MgOrganizationBrandingLocalizationCount', 
               'Get-MgOrganizationBrandingLocalizationCustomCss', 
               'Get-MgOrganizationBrandingLocalizationFavicon', 
               'Get-MgOrganizationBrandingLocalizationHeaderLogo', 
               'Get-MgOrganizationBrandingLocalizationSquareLogo', 
               'Get-MgOrganizationBrandingLocalizationSquareLogoDark', 
               'Get-MgOrganizationBrandingSquareLogo', 
               'Get-MgOrganizationBrandingSquareLogoDark', 
               'Get-MgOrganizationById', 'Get-MgOrganizationCount', 
               'Get-MgOrganizationExtension', 'Get-MgOrganizationExtensionCount', 
               'Get-MgOrganizationMemberGroup', 'Get-MgOrganizationMemberObject', 
               'Get-MgSubscribedSku', 'Get-MgUserScopedRoleMemberOf', 
               'Get-MgUserScopedRoleMemberOfCount', 
               'Invoke-MgAvailableDirectoryFederationConfigurationProviderType', 
               'Invoke-MgForceDomainDelete', 'Invoke-MgPromoteDomain', 
               'New-MgContact', 'New-MgContract', 'New-MgDevice', 
               'New-MgDeviceExtension', 'New-MgDeviceRegisteredOwnerByRef', 
               'New-MgDeviceRegisteredUserByRef', 
               'New-MgDirectoryAdministrativeUnit', 
               'New-MgDirectoryAdministrativeUnitExtension', 
               'New-MgDirectoryAdministrativeUnitMember', 
               'New-MgDirectoryAdministrativeUnitMemberByRef', 
               'New-MgDirectoryAdministrativeUnitScopedRoleMember', 
               'New-MgDirectoryAttributeSet', 
               'New-MgDirectoryCustomSecurityAttributeDefinition', 
               'New-MgDirectoryCustomSecurityAttributeDefinitionAllowedValue', 
               'New-MgDirectoryDeletedItem', 
               'New-MgDirectoryFederationConfiguration', 
               'New-MgDirectoryOnPremiseSynchronization', 'New-MgDirectoryRole', 
               'New-MgDirectoryRoleMemberByRef', 'New-MgDirectoryRoleScopedMember', 
               'New-MgDirectoryRoleTemplate', 'New-MgDomain', 
               'New-MgDomainFederationConfiguration', 
               'New-MgDomainServiceConfigurationRecord', 
               'New-MgDomainVerificationDnsRecord', 'New-MgOrganization', 
               'New-MgOrganizationBrandingLocalization', 
               'New-MgOrganizationExtension', 'New-MgSubscribedSku', 
               'New-MgUserScopedRoleMemberOf', 'Remove-MgContact', 
               'Remove-MgContract', 'Remove-MgDevice', 'Remove-MgDeviceByDeviceId', 
               'Remove-MgDeviceExtension', 'Remove-MgDeviceRegisteredOwnerByRef', 
               'Remove-MgDeviceRegisteredUserByRef', 
               'Remove-MgDirectoryAdministrativeUnit', 
               'Remove-MgDirectoryAdministrativeUnitExtension', 
               'Remove-MgDirectoryAdministrativeUnitMemberByRef', 
               'Remove-MgDirectoryAdministrativeUnitScopedRoleMember', 
               'Remove-MgDirectoryAttributeSet', 
               'Remove-MgDirectoryCustomSecurityAttributeDefinition', 
               'Remove-MgDirectoryCustomSecurityAttributeDefinitionAllowedValue', 
               'Remove-MgDirectoryDeletedItem', 
               'Remove-MgDirectoryFederationConfiguration', 
               'Remove-MgDirectoryOnPremiseSynchronization', 
               'Remove-MgDirectoryRole', 'Remove-MgDirectoryRoleByRoleTemplateId', 
               'Remove-MgDirectoryRoleMemberByRef', 
               'Remove-MgDirectoryRoleScopedMember', 
               'Remove-MgDirectoryRoleTemplate', 'Remove-MgDomain', 
               'Remove-MgDomainFederationConfiguration', 
               'Remove-MgDomainServiceConfigurationRecord', 
               'Remove-MgDomainVerificationDnsRecord', 'Remove-MgOrganization', 
               'Remove-MgOrganizationBranding', 
               'Remove-MgOrganizationBrandingLocalization', 
               'Remove-MgOrganizationExtension', 'Remove-MgSubscribedSku', 
               'Remove-MgUserScopedRoleMemberOf', 'Restore-MgDirectoryDeletedItem', 
               'Set-MgOrganizationBrandingBackgroundImage', 
               'Set-MgOrganizationBrandingBannerLogo', 
               'Set-MgOrganizationBrandingCustomCss', 
               'Set-MgOrganizationBrandingFavicon', 
               'Set-MgOrganizationBrandingHeaderLogo', 
               'Set-MgOrganizationBrandingLocalizationBackgroundImage', 
               'Set-MgOrganizationBrandingLocalizationBannerLogo', 
               'Set-MgOrganizationBrandingLocalizationCustomCss', 
               'Set-MgOrganizationBrandingLocalizationFavicon', 
               'Set-MgOrganizationBrandingLocalizationHeaderLogo', 
               'Set-MgOrganizationBrandingLocalizationSquareLogo', 
               'Set-MgOrganizationBrandingLocalizationSquareLogoDark', 
               'Set-MgOrganizationBrandingSquareLogo', 
               'Set-MgOrganizationBrandingSquareLogoDark', 
               'Set-MgOrganizationMobileDeviceManagementAuthority', 
               'Test-MgContactProperty', 'Test-MgContractProperty', 
               'Test-MgDeviceProperty', 'Test-MgDirectoryDeletedItemProperty', 
               'Test-MgDirectoryRoleProperty', 
               'Test-MgDirectoryRoleTemplateProperty', 
               'Test-MgOrganizationProperty', 'Update-MgContact', 
               'Update-MgContract', 'Update-MgDevice', 'Update-MgDeviceByDeviceId', 
               'Update-MgDeviceExtension', 'Update-MgDirectory', 
               'Update-MgDirectoryAdministrativeUnit', 
               'Update-MgDirectoryAdministrativeUnitExtension', 
               'Update-MgDirectoryAdministrativeUnitScopedRoleMember', 
               'Update-MgDirectoryAttributeSet', 
               'Update-MgDirectoryCustomSecurityAttributeDefinition', 
               'Update-MgDirectoryCustomSecurityAttributeDefinitionAllowedValue', 
               'Update-MgDirectoryDeletedItem', 
               'Update-MgDirectoryFederationConfiguration', 
               'Update-MgDirectoryOnPremiseSynchronization', 
               'Update-MgDirectoryRole', 'Update-MgDirectoryRoleByRoleTemplateId', 
               'Update-MgDirectoryRoleScopedMember', 
               'Update-MgDirectoryRoleTemplate', 'Update-MgDomain', 
               'Update-MgDomainFederationConfiguration', 
               'Update-MgDomainServiceConfigurationRecord', 
               'Update-MgDomainVerificationDnsRecord', 'Update-MgOrganization', 
               'Update-MgOrganizationBranding', 
               'Update-MgOrganizationBrandingLocalization', 
               'Update-MgOrganizationExtension', 'Update-MgSubscribedSku', 
               'Update-MgUserScopedRoleMemberOf'

# Cmdlets to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no cmdlets to export.
CmdletsToExport = @()

# Variables to export from this module
# VariablesToExport = @()

# Aliases to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no aliases to export.
AliasesToExport = 'Get-MgDirectoryDeletedAdministrativeUnit', 
               'Get-MgDirectoryDeletedApplication', 'Get-MgDirectoryDeletedDevice', 
               'Get-MgDirectoryDeletedGroup', 
               'Get-MgDirectoryDeletedServicePrincipal', 
               'Get-MgDirectoryDeletedUser'

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
        Tags = 'Microsoft','Office365','Graph','PowerShell','PSModule','PSIncludes_Cmdlet'

        # A URL to the license for this module.
        LicenseUri = 'https://aka.ms/devservicesagreement'

        # A URL to the main website for this project.
        ProjectUri = 'https://github.com/microsoftgraph/msgraph-sdk-powershell'

        # A URL to an icon representing this module.
        IconUri = 'https://raw.githubusercontent.com/microsoftgraph/msgraph-sdk-powershell/features/2.0/docs/images/graph_color256.png'

        # ReleaseNotes of this module
        ReleaseNotes = 'See https://aka.ms/GraphPowerShell-Release.'

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
# MIInvgYJKoZIhvcNAQcCoIInrzCCJ6sCAQExDzANBglghkgBZQMEAgEFADB5Bgor
# BgEEAYI3AgEEoGswaTA0BgorBgEEAYI3AgEeMCYCAwEAAAQQH8w7YFlLCE63JNLG
# KX7zUQIBAAIBAAIBAAIBAAIBADAxMA0GCWCGSAFlAwQCAQUABCBTVwIgSKcNmJA1
# 0vtFrLS6oPTtAOoYExNNIEW+c8bNTqCCDXYwggX0MIID3KADAgECAhMzAAADTrU8
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
# /Xmfwb1tbWrJUnMTDXpQzTGCGZ4wghmaAgEBMIGVMH4xCzAJBgNVBAYTAlVTMRMw
# EQYDVQQIEwpXYXNoaW5ndG9uMRAwDgYDVQQHEwdSZWRtb25kMR4wHAYDVQQKExVN
# aWNyb3NvZnQgQ29ycG9yYXRpb24xKDAmBgNVBAMTH01pY3Jvc29mdCBDb2RlIFNp
# Z25pbmcgUENBIDIwMTECEzMAAANOtTx6wYRv6ysAAAAAA04wDQYJYIZIAWUDBAIB
# BQCgga4wGQYJKoZIhvcNAQkDMQwGCisGAQQBgjcCAQQwHAYKKwYBBAGCNwIBCzEO
# MAwGCisGAQQBgjcCARUwLwYJKoZIhvcNAQkEMSIEIDcJVwUJtu1biw3ALOmptzz/
# XebHMOo3FN1j3ds+PFJ1MEIGCisGAQQBgjcCAQwxNDAyoBSAEgBNAGkAYwByAG8A
# cwBvAGYAdKEagBhodHRwOi8vd3d3Lm1pY3Jvc29mdC5jb20wDQYJKoZIhvcNAQEB
# BQAEggEArtMRYwR/6p4Me+4s15bOc60K21J4TjFah22f1Ca8FCdFYmVVuvk42tDN
# 99k7lHZ76A0Wm3DTYSmltiuwi8L2cm8Ks1kYC7jJMsOFhBUlCLTjACqe0+BJHUTP
# COZOd1h+C6DBe3dBdgeKldzh+eJ77pZ8Q8e1wWfIKBXt7pnTjhkGgBV2ENSH3fyu
# iw4QpEF+2Dvx0W70ymO5HM199Ckc3FzdM8orpSJ/SILQqYg2lSGB9SSh7aJoEFXE
# FvupctEctjkSN97bCH9AngFHCemanJjFYaRGgrlCval96uLIz2b35MQ0SBFbrK7X
# VGZfwqQ3SXvEuiZrkUVP6Uq8IhtBtKGCFygwghckBgorBgEEAYI3AwMBMYIXFDCC
# FxAGCSqGSIb3DQEHAqCCFwEwghb9AgEDMQ8wDQYJYIZIAWUDBAIBBQAwggFYBgsq
# hkiG9w0BCRABBKCCAUcEggFDMIIBPwIBAQYKKwYBBAGEWQoDATAxMA0GCWCGSAFl
# AwQCAQUABCA2XDNQ630H7Lnz36xwhYeZAkQEaXlGKKtRcjntPyFWsgIGZMmLvtEX
# GBIyMDIzMDgxMDE5MzM1OC42NVowBIACAfSggdikgdUwgdIxCzAJBgNVBAYTAlVT
# MRMwEQYDVQQIEwpXYXNoaW5ndG9uMRAwDgYDVQQHEwdSZWRtb25kMR4wHAYDVQQK
# ExVNaWNyb3NvZnQgQ29ycG9yYXRpb24xLTArBgNVBAsTJE1pY3Jvc29mdCBJcmVs
# YW5kIE9wZXJhdGlvbnMgTGltaXRlZDEmMCQGA1UECxMdVGhhbGVzIFRTUyBFU046
# OEQ0MS00QkY3LUIzQjcxJTAjBgNVBAMTHE1pY3Jvc29mdCBUaW1lLVN0YW1wIFNl
# cnZpY2WgghF4MIIHJzCCBQ+gAwIBAgITMwAAAbP+Jc4pGxuKHAABAAABszANBgkq
# hkiG9w0BAQsFADB8MQswCQYDVQQGEwJVUzETMBEGA1UECBMKV2FzaGluZ3RvbjEQ
# MA4GA1UEBxMHUmVkbW9uZDEeMBwGA1UEChMVTWljcm9zb2Z0IENvcnBvcmF0aW9u
# MSYwJAYDVQQDEx1NaWNyb3NvZnQgVGltZS1TdGFtcCBQQ0EgMjAxMDAeFw0yMjA5
# MjAyMDIyMDNaFw0yMzEyMTQyMDIyMDNaMIHSMQswCQYDVQQGEwJVUzETMBEGA1UE
# CBMKV2FzaGluZ3RvbjEQMA4GA1UEBxMHUmVkbW9uZDEeMBwGA1UEChMVTWljcm9z
# b2Z0IENvcnBvcmF0aW9uMS0wKwYDVQQLEyRNaWNyb3NvZnQgSXJlbGFuZCBPcGVy
# YXRpb25zIExpbWl0ZWQxJjAkBgNVBAsTHVRoYWxlcyBUU1MgRVNOOjhENDEtNEJG
# Ny1CM0I3MSUwIwYDVQQDExxNaWNyb3NvZnQgVGltZS1TdGFtcCBTZXJ2aWNlMIIC
# IjANBgkqhkiG9w0BAQEFAAOCAg8AMIICCgKCAgEAtHwPuuYYgK4ssGCCsr2N7eEl
# Klz0JPButr/gpvZ67kNlHqgKAW0JuKAy4xxjfVCUev/eS5aEcnTmfj63fvs8eid0
# MNvP91T6r819dIqvWnBTY4vKVjSzDnfVVnWxYB3IPYRAITNN0sPgolsLrCYAKieI
# kECq+EPJfEnQ26+WTvit1US+uJuwNnHMKVYRri/rYQ2P8fKIJRfcxkadj8CEPJrN
# +lyENag/pwmA0JJeYdX1ewmBcniX4BgCBqoC83w34Sk37RMSsKAU5/BlXbVyDu+B
# 6c5XjyCYb8Qx/Qu9EB6KvE9S76M0HclIVtbVZTxnnGwsSg2V7fmJx0RP4bfAM2Zx
# JeVBizi33ghZHnjX4+xROSrSSZ0/j/U7gYPnhmwnl5SctprBc7HFPV+BtZv1VGDV
# nhqylam4vmAXAdrxQ0xHGwp9+ivqqtdVVDU50k5LUmV6+GlmWyxIJUOh0xzfQjd9
# Z7OfLq006h+l9o+u3AnS6RdwsPXJP7z27i5AH+upQronsemQ27R9HkznEa05yH2f
# Kdw71qWivEN+IR1vrN6q0J9xujjq77+t+yyVwZK4kXOXAQ2dT69D4knqMlFSsH6a
# vnXNZQyJZMsNWaEt3rr/8Nr9gGMDQGLSFxi479Zy19aT/fHzsAtu2ocBuTqLVwnx
# rZyiJ66P70EBJKO5eQECAwEAAaOCAUkwggFFMB0GA1UdDgQWBBTQGl3CUWdSDBiL
# OEgh/14F3J/DjTAfBgNVHSMEGDAWgBSfpxVdAF5iXYP05dJlpxtTNRnpcjBfBgNV
# HR8EWDBWMFSgUqBQhk5odHRwOi8vd3d3Lm1pY3Jvc29mdC5jb20vcGtpb3BzL2Ny
# bC9NaWNyb3NvZnQlMjBUaW1lLVN0YW1wJTIwUENBJTIwMjAxMCgxKS5jcmwwbAYI
# KwYBBQUHAQEEYDBeMFwGCCsGAQUFBzAChlBodHRwOi8vd3d3Lm1pY3Jvc29mdC5j
# b20vcGtpb3BzL2NlcnRzL01pY3Jvc29mdCUyMFRpbWUtU3RhbXAlMjBQQ0ElMjAy
# MDEwKDEpLmNydDAMBgNVHRMBAf8EAjAAMBYGA1UdJQEB/wQMMAoGCCsGAQUFBwMI
# MA4GA1UdDwEB/wQEAwIHgDANBgkqhkiG9w0BAQsFAAOCAgEAWoa7N86wCbjAAl8R
# GYmBZbS00ss+TpViPnf6EGZQgKyoaCP2hc01q2AKr6Me3TcSJPNWHG14pY4uhMzH
# f1wJxQmAM5Agf4aO7KNhVV04Jr0XHqUjr3T84FkWXPYMO4ulQG6j/+/d7gqezjXa
# Y7cDqYNCSd3F4lKx0FJuQqpxwHtML+a4U6HODf2Z+KMYgJzWRnOIkT/od0oIXyn3
# 6+zXIZRHm7OQij7ryr+fmQ23feF1pDbfhUSHTA9IT50KCkpGp/GBiwFP/m1drd7x
# NfImVWgb2PBcGsqdJBvj6TX2MdUHfBVR+We4A0lEj1rNbCpgUoNtlaR9Dy2k2gV8
# ooVEdtaiZyh0/VtWfuQpZQJMDxgbZGVMG2+uzcKpjeYANMlSKDhyQ38wboAivxD4
# AKYoESbg4Wk5xkxfRzFqyil2DEz1pJ0G6xol9nci2Xe8LkLdET3u5RGxUHam8L4K
# eMW238+RjvWX1RMfNQI774ziFIZLOR+77IGFcwZ4FmoteX1x9+Bg9ydEWNBP3sZv
# 9uDiywsgW40k00Am5v4i/GGiZGu1a4HhI33fmgx+8blwR5nt7JikFngNuS83jhm8
# RHQQdFqQvbFvWuuyPtzwj5q4SpjO1SkOe6roHGkEhQCUXdQMnRIwbnGpb/2Esxad
# okK8h6sRZMWbriO2ECLQEMzCcLAwggdxMIIFWaADAgECAhMzAAAAFcXna54Cm0mZ
# AAAAAAAVMA0GCSqGSIb3DQEBCwUAMIGIMQswCQYDVQQGEwJVUzETMBEGA1UECBMK
# V2FzaGluZ3RvbjEQMA4GA1UEBxMHUmVkbW9uZDEeMBwGA1UEChMVTWljcm9zb2Z0
# IENvcnBvcmF0aW9uMTIwMAYDVQQDEylNaWNyb3NvZnQgUm9vdCBDZXJ0aWZpY2F0
# ZSBBdXRob3JpdHkgMjAxMDAeFw0yMTA5MzAxODIyMjVaFw0zMDA5MzAxODMyMjVa
# MHwxCzAJBgNVBAYTAlVTMRMwEQYDVQQIEwpXYXNoaW5ndG9uMRAwDgYDVQQHEwdS
# ZWRtb25kMR4wHAYDVQQKExVNaWNyb3NvZnQgQ29ycG9yYXRpb24xJjAkBgNVBAMT
# HU1pY3Jvc29mdCBUaW1lLVN0YW1wIFBDQSAyMDEwMIICIjANBgkqhkiG9w0BAQEF
# AAOCAg8AMIICCgKCAgEA5OGmTOe0ciELeaLL1yR5vQ7VgtP97pwHB9KpbE51yMo1
# V/YBf2xK4OK9uT4XYDP/XE/HZveVU3Fa4n5KWv64NmeFRiMMtY0Tz3cywBAY6GB9
# alKDRLemjkZrBxTzxXb1hlDcwUTIcVxRMTegCjhuje3XD9gmU3w5YQJ6xKr9cmmv
# Haus9ja+NSZk2pg7uhp7M62AW36MEBydUv626GIl3GoPz130/o5Tz9bshVZN7928
# jaTjkY+yOSxRnOlwaQ3KNi1wjjHINSi947SHJMPgyY9+tVSP3PoFVZhtaDuaRr3t
# pK56KTesy+uDRedGbsoy1cCGMFxPLOJiss254o2I5JasAUq7vnGpF1tnYN74kpEe
# HT39IM9zfUGaRnXNxF803RKJ1v2lIH1+/NmeRd+2ci/bfV+AutuqfjbsNkz2K26o
# ElHovwUDo9Fzpk03dJQcNIIP8BDyt0cY7afomXw/TNuvXsLz1dhzPUNOwTM5TI4C
# vEJoLhDqhFFG4tG9ahhaYQFzymeiXtcodgLiMxhy16cg8ML6EgrXY28MyTZki1ug
# poMhXV8wdJGUlNi5UPkLiWHzNgY1GIRH29wb0f2y1BzFa/ZcUlFdEtsluq9QBXps
# xREdcu+N+VLEhReTwDwV2xo3xwgVGD94q0W29R6HXtqPnhZyacaue7e3PmriLq0C
# AwEAAaOCAd0wggHZMBIGCSsGAQQBgjcVAQQFAgMBAAEwIwYJKwYBBAGCNxUCBBYE
# FCqnUv5kxJq+gpE8RjUpzxD/LwTuMB0GA1UdDgQWBBSfpxVdAF5iXYP05dJlpxtT
# NRnpcjBcBgNVHSAEVTBTMFEGDCsGAQQBgjdMg30BATBBMD8GCCsGAQUFBwIBFjNo
# dHRwOi8vd3d3Lm1pY3Jvc29mdC5jb20vcGtpb3BzL0RvY3MvUmVwb3NpdG9yeS5o
# dG0wEwYDVR0lBAwwCgYIKwYBBQUHAwgwGQYJKwYBBAGCNxQCBAweCgBTAHUAYgBD
# AEEwCwYDVR0PBAQDAgGGMA8GA1UdEwEB/wQFMAMBAf8wHwYDVR0jBBgwFoAU1fZW
# y4/oolxiaNE9lJBb186aGMQwVgYDVR0fBE8wTTBLoEmgR4ZFaHR0cDovL2NybC5t
# aWNyb3NvZnQuY29tL3BraS9jcmwvcHJvZHVjdHMvTWljUm9vQ2VyQXV0XzIwMTAt
# MDYtMjMuY3JsMFoGCCsGAQUFBwEBBE4wTDBKBggrBgEFBQcwAoY+aHR0cDovL3d3
# dy5taWNyb3NvZnQuY29tL3BraS9jZXJ0cy9NaWNSb29DZXJBdXRfMjAxMC0wNi0y
# My5jcnQwDQYJKoZIhvcNAQELBQADggIBAJ1VffwqreEsH2cBMSRb4Z5yS/ypb+pc
# FLY+TkdkeLEGk5c9MTO1OdfCcTY/2mRsfNB1OW27DzHkwo/7bNGhlBgi7ulmZzpT
# Td2YurYeeNg2LpypglYAA7AFvonoaeC6Ce5732pvvinLbtg/SHUB2RjebYIM9W0j
# VOR4U3UkV7ndn/OOPcbzaN9l9qRWqveVtihVJ9AkvUCgvxm2EhIRXT0n4ECWOKz3
# +SmJw7wXsFSFQrP8DJ6LGYnn8AtqgcKBGUIZUnWKNsIdw2FzLixre24/LAl4FOmR
# sqlb30mjdAy87JGA0j3mSj5mO0+7hvoyGtmW9I/2kQH2zsZ0/fZMcm8Qq3UwxTSw
# ethQ/gpY3UA8x1RtnWN0SCyxTkctwRQEcb9k+SS+c23Kjgm9swFXSVRk2XPXfx5b
# RAGOWhmRaw2fpCjcZxkoJLo4S5pu+yFUa2pFEUep8beuyOiJXk+d0tBMdrVXVAmx
# aQFEfnyhYWxz/gq77EFmPWn9y8FBSX5+k77L+DvktxW/tM4+pTFRhLy/AsGConsX
# HRWJjXD+57XQKBqJC4822rpM+Zv/Cuk0+CQ1ZyvgDbjmjJnW4SLq8CdCPSWU5nR0
# W2rRnj7tfqAxM328y+l7vzhwRNGQ8cirOoo6CGJ/2XBjU02N7oJtpQUQwXEGahC0
# HVUzWLOhcGbyoYIC1DCCAj0CAQEwggEAoYHYpIHVMIHSMQswCQYDVQQGEwJVUzET
# MBEGA1UECBMKV2FzaGluZ3RvbjEQMA4GA1UEBxMHUmVkbW9uZDEeMBwGA1UEChMV
# TWljcm9zb2Z0IENvcnBvcmF0aW9uMS0wKwYDVQQLEyRNaWNyb3NvZnQgSXJlbGFu
# ZCBPcGVyYXRpb25zIExpbWl0ZWQxJjAkBgNVBAsTHVRoYWxlcyBUU1MgRVNOOjhE
# NDEtNEJGNy1CM0I3MSUwIwYDVQQDExxNaWNyb3NvZnQgVGltZS1TdGFtcCBTZXJ2
# aWNloiMKAQEwBwYFKw4DAhoDFQBxi0Tolt0eEqXCQl4qgJXUkiQOYaCBgzCBgKR+
# MHwxCzAJBgNVBAYTAlVTMRMwEQYDVQQIEwpXYXNoaW5ndG9uMRAwDgYDVQQHEwdS
# ZWRtb25kMR4wHAYDVQQKExVNaWNyb3NvZnQgQ29ycG9yYXRpb24xJjAkBgNVBAMT
# HU1pY3Jvc29mdCBUaW1lLVN0YW1wIFBDQSAyMDEwMA0GCSqGSIb3DQEBBQUAAgUA
# 6H89ijAiGA8yMDIzMDgxMDE4NDIxOFoYDzIwMjMwODExMTg0MjE4WjB0MDoGCisG
# AQQBhFkKBAExLDAqMAoCBQDofz2KAgEAMAcCAQACAgpKMAcCAQACAhKYMAoCBQDo
# gI8KAgEAMDYGCisGAQQBhFkKBAIxKDAmMAwGCisGAQQBhFkKAwKgCjAIAgEAAgMH
# oSChCjAIAgEAAgMBhqAwDQYJKoZIhvcNAQEFBQADgYEAsqXPbKF/zd0pu2Xa5lNx
# RYAIYtULWeD+e0rgOA1NnyCsZIVsXU2zyjs1C/krpsuyAEDLZ922Z/w+3LrsT904
# w5Gp8WmDgWHL6Sfxi1r+p15ZIIUBTjKQ+FyzIQxLcreCapR0DqGUhNLV+GD+XBi7
# uotqbzNI26gusvCdrtzyfEgxggQNMIIECQIBATCBkzB8MQswCQYDVQQGEwJVUzET
# MBEGA1UECBMKV2FzaGluZ3RvbjEQMA4GA1UEBxMHUmVkbW9uZDEeMBwGA1UEChMV
# TWljcm9zb2Z0IENvcnBvcmF0aW9uMSYwJAYDVQQDEx1NaWNyb3NvZnQgVGltZS1T
# dGFtcCBQQ0EgMjAxMAITMwAAAbP+Jc4pGxuKHAABAAABszANBglghkgBZQMEAgEF
# AKCCAUowGgYJKoZIhvcNAQkDMQ0GCyqGSIb3DQEJEAEEMC8GCSqGSIb3DQEJBDEi
# BCANXVhYQTeg99B41WLGU6NybGZjUUlzdAqUZGZJmejdGzCB+gYLKoZIhvcNAQkQ
# Ai8xgeowgecwgeQwgb0EIIahM9UqENIHtkbTMlBlQzaOT+WXXMkaHoo6GfvqT79C
# MIGYMIGApH4wfDELMAkGA1UEBhMCVVMxEzARBgNVBAgTCldhc2hpbmd0b24xEDAO
# BgNVBAcTB1JlZG1vbmQxHjAcBgNVBAoTFU1pY3Jvc29mdCBDb3Jwb3JhdGlvbjEm
# MCQGA1UEAxMdTWljcm9zb2Z0IFRpbWUtU3RhbXAgUENBIDIwMTACEzMAAAGz/iXO
# KRsbihwAAQAAAbMwIgQgvyG6tMmDNAlQqYEQC0zzSLHy5NCpDhvXPnwvlFSEMZsw
# DQYJKoZIhvcNAQELBQAEggIAHwoJIcllZJq3A8z4m5GZzvdFY+TOR2fokcAUQaWK
# guQ6EKgwaFxga017Jnguw6/sFCQCv52J1po1YVU7tKUBdiUhLisGtLyG0JcL9/s4
# Hq0BCnj+lC6jBNnbw52SjC4lCLDx1rUUTBGVmZ7Q03zb/IyK62Z0J+kdyOjUQnxV
# b8vX3/XUfQAWwg9LZ7pEoTY3VbpanKc71Ne+5IxRfdzUr84rkj05W0fH5dflRt2F
# Lysqne9+VsTgmJHfEaJy6rZip6A4+kdD2mUdgfLEDX4ozTjijltu4fFgPW8/BVBm
# 8a9UWDhbJYu4XAW3QIWXwu4yakhYcKA1GrZPhUXzIH6iGORABbOxa+VZ5vraItOg
# qqluhsKPSCfGgK9LHFpd8EdVx5MePkeAuFn1CRTEceuX/1ymCvxhboDv8vP6xbT2
# 1xD3MTDB8vKWGt6/TT67ktX1vI/hV0zCUii463u5EfJ0nzas2FspDMZu629Gpa+g
# 5xDaBf8nbX2yhyDb84HAXRvB3o793nKgexgmJMnjaUpVpmb4OgghmRev6/FrvrgY
# pn/muFRgme+Kfm9MIq2a2o2qXNSgUV0knO8GlXqjtv8/mcw+QbI4cg1AtOst7hyI
# DTho8TsoxCZvudN6y5r1qb0e9ZjeWHG+JBiky9JkVywH4l50RqTiPYs5ovkVu2tT
# YAY=
# SIG # End signature block
