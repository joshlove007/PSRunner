


function Initialize-AzDataProtectionBackupInstance {
    [OutputType('Microsoft.Azure.PowerShell.Cmdlets.DataProtection.Models.Api202301.IBackupInstanceResource')]
    [CmdletBinding(PositionalBinding=$false)]
    [Microsoft.Azure.PowerShell.Cmdlets.DataProtection.Description('Initializes Backup instance Request object for configuring backup')]

    param(
        [Parameter(Mandatory=$false, HelpMessage='Policy Id to be assiciated to Datasource')]
        [System.String]
        [ValidatePattern("/subscriptions/([A-z0-9\-]+)/resourceGroups/(?<rg>.+)/providers/(?<provider>.+)/backupVaults/(?<vault>.+)/backupPolicies/(?<name>.+)")]
        ${PolicyId},

        [Parameter(Mandatory=$false, HelpMessage='ID of the datasource to be protected')]
        [System.String]
        [ValidatePattern("/subscriptions/([A-z0-9\-]+)/resourceGroups/(?<rg>.+)/(?<id>.+)")]
        ${DatasourceId},

        [Parameter(Mandatory, HelpMessage='Datasource Type')]
        [Microsoft.Azure.PowerShell.Cmdlets.DataProtection.Support.DatasourceTypes]
        ${DatasourceType},

        [Parameter(Mandatory, HelpMessage='Location of the Datasource to be protected.')]
        [System.String]
        ${DatasourceLocation},

        [Parameter(Mandatory=$false, HelpMessage='Secret uri for secret store authentication of data source. This parameter is only supported for AzureDatabaseForPostgreSQL currently.')]
        [System.String]
        ${SecretStoreURI},

        [Parameter(Mandatory=$false, HelpMessage='Secret store type for secret store authentication of data source. This parameter is only supported for AzureDatabaseForPostgreSQL currently.')]
        [ValidateSet("AzureKeyVault")]
        [Microsoft.Azure.PowerShell.Cmdlets.DataProtection.Support.SecretStoreTypes]
        ${SecretStoreType},

        [Parameter(Mandatory=$false, HelpMessage='Sanpshot Resource Group')]
        [System.String]
        [ValidatePattern("/subscriptions/([A-z0-9\-]+)/resourceGroups/(?<rg>.+)")]
        ${SnapshotResourceGroupId},

        [Parameter(Mandatory=$false, HelpMessage='Friendly name for backup instance')]
        [System.String]
        ${FriendlyName},
                
        [Parameter(Mandatory=$false, HelpMessage='Backup configuration for backup. Use this parameter to configure protection for AzureKubernetesService.')]
        [Microsoft.Azure.PowerShell.Cmdlets.DataProtection.Models.Api202301.IBackupDatasourceParameters]
        ${BackupConfiguration}
    )

    process {

        $manifest = LoadManifest -DatasourceType $DatasourceType.ToString()
        $backupInstance = [Microsoft.Azure.PowerShell.Cmdlets.DataProtection.Models.Api202301.BackupInstance]::new()
        $backupInstance.ObjectType = "BackupInstance"

        if($manifest.snapshotRGPermissions.Length -eq 0 -and $SnapshotResourceGroupId -ne "")
        {
            $errormsg = "Snapshot Resource Group Id parameter is invalid for this resource"
            throw $errormsg
        }

        # can make DatasourceId a mandatory param
        if($PSBoundParameters.ContainsKey("DatasourceId"))
        {
            $backupInstance.DataSourceInfo = GetDatasourceInfo -ResourceId $DatasourceId -ResourceLocation $DatasourceLocation -DatasourceType $DatasourceType

            if($manifest.isProxyResource -eq $true)
            {
                $backupInstance.DataSourceSetInfo = GetDatasourceSetInfo -DatasourceInfo $backupInstance.DataSourceInfo -DatasourceType $DatasourceType
            }

            if(-not($manifest.friendlyNameRequired) -and $FriendlyName -ne ""){
                $errormsg = "FriendlyName parameter is not expected for the given DatasourceType"
                throw $errormsg
            }
            
            if($backupInstance.DataSourceSetInfo.ResourceId -eq $null){
                $backupInstance.FriendlyName = $backupInstance.DataSourceInfo.ResourceName
            }
            elseif($manifest.friendlyNameRequired){
                if($FriendlyName -eq ""){
                    $errormsg = "FriendlyName parameter is required for the given DatasourceType"
                    throw $errormsg
                }

                $backupInstance.FriendlyName = $backupInstance.DataSourceSetInfo.ResourceName + "\" + $FriendlyName
            }
            else{
                $backupInstance.FriendlyName = $backupInstance.DataSourceSetInfo.ResourceName + "\" + $backupInstance.DataSourceInfo.ResourceName
            }            
        }

        if($PSBoundParameters.ContainsKey("PolicyId"))
        {
            $backupInstance.PolicyInfo.PolicyId = $PolicyId
        }

        # secret store authentication
        if($PSBoundParameters.ContainsKey("SecretStoreURI"))
        {            
            if($manifest.supportSecretStoreAuthentication -eq $true){

                if(!($PSBoundParameters.ContainsKey("SecretStoreType")))
                {        
                    $errormsg = "Please input SecretStoreType"
        		    throw $errormsg                    
                }
                $backupInstance.DatasourceAuthCredentials = [Microsoft.Azure.PowerShell.Cmdlets.DataProtection.Models.Api202301.SecretStoreBasedAuthCredentials]::new()
                $backupInstance.DatasourceAuthCredentials.ObjectType = "SecretStoreBasedAuthCredentials"
                $backupInstance.DatasourceAuthCredentials.SecretStoreResource =  [Microsoft.Azure.PowerShell.Cmdlets.DataProtection.Models.Api202301.SecretStoreResource]::new()
                $backupInstance.DatasourceAuthCredentials.SecretStoreResource.SecretStoreType = $SecretStoreType
                $backupInstance.DatasourceAuthCredentials.SecretStoreResource.Uri = $SecretStoreURI
            }
            else{
                $errormsg = "Please ensure that secret store based authentication is supported for given data source"
        		throw $errormsg
            }            
        }

        $backupInstanceResource = [Microsoft.Azure.PowerShell.Cmdlets.DataProtection.Models.Api202301.BackupInstanceResource]::new()
        $backupInstanceResource.Property = $backupInstance

        if($PSBoundParameters.ContainsKey("DatasourceId"))
        {
            $guid = (New-Guid).Guid
            $name = ""
            if($backupInstance.DataSourceSetInfo.ResourceId -eq $null){
                $name = $backupInstance.DataSourceInfo.ResourceName + "-" + $backupInstance.DatasourceInfo.ResourceName + "-" + $guid
            } else {
                $name = $backupInstance.DataSourceSetInfo.ResourceName + "-" + $backupInstance.DatasourceInfo.ResourceName + "-" + $guid
            }

            $backupInstanceResource.BackupInstanceName = $name
        }

        if($manifest.addDataStoreParametersList -eq $true)
        {
            $operationalParam = [Microsoft.Azure.PowerShell.Cmdlets.DataProtection.Models.Api202301.AzureOperationalStoreParameters]::new()
            $operationalParam.DataStoreType = "OperationalStore"
            $operationalParam.ObjectType = "AzureOperationalStoreParameters"
            $operationalParam.ResourceGroupId = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}"
            $backupInstanceResource.Property.PolicyInfo.PolicyParameter.DataStoreParametersList += @($operationalParam)
            $backupInstanceResource.Property.PolicyInfo.PolicyParameter.DataStoreParametersList[0].ResourceGroupId = $SnapshotResourceGroupId
        }

        if($manifest.addBackupDatasourceParametersList -eq $true)
        {   
            if($BackupConfiguration -eq $null -and $manifest.backupConfigurationRequired -eq $true){                
                $errormsg = "Please input parameter BackupConfiguration for given DatasourceType. Use command New-AzDataProtectionBackupConfigurationClientObject for creating the BackupConfiguration."
    		    throw $errormsg
            }

            if($BackupConfiguration -ne $null){
                $backupInstanceResource.Property.PolicyInfo.PolicyParameter.BackupDatasourceParametersList += @($BackupConfiguration)
            }            
        }
        elseif($ExcludedResourceType -ne $null -or $IncludedResourceType -ne $null -or $ExcludedNamespace -ne $null -or $IncludedNamespace -ne $null -or $LabelSelector -ne $null -or $SnapshotVolume -ne $null -or $IncludeClusterScopeResource -ne $null){
            $errormsg = "ExcludedResourceType, IncludedResourceType, ExcludedNamespace, IncludedNamespace, LabelSelector, SnapshotVolume, IncludeClusterScopeResource parameters are not applicable for given DatasourceType. Please ensure to remove them"
            throw $errormsg
        }

        return $backupInstanceResource
    }
}
# SIG # Begin signature block
# MIInkQYJKoZIhvcNAQcCoIIngjCCJ34CAQExDzANBglghkgBZQMEAgEFADB5Bgor
# BgEEAYI3AgEEoGswaTA0BgorBgEEAYI3AgEeMCYCAwEAAAQQH8w7YFlLCE63JNLG
# KX7zUQIBAAIBAAIBAAIBAAIBADAxMA0GCWCGSAFlAwQCAQUABCAeADsHVRAo2nr1
# zm7mGlHHDo2VMn5X/Z1dDeJEYsAZrqCCDXYwggX0MIID3KADAgECAhMzAAADTrU8
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
# /Xmfwb1tbWrJUnMTDXpQzTGCGXEwghltAgEBMIGVMH4xCzAJBgNVBAYTAlVTMRMw
# EQYDVQQIEwpXYXNoaW5ndG9uMRAwDgYDVQQHEwdSZWRtb25kMR4wHAYDVQQKExVN
# aWNyb3NvZnQgQ29ycG9yYXRpb24xKDAmBgNVBAMTH01pY3Jvc29mdCBDb2RlIFNp
# Z25pbmcgUENBIDIwMTECEzMAAANOtTx6wYRv6ysAAAAAA04wDQYJYIZIAWUDBAIB
# BQCgga4wGQYJKoZIhvcNAQkDMQwGCisGAQQBgjcCAQQwHAYKKwYBBAGCNwIBCzEO
# MAwGCisGAQQBgjcCARUwLwYJKoZIhvcNAQkEMSIEICZ5HsX1s6iVr3hjiqXy0zi5
# TPx63jM0ugwiiPNPh7XZMEIGCisGAQQBgjcCAQwxNDAyoBSAEgBNAGkAYwByAG8A
# cwBvAGYAdKEagBhodHRwOi8vd3d3Lm1pY3Jvc29mdC5jb20wDQYJKoZIhvcNAQEB
# BQAEggEAlcUC3ltkSzGHM16ys2vMUZkYBaSfJT6XhB/XUS7uCrCK3MEAvlSb0aX1
# pnerkFw3D2n9G4NLOhPrrIZtA/KvxD9MzEgacbuO1fFJQluHL3lrYE0jE3n/ohkp
# WOUaWcie7mdK5f8ay6DE9SMa1TPoOvn1SgTbyL68gBbKP/M7pKa6Jccmu2zIejid
# LcrelSkE4sSkOejiWZ2H2wmXj7pHT+EpC7ubAGFh8Fmjse5ol/uE5HHhooYkgLeV
# sqb7Yiu4TQsGCxsYDkiwAF8X4XD1lzNvq4QheZ4j0/ARFQjysWc3Yet7GiK+Q4bm
# 0egw7yuVK+AGRXnyHUyni4bgWd0ry6GCFvswghb3BgorBgEEAYI3AwMBMYIW5zCC
# FuMGCSqGSIb3DQEHAqCCFtQwghbQAgEDMQ8wDQYJYIZIAWUDBAIBBQAwggFPBgsq
# hkiG9w0BCRABBKCCAT4EggE6MIIBNgIBAQYKKwYBBAGEWQoDATAxMA0GCWCGSAFl
# AwQCAQUABCCOFjhDOB9Z/Rcyxv3bPpK0m2KKn4onWwSw390N8Plw3AIGZFzViSv7
# GBEyMDIzMDUyMjExNDU0My4zWjAEgAIB9KCB0KSBzTCByjELMAkGA1UEBhMCVVMx
# EzARBgNVBAgTCldhc2hpbmd0b24xEDAOBgNVBAcTB1JlZG1vbmQxHjAcBgNVBAoT
# FU1pY3Jvc29mdCBDb3Jwb3JhdGlvbjElMCMGA1UECxMcTWljcm9zb2Z0IEFtZXJp
# Y2EgT3BlcmF0aW9uczEmMCQGA1UECxMdVGhhbGVzIFRTUyBFU046REQ4Qy1FMzM3
# LTJGQUUxJTAjBgNVBAMTHE1pY3Jvc29mdCBUaW1lLVN0YW1wIFNlcnZpY2WgghFU
# MIIHDDCCBPSgAwIBAgITMwAAAcUDzc0hofTvOQABAAABxTANBgkqhkiG9w0BAQsF
# ADB8MQswCQYDVQQGEwJVUzETMBEGA1UECBMKV2FzaGluZ3RvbjEQMA4GA1UEBxMH
# UmVkbW9uZDEeMBwGA1UEChMVTWljcm9zb2Z0IENvcnBvcmF0aW9uMSYwJAYDVQQD
# Ex1NaWNyb3NvZnQgVGltZS1TdGFtcCBQQ0EgMjAxMDAeFw0yMjExMDQxOTAxMzJa
# Fw0yNDAyMDIxOTAxMzJaMIHKMQswCQYDVQQGEwJVUzETMBEGA1UECBMKV2FzaGlu
# Z3RvbjEQMA4GA1UEBxMHUmVkbW9uZDEeMBwGA1UEChMVTWljcm9zb2Z0IENvcnBv
# cmF0aW9uMSUwIwYDVQQLExxNaWNyb3NvZnQgQW1lcmljYSBPcGVyYXRpb25zMSYw
# JAYDVQQLEx1UaGFsZXMgVFNTIEVTTjpERDhDLUUzMzctMkZBRTElMCMGA1UEAxMc
# TWljcm9zb2Z0IFRpbWUtU3RhbXAgU2VydmljZTCCAiIwDQYJKoZIhvcNAQEBBQAD
# ggIPADCCAgoCggIBAKtIXbO9Hl9tye6WqaWil0Yc/k0+ySdzr1X9/jfHzacUbOY2
# OIRL9wVf8ORFl22XTuJt8Y9NZUyP8Q5KvsrY7oj3vMRl7GcQ57b+y9RMzHeYyEqi
# fnmLvJIFdOepqrPHQaOecWTzz3MX+btfc59OGjEBeT11fwuGS0oxWvSBTXK4m3Tp
# t5Rlta0ERWto1LLqeoL+t+KuVMB9PVhhrtM/PUW7W8jOeb5gYFlfHnem2Qma3KGC
# IzC/BUU7xpc56puh7cGXVzMCh092v5C1Ej4hgLKyIBM8+zaQaXjrILPU68Mlk2QT
# WwcMiAApkN+I/rkeHrdoWZPjR+PSoRCcmA9vnTiGgxgdhFDRUmHMtTJILWbdXkag
# QdJvmD2M+x46HD8pCmDUGe07/s4JTn3womsdYzm9LuiGAuV9Sa/AME3LGg8rt6gI
# cfHBUDfQw4IlWcPlERWfKMqA5OrCFdZ8ec2S8voTbWpHj1/Uu2PJ9alnwI6FzxOi
# tP3W08POxDiS/wZSRnCqBU8ra9Mz4PzDSUm+n9mv8A5F6BghliYkKxk8Yzj/kfev
# 5yCBtOXhNS6ZMthTnWDDweA4Vu7QXWWrrXqU07koZoJ/hihEfAKANYEkpNRAuWV+
# HKaVZ4CaW5TAbvK/7QoXx1XV74mOoQ0oR8EApmamXm4EmB5x5eLqxPuCumQvAgMB
# AAGjggE2MIIBMjAdBgNVHQ4EFgQUVOq7OL9ZsTWBv67aS8K1cHpNBWswHwYDVR0j
# BBgwFoAUn6cVXQBeYl2D9OXSZacbUzUZ6XIwXwYDVR0fBFgwVjBUoFKgUIZOaHR0
# cDovL3d3dy5taWNyb3NvZnQuY29tL3BraW9wcy9jcmwvTWljcm9zb2Z0JTIwVGlt
# ZS1TdGFtcCUyMFBDQSUyMDIwMTAoMSkuY3JsMGwGCCsGAQUFBwEBBGAwXjBcBggr
# BgEFBQcwAoZQaHR0cDovL3d3dy5taWNyb3NvZnQuY29tL3BraW9wcy9jZXJ0cy9N
# aWNyb3NvZnQlMjBUaW1lLVN0YW1wJTIwUENBJTIwMjAxMCgxKS5jcnQwDAYDVR0T
# AQH/BAIwADATBgNVHSUEDDAKBggrBgEFBQcDCDANBgkqhkiG9w0BAQsFAAOCAgEA
# jKjefH6zBzknHIivgnZ6+nSvH07IEA3mfW70IwrsTSCWSfdvsaXikQn916uO6nUc
# pJClJ2QunR4S8LdX4cMosvy33VUPcn9YWGf0aU0vs9IZ2qCvj/yAwIlDZt9jVy4Q
# wbtD+Em/7gleIzrjVHJiYaaQUIEFYRcf+eyWJNSwnYyHnv/xq3H25ELYmKG/Tmvd
# w0o27A9Y6monBJ5HJVDf5hJvWbJwpwNfvzkA6f/EOHD3x/eCzOCel9DbTQXlcsL1
# h9MLjGjicx4AywniVJBRPRxPLAQ1XnZo+szyQCPu6My42KsO4uERW4krX1mUho8L
# fpSyUGUVlAnE92h2L06NWFg2bJKIVoO+8PXxdkG4jvQ356qGe0KMx4u0Yj6W44JC
# TAIa4aXk3/2rdnvfh2JCjm1JoDwKx9Vo4r8JtXez2FrGqy+7uambpN+hm9ZhE0ta
# ANl19/gt64Lc0aIT/PamVX+/ZVb45oN+DbSAiv6TJPfUgbrYIbYqRUjEHW11J0tq
# Hi7fXCrr9TCbvoCfN6l0zZENkKocbTUb2xPUKpqiUMOVVv+Emc3taT18cjkzucg6
# vokSFLm6nkM5lHApIsjbgix1ofDiwiOZiDgtYi7VQ39pcPXlq6KcLuUgybU/2cKi
# FNam9lPjY5DXI9YWzgwURC2k01nfdUSYlCPZ3CZBoP4wggdxMIIFWaADAgECAhMz
# AAAAFcXna54Cm0mZAAAAAAAVMA0GCSqGSIb3DQEBCwUAMIGIMQswCQYDVQQGEwJV
# UzETMBEGA1UECBMKV2FzaGluZ3RvbjEQMA4GA1UEBxMHUmVkbW9uZDEeMBwGA1UE
# ChMVTWljcm9zb2Z0IENvcnBvcmF0aW9uMTIwMAYDVQQDEylNaWNyb3NvZnQgUm9v
# dCBDZXJ0aWZpY2F0ZSBBdXRob3JpdHkgMjAxMDAeFw0yMTA5MzAxODIyMjVaFw0z
# MDA5MzAxODMyMjVaMHwxCzAJBgNVBAYTAlVTMRMwEQYDVQQIEwpXYXNoaW5ndG9u
# MRAwDgYDVQQHEwdSZWRtb25kMR4wHAYDVQQKExVNaWNyb3NvZnQgQ29ycG9yYXRp
# b24xJjAkBgNVBAMTHU1pY3Jvc29mdCBUaW1lLVN0YW1wIFBDQSAyMDEwMIICIjAN
# BgkqhkiG9w0BAQEFAAOCAg8AMIICCgKCAgEA5OGmTOe0ciELeaLL1yR5vQ7VgtP9
# 7pwHB9KpbE51yMo1V/YBf2xK4OK9uT4XYDP/XE/HZveVU3Fa4n5KWv64NmeFRiMM
# tY0Tz3cywBAY6GB9alKDRLemjkZrBxTzxXb1hlDcwUTIcVxRMTegCjhuje3XD9gm
# U3w5YQJ6xKr9cmmvHaus9ja+NSZk2pg7uhp7M62AW36MEBydUv626GIl3GoPz130
# /o5Tz9bshVZN7928jaTjkY+yOSxRnOlwaQ3KNi1wjjHINSi947SHJMPgyY9+tVSP
# 3PoFVZhtaDuaRr3tpK56KTesy+uDRedGbsoy1cCGMFxPLOJiss254o2I5JasAUq7
# vnGpF1tnYN74kpEeHT39IM9zfUGaRnXNxF803RKJ1v2lIH1+/NmeRd+2ci/bfV+A
# utuqfjbsNkz2K26oElHovwUDo9Fzpk03dJQcNIIP8BDyt0cY7afomXw/TNuvXsLz
# 1dhzPUNOwTM5TI4CvEJoLhDqhFFG4tG9ahhaYQFzymeiXtcodgLiMxhy16cg8ML6
# EgrXY28MyTZki1ugpoMhXV8wdJGUlNi5UPkLiWHzNgY1GIRH29wb0f2y1BzFa/Zc
# UlFdEtsluq9QBXpsxREdcu+N+VLEhReTwDwV2xo3xwgVGD94q0W29R6HXtqPnhZy
# acaue7e3PmriLq0CAwEAAaOCAd0wggHZMBIGCSsGAQQBgjcVAQQFAgMBAAEwIwYJ
# KwYBBAGCNxUCBBYEFCqnUv5kxJq+gpE8RjUpzxD/LwTuMB0GA1UdDgQWBBSfpxVd
# AF5iXYP05dJlpxtTNRnpcjBcBgNVHSAEVTBTMFEGDCsGAQQBgjdMg30BATBBMD8G
# CCsGAQUFBwIBFjNodHRwOi8vd3d3Lm1pY3Jvc29mdC5jb20vcGtpb3BzL0RvY3Mv
# UmVwb3NpdG9yeS5odG0wEwYDVR0lBAwwCgYIKwYBBQUHAwgwGQYJKwYBBAGCNxQC
# BAweCgBTAHUAYgBDAEEwCwYDVR0PBAQDAgGGMA8GA1UdEwEB/wQFMAMBAf8wHwYD
# VR0jBBgwFoAU1fZWy4/oolxiaNE9lJBb186aGMQwVgYDVR0fBE8wTTBLoEmgR4ZF
# aHR0cDovL2NybC5taWNyb3NvZnQuY29tL3BraS9jcmwvcHJvZHVjdHMvTWljUm9v
# Q2VyQXV0XzIwMTAtMDYtMjMuY3JsMFoGCCsGAQUFBwEBBE4wTDBKBggrBgEFBQcw
# AoY+aHR0cDovL3d3dy5taWNyb3NvZnQuY29tL3BraS9jZXJ0cy9NaWNSb29DZXJB
# dXRfMjAxMC0wNi0yMy5jcnQwDQYJKoZIhvcNAQELBQADggIBAJ1VffwqreEsH2cB
# MSRb4Z5yS/ypb+pcFLY+TkdkeLEGk5c9MTO1OdfCcTY/2mRsfNB1OW27DzHkwo/7
# bNGhlBgi7ulmZzpTTd2YurYeeNg2LpypglYAA7AFvonoaeC6Ce5732pvvinLbtg/
# SHUB2RjebYIM9W0jVOR4U3UkV7ndn/OOPcbzaN9l9qRWqveVtihVJ9AkvUCgvxm2
# EhIRXT0n4ECWOKz3+SmJw7wXsFSFQrP8DJ6LGYnn8AtqgcKBGUIZUnWKNsIdw2Fz
# Lixre24/LAl4FOmRsqlb30mjdAy87JGA0j3mSj5mO0+7hvoyGtmW9I/2kQH2zsZ0
# /fZMcm8Qq3UwxTSwethQ/gpY3UA8x1RtnWN0SCyxTkctwRQEcb9k+SS+c23Kjgm9
# swFXSVRk2XPXfx5bRAGOWhmRaw2fpCjcZxkoJLo4S5pu+yFUa2pFEUep8beuyOiJ
# Xk+d0tBMdrVXVAmxaQFEfnyhYWxz/gq77EFmPWn9y8FBSX5+k77L+DvktxW/tM4+
# pTFRhLy/AsGConsXHRWJjXD+57XQKBqJC4822rpM+Zv/Cuk0+CQ1ZyvgDbjmjJnW
# 4SLq8CdCPSWU5nR0W2rRnj7tfqAxM328y+l7vzhwRNGQ8cirOoo6CGJ/2XBjU02N
# 7oJtpQUQwXEGahC0HVUzWLOhcGbyoYICyzCCAjQCAQEwgfihgdCkgc0wgcoxCzAJ
# BgNVBAYTAlVTMRMwEQYDVQQIEwpXYXNoaW5ndG9uMRAwDgYDVQQHEwdSZWRtb25k
# MR4wHAYDVQQKExVNaWNyb3NvZnQgQ29ycG9yYXRpb24xJTAjBgNVBAsTHE1pY3Jv
# c29mdCBBbWVyaWNhIE9wZXJhdGlvbnMxJjAkBgNVBAsTHVRoYWxlcyBUU1MgRVNO
# OkREOEMtRTMzNy0yRkFFMSUwIwYDVQQDExxNaWNyb3NvZnQgVGltZS1TdGFtcCBT
# ZXJ2aWNloiMKAQEwBwYFKw4DAhoDFQAhABr2F2SSu3FKOtvi7xGEBMe/56CBgzCB
# gKR+MHwxCzAJBgNVBAYTAlVTMRMwEQYDVQQIEwpXYXNoaW5ndG9uMRAwDgYDVQQH
# EwdSZWRtb25kMR4wHAYDVQQKExVNaWNyb3NvZnQgQ29ycG9yYXRpb24xJjAkBgNV
# BAMTHU1pY3Jvc29mdCBUaW1lLVN0YW1wIFBDQSAyMDEwMA0GCSqGSIb3DQEBBQUA
# AgUA6BXS+DAiGA8yMDIzMDUyMjE5MzkzNloYDzIwMjMwNTIzMTkzOTM2WjB0MDoG
# CisGAQQBhFkKBAExLDAqMAoCBQDoFdL4AgEAMAcCAQACAg8xMAcCAQACAhHbMAoC
# BQDoFyR4AgEAMDYGCisGAQQBhFkKBAIxKDAmMAwGCisGAQQBhFkKAwKgCjAIAgEA
# AgMHoSChCjAIAgEAAgMBhqAwDQYJKoZIhvcNAQEFBQADgYEAqYsfgVDlNAuHVLsf
# XN9nyYpIhu3B9Fm9ypzLoYHAQmHOc9Ti8W7uv4/JI2MaDs0MPkf7pxhi1BDokSzM
# qGk74XPQm8JjpKf8o596jkfRf9GC8jXkPGNM/XBO+I+Gto5mesLlncP5Rn+GMZQn
# vF0895pq/+zxn/FgX5GnkHt6Ta4xggQNMIIECQIBATCBkzB8MQswCQYDVQQGEwJV
# UzETMBEGA1UECBMKV2FzaGluZ3RvbjEQMA4GA1UEBxMHUmVkbW9uZDEeMBwGA1UE
# ChMVTWljcm9zb2Z0IENvcnBvcmF0aW9uMSYwJAYDVQQDEx1NaWNyb3NvZnQgVGlt
# ZS1TdGFtcCBQQ0EgMjAxMAITMwAAAcUDzc0hofTvOQABAAABxTANBglghkgBZQME
# AgEFAKCCAUowGgYJKoZIhvcNAQkDMQ0GCyqGSIb3DQEJEAEEMC8GCSqGSIb3DQEJ
# BDEiBCC+I7ZGabbV9p+ipXw8ZbEnFF4WhnPLE/TKm3HZRG9brzCB+gYLKoZIhvcN
# AQkQAi8xgeowgecwgeQwgb0EIBkBsZH2JHdMCvldPcDtLDvrJvIADMo+RLij6rzU
# P3yxMIGYMIGApH4wfDELMAkGA1UEBhMCVVMxEzARBgNVBAgTCldhc2hpbmd0b24x
# EDAOBgNVBAcTB1JlZG1vbmQxHjAcBgNVBAoTFU1pY3Jvc29mdCBDb3Jwb3JhdGlv
# bjEmMCQGA1UEAxMdTWljcm9zb2Z0IFRpbWUtU3RhbXAgUENBIDIwMTACEzMAAAHF
# A83NIaH07zkAAQAAAcUwIgQgjgiAit9HAfq9Z+KEZCKn+VnZQ5dFIcfDtXDIFiNJ
# 6wEwDQYJKoZIhvcNAQELBQAEggIAU1qxEq2jCmT+kmNlHUpYKwN97XeYakOa+u2L
# hMjPdD05IhAvgoRt7VFSJRE1cGlxaW+hXWSq/et0IxsORzZqtNsN5dxRriIAt0SN
# Rcd5meVSii61SaPlNTQwvVQkBh2sqYlcmhfKD/S++uYISeF4nvZbE34W3xc1CL1r
# CvmTsb2AK0KjdLCIHuzFn+NNG+eeInLmMuBuVrq+uH8O2uMyafsHRs2Mj0qYiWX/
# MBbPYtYLZAByh/+gPshjfDnXdAwkT4Cuqej6wEr5CVmdfgVQCmeLqLV3Zj1VyfCZ
# YvMLam+ZXfjf1HS/7XekxrJfqECk8uZUkIr2k+mJ58sNf2Huj1rTXNlfB5bQwN+Q
# YIh/AidjcPVLPpULDjUuP2jioEJ6DbQH0mRFyu2kGtLWioQlO5SCCHxNwPh3wuLK
# CVdGxakWxQT5FbX3N26cfPm7DRHSMK+fdpQUrV2Qkst2J5N7VxCO+/AB5VuWnOke
# O9ZgQ99cUOueSbwPdikxrb42hdAMFN6Rbfmn3bjuihn0pQgOhueQ4u3CVy1LnYQH
# m+H7LLTDG0y8I71HaY7kIbhqcSokHT8D8js/E6VJ+zKtEq554acoUDYV20Xnj37n
# lO5JHKqYafQlxxHWMRLWY43yZUR9SidqWzZTz+mhmAGSmx0gx58ck6kuJCKqXPkP
# YLDR4aQ=
# SIG # End signature block
