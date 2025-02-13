#Region Functions
    #Region Function Get-Cred
        Function Get-Cred{
            [cmdletbinding()]
            [Alias('gcr')]
            param(
                [Parameter(Mandatory,
                ValueFromPipeline,Position=0)]
                [ValidateNotNullOrEmpty()]
                [String]
                $Name,

                [Parameter(Position=1)]
                [Alias("S","SO")]
                [switch]
                $SecretOnly
            ) 
            
            if($PSEdition -eq 'Core'){$Get_Cred = "function Get-Cred{${Function:Get-Cred}}"
                return icm(nsn -UseW){iex $Using:Get_Cred;gcr $Using:Name $Using:SecretOnly}|%{if($_-is[string]){$_}else{$_|Select UserName,Password}}
            }

            $null    = [Windows.Security.Credentials.PasswordVault,Windows.Security.Credentials,ContentType=WindowsRuntime]
            $vault   = New-Object Windows.Security.Credentials.PasswordVault
            $Result  = $vault.FindAllByResource($Name)
            $cred    = $vault.Retrieve($Name,$Result.UserName) | Select UserName,Password
            
            Return $(if($SecretOnly){$cred.Password}else{$cred})
        }
        $Get_Cred = "function Get-Cred{${Function:Get-Cred}}"
    #EndRegion

    #Region Function Get-CredList
        Function Get-CredList{
            [cmdletbinding()]
            [Alias("gcl")]
            param()
            
            if($PSEdition -eq 'Core'){$Get_CredList = "function Get-CredList{${Function:Get-CredList}}"
                return (icm (nsn -UseW) {iex $Using:Get_CredList; Get-CredList})|Select Name,UserName
            }

            $null     = [Windows.Security.Credentials.PasswordVault,Windows.Security.Credentials,ContentType=WindowsRuntime]
            $vault    = New-Object Windows.Security.Credentials.PasswordVault
            $CredList = $vault.RetrieveAll() | Select-Object @{N='Name';E={$_.Resource}},UserName
            
            Return $CredList
        }
        $Get_CredList = "function Get-CredList{${Function:Get-CredList}}"
    #EndRegion

    #Region Function New-Cred
        Function New-Cred{
            [cmdletbinding()]
            param(
                [Parameter(Mandatory)]
                [ValidateNotNullOrEmpty()]
                [String]
                $Name,

                [Parameter(Mandatory)]
                [ValidateNotNullOrEmpty()]
                [String]
                $Secret,

                [Parameter()]
                [ValidateNotNullOrEmpty()]
                [String]
                $UserName = " "
            )

            if($PSEdition -eq 'Core'){$New_Cred = "function New-Cred{${Function:New-Cred}}"
                Return icm (nsn -UseW){iex $Using:New_Cred; New-Cred $Using:Name $Using:Secret}
            }
            
            $null  = [Windows.Security.Credentials.PasswordVault,Windows.Security.Credentials,ContentType=WindowsRuntime]
            $vault = New-Object Windows.Security.Credentials.PasswordVault
            $cred  = New-Object windows.Security.Credentials.PasswordCredential
            $cred.Resource = $Name
            $cred.UserName = $UserName
            $cred.Password = $Secret
            $vault.Add($cred)
        }
        $New_Cred = "function New-Cred{${Function:New-Cred}}"
    #EndRegion

    #Region Function Remove-Cred
        Function Remove-Cred{
            [cmdletbinding()]
            param(
                [Parameter(Mandatory)]
                [ValidateNotNullOrEmpty()]
                $Name
            )

            if($PSEdition -eq 'Core'){$Remove_Cred = "function Remove-Cred{${Function:Remove-Cred}}"
                Return icm (nsn -UseW){iex $Using:Remove_Cred; Remove-Cred $Using:Name}
            }
            
            $null   = [Windows.Security.Credentials.PasswordVault,Windows.Security.Credentials,ContentType=WindowsRuntime]
            $vault  = New-Object Windows.Security.Credentials.PasswordVault
            $Result = $vault.FindAllByResource($Name)
            $cred   = $vault.Retrieve($Name,$Result.UserName)

            Return $Vault.Remove($cred)
        }
        $Remove_Cred = "function Remove-Cred{${Function:Remove-Cred}}"
    #EndRegion

    #Region Function Get-MSToken
        Function Get-MSToken{
            [CmdletBinding()]
            param(
                [Parameter()]
                [ValidateNotNullOrEmpty()]
                [string]
                $APIClientId,

                [Parameter()]
                [ValidateNotNullOrEmpty()]
                [string]
                $APIClientSecret,

                [Parameter()]
                [ValidateNotNullOrEmpty()]
                [string]
                $TenantId,

                [Parameter()]
                [ValidateNotNullOrEmpty()]
                [string]
                $APIScope = "https://graph.microsoft.com/.default"
            )

            
            $AzureResourceURI = "https://login.microsoftonline.com/$TenantId/oauth2/v2.0/token"

            
            # Construct the Body for the POST
            $TokenRequestBody = @{
                grant_type    = "client_credentials"
                client_id     = $APIClientId
                client_secret = $APIClientSecret
                scope         = $APIScope
            }
            
            # The result should contain a token for use with Graph
            $GraphToken = (Invoke-RestMethod -Uri $AzureResourceURI -Method POST -Body $TokenRequestBody).access_token

            Return $GraphToken
        }
    #EndRegion
#EndRegion

#$ApiSecret     = Get-Cred 'PsRAPISecret' -SecretOnly
#$tenantId      = ""
#$APIClientId   = ''
#$PSRunnerToken = Get-MSToken -APIClientId $APIClientId -APIClientSecret $ApiSecret -TenantId $tenantId -APIScope :"api://$APIClientId/.default"

$C = {
    Write-Host "PSRunner Test"
    Write-Output @{Example = "Apple Bottom Jeans"}
    Write-Error "Example Error"
}

$Headers = @{
    #Authorization    = "Bearer $PSRunnerToken"
    Async            = $false
    RunAsDurableTask = $false
    Parameters      = @{Name = "Josh"} | ConvertTo-Json -Compress
    'content-type'  = "text/powershell"
}

$Start = Get-Date

$Response = Invoke-RestMethod -Method POST "http://localhost:7071/api/PSRunner?code=AxFZ8ImABWVEgsr9NhCNJxVCSIdCqWA6wzSLYWLhZJJlAzFuKTOP7z==" -Body $C -Headers $Headers

$TimeToRun = New-TimeSpan -Start $Start -End (Get-Date)

Write-Host 'Response.Result:'     $Response.result
Write-Host 'Response.HostOutput:' $Response.HostOutput

Write-Host '********Full Response********'
Write-Host $Response

Write-Host "RoundTrip Time: $TimeToRun"
