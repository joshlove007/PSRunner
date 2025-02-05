@{
    ModuleVersion = '1.0.0.0'
    RootModule = 'PSRunnerFunctions.psm1'
    GUID = 'd1337e99-a8f8-4bb3-9884-a96fe52bd7d4'
    Author = 'Josh Lovelace, Eric Zimmerman'
    CompanyName = 'TD Synnex'
    Description = 'Shared functions for the PSRunner Azure function'
    FunctionsToExport = @(
        'ConvertFrom-JWTtoken',
        'Confirm-Parameters', 
        'Get-CachedSecret',
        'Get-Cred',
        'Get-CredList',
        'Get-PartnerMsToken',
        'Invoke-PSRunner',       
        'Invoke-VertexAuthProxy',
        'New-Cred',
        'Remove-Cred',
        'Set-SecretCache',
        'Invoke-AzStAcctTableService',
        'Remove-AzStAcctTable',
        'Set-AzStAcctTable',
        'Get-AzStAcctTable',
        'ConvertFrom-ConnectionString',
        'New-Error'
    )
    PowerShellVersion = '7.2'
}
