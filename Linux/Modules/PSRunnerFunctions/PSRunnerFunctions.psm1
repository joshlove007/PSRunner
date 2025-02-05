using namespace System.Net

#Region Function ConvertFrom-JWTtoken
    function ConvertFrom-JWTtoken {
        [cmdletbinding()]
        param(
            [Parameter(Mandatory=$true,ValueFromPipeline=$true)]
            [string]
            $token
        )

        #Validate as per https://tools.ietf.org/html/rfc7519
        #Access and ID tokens are fine, Refresh tokens will not work
        if (!$token.Contains(".") -or !$token.StartsWith("eyJ")) { 
            Write-Error "Invalid token" -ErrorAction Stop 
        }

        #Header
        $tokenheader = $token.Split(".")[0].Replace('-', '+').Replace('_', '/')

        #Fix padding as needed, keep adding "=" until string length modulus 4 reaches 0
        while ($tokenheader.Length % 4) { 
            Write-Verbose "Invalid length for a Base-64 char array or string, adding =" 
            $tokenheader += "=" 
        }

        Write-Verbose "Base64 encoded (padded) header:"
        Write-Verbose $tokenheader

        #Convert from Base64 encoded string to PSObject all at once
        Write-Verbose "Decoded header:"
        #[System.Text.Encoding]::ASCII.GetString([system.convert]::FromBase64String($tokenheader)) | ConvertFrom-Json | Format-List | Out-Default

        #Payload
        $tokenPayload = $token.Split(".")[1].Replace('-', '+').Replace('_', '/')

        #Fix padding as needed, keep adding "=" until string length modulus 4 reaches 0
        while ($tokenPayload.Length % 4) { 
            Write-Verbose "Invalid length for a Base-64 char array or string, adding ="
            $tokenPayload += "=" 
        }
        Write-Verbose "Base64 encoded (padded) payoad:"
        Write-Verbose $tokenPayload

        #Convert to Byte array
        $tokenByteArray = [System.Convert]::FromBase64String($tokenPayload)

        #Convert to string array
        $tokenArray = [System.Text.Encoding]::ASCII.GetString($tokenByteArray)

        Write-Verbose "Decoded array in JSON format:"
        Write-Verbose $tokenArray
        
        #Convert from JSON to PSObject
        $tokobj = $tokenArray | ConvertFrom-Json
        Write-Verbose "Decoded Payload:"
        
        return $tokobj
    }
#EndRegion

#Region Function ConvertTo-EncryptedString
    Function ConvertTo-EncryptedString {
        [CmdletBinding(DefaultParameterSetName='String')]
        [OutputType([String], ParameterSetName='String')]
        Param (
            [Parameter(
                ParameterSetName='String',
                ValueFromPipeline,
                ValueFromPipelineByPropertyName,
                Position = 0
            )]
            [AllowEmptyString()]
            [String[]]
            $String,

            [Parameter(Mandatory)]
            [Alias('Key')]
            [ValidateNotNullOrEmpty()]
            [String]
            $EncryptionKey,

            [Parameter()]
            [Alias('Salt')]
            [ValidateNotNullOrEmpty()]
            [String]
            $EncryptionSalt = $EncryptionKey,

            [Parameter()]
            [ValidateNotNullOrEmpty()]
            [Int] 
            $Iterations = 100000
        )        

        BEGIN {
            $EncodedEncryptionKey  = [Byte[]][Char[]]$EncryptionKey
            $EncodedEncryptionSalt = [Byte[]][Char[]]$EncryptionSalt
            $Key = Switch($Iterations){
                1 {
                    [System.Security.Cryptography.SHA256Managed]::New().ComputeHash(
                        $EncodedEncryptionSalt + $EncodedEncryptionKey
                    )
                }
                {$_ -gt 1} {
                    [System.Security.Cryptography.Rfc2898DeriveBytes]::New(
                        $EncodedEncryptionKey,
                        $EncodedEncryptionSalt,
                        $Iterations,
                        [System.Security.Cryptography.HashAlgorithmName]::SHA256
                    ).GetBytes(32)
                }
                Default { Throw "Invalid Iteration value: '$Iterations'" }
            }
            If(!$Key){ Throw 'No decryption key found.' }
            $AES = [System.Security.Cryptography.AesManaged]::New()
            $AES.KeySize = 256
            $AES.Key = $Key
            $AES.Mode = [System.Security.Cryptography.CipherMode]::CBC
        }

        PROCESS {
            $String | ForEach-Object {
                If(!$String){ Return ''}
                $AES.GenerateIV()
                $Encryptor = $AES.CreateEncryptor()

                $EncryptedValue = $Encryptor.TransformFinalBlock([Byte[]][Char[]] $_, 0, $_.Length)

                '!{0}|{1}' -f @(
                    [Convert]::ToBase64String($AES.IV),
                    [Convert]::ToBase64String($EncryptedValue)
                ) | Write-Output
            }
        }
    }
#EndRegion

#Region Function ConvertFrom-EncryptedString
    Function ConvertFrom-EncryptedString {
        [CmdletBinding(DefaultParameterSetName='String')]
        [OutputType([String])]
        Param (
            [Parameter(
                ParameterSetName='String',
                ValueFromPipeline,
                ValueFromPipelineByPropertyName,
                Position = 0
            )]
            [Char[]]
            $String,

            [Parameter(Mandatory)]
            [Alias('Key')]
            [ValidateNotNullOrEmpty()]
            [String]
            $EncryptionKey,

            [Parameter()]
            [Alias('Salt')]
            [ValidateNotNullOrEmpty()]
            [String]
            $EncryptionSalt = $EncryptionKey,

            [Parameter()]
            [ValidateNotNullOrEmpty()]
            [Int] 
            $Iterations = 100000
        )

        BEGIN {
            $EncodedEncryptionKey  = [Byte[]][Char[]]$EncryptionKey
            $EncodedEncryptionSalt = [Byte[]][Char[]]$EncryptionSalt
            $Key = Switch($Iterations){
                1 {
                    [System.Security.Cryptography.SHA256Managed]::New().ComputeHash(
                        $EncodedEncryptionSalt + $EncodedEncryptionKey
                    )
                }
                {$_ -gt 1} {
                    [System.Security.Cryptography.Rfc2898DeriveBytes]::New(
                        $EncodedEncryptionKey,
                        $EncodedEncryptionSalt,
                        $Iterations,
                        [System.Security.Cryptography.HashAlgorithmName]::SHA256
                    ).GetBytes(32)
                }
                Default { Throw "Invalid Iteration value: '$Iterations'" }
            }
            $AES = [System.Security.Cryptography.AesManaged]::New()
            $AES.KeySize = 256
            $AES.Key = $Key
        }

        PROCESS {
            # https://blogs.msdn.microsoft.com/fpintos/2009/06/12/how-to-properly-convert-securestring-to-string/

            Write-Debug "Encrypted value $($String.Length):"
            Write-Debug "$($String -join '')"
            If($String.length -eq 0){ Return '' }

            $String = If($String[0] -eq '!'){
                $Index = $String.IndexOf([Char] '|')
                [Char[]] '!' +
                [Char[]][Convert]::FromBase64CharArray($String, 1, $Index-1) +
                [Char[]][Convert]::FromBase64CharArray($String, $Index+1, ($String.Length-$Index-1))
            }
            Else { [Char[]][Convert]::FromBase64CharArray($String, 0, $String.Length)}

            If(($String[0] -eq '!') -and ($String.Length -gt 32) -and ($String.Length % 16 -eq 1)){
                Write-Debug 'CBC'
                $AES.Mode = [System.Security.Cryptography.CipherMode]::CBC
                $AES.IV = $String[1..16]
                $String = $String[17..($String.Length-1)]
            }
            Else{
                Write-Debug 'ECB'
                $AES.Mode = [System.Security.Cryptography.CipherMode]::ECB
                $AES.IV = [Byte[]] '0'*16
            }
            $AES | Out-String | Write-Debug
            $Decryptor = $AES.CreateDecryptor()

            Try{
                [Char[]] $Decryptor.TransformFinalBlock(
                    $String,
                    0,
                    $String.length
                ) -join ''
            }
            Catch{
                Write-Error "Decryption failed. Data: $String"
                Throw
            }
        }
    }
#EndRegion

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

#Region Function Build-ParameterErrorResponse
    Function Get-ParameterErrorResponse {
        [CmdletBinding()]
        Param(
            [Parameter(ValueFromPipeline=$true)]
            [ParameterException] $ParameterException
        )

        Process {
            foreach ($Exception in $ParameterException) {
                [HttpResponseContext]@{
                    StatusCode      = $ParameterException.StatusCode
                    Body            = @{
                        Error       = @{
                            ParameterName   = $ParameterException.ParameterName                
                            Code            = $ParameterException.ErrorCode
                            Message         = $ParameterException.Message
                        }
                    }| ConvertTo-Json -EscapeHandling EscapeHtml
                }
            }
        }
    }
#EndRegion

#Region Class ParameterException
    class ParameterException : System.Exception {
        [System.Net.HttpStatusCode] $StatusCode
        [string] $ErrorCode
        [string] $ParameterName

        ParameterException($Message, $StatusCode, $ErrorCode, $ParameterName) : base($Message) {
            $this.StatusCode = $StatusCode
            $this.ErrorCode = $ErrorCode
            $this.ParameterName = $ParameterName
        }

    }
#EndRegion

#Region Function Confirm-Parameters
    Function Confirm-Parameters{
        [CmdletBinding()]
        Param(
            $Request,
            $TriggerMetadata
        )

        #Region Params
            $Response = $null

            $HasParameterError = $false

            $Async          = $Request.Headers.async -eq 'True'
            $ContentType    = $Request.Headers.'content-type'
            $CorrelationId  = $Request.Headers.correlationid
        #EndRegion

        $GUID_REGEX = '^[0-9A-Fa-f]{8}-[0-9A-Fa-f]{4}-[0-9A-Fa-f]{4}-[0-9A-Fa-f]{4}-[0-9A-Fa-f]{12}$'

        #Region Validate Header Parameters
            try {    
                if($ContentType.ToLower() -ne 'text/powershell'){
                    $ErrorMessage = "[PSRunner] The Content-Type header `"$ContentType`" is not valid. Content-Type must be `"text/powershell`": [400 - InvalidContentType] BadRequest"
                    throw [ParameterException]::new($ErrorMessage,
                        [System.Net.HttpStatusCode]::BadRequest,
                        "InvalidContentType",
                        'content-type')
                } 
                #Region Validate other parameters
                    if ($CorrelationId.length -gt 100) {
                        $ErrorMessage = "CorrelationId cannot be longer than 100 characters"
                        throw [ParameterException]::new($ErrorMessage,
                            [System.Net.HttpStatusCode]::BadRequest,
                            "InvalidParameterFormat",
                            "CorrelationId")
                    }
                #EndRegion
                            
            } catch {
                # Get Response from Exception
                $Response = $_.Exception | Get-ParameterErrorResponse
                $Output = @{
                    Exception = $_.Exception
                    Response = $Response
                }
            
            }    
        #EndRegion
        
        #Region Output
            If ($Output.Exception) {
                #Region Update Invocation Table
                    if($env:LOG_PSRUNNER_INVOCATIONS -eq 'True'){
                        $TableRowColumns = @{
                            LastUpdated   = Get-Date -Format "yyyy-MM-ddTHH:mm:ss.fffffffZ" -AsUTC
                            CompletedTime = Get-Date -Format "yyyy-MM-ddTHH:mm:ss.fffffffZ" -AsUTC
                            Status        = 'Error'
                            Error         = $Output.Exception.Message
                            ErrorCode     = $Output.Exception.ErrorCode 
                            PartitionKey  = $TriggerMetadata.Table.PartitionKey
                            RowKey        = $TriggerMetadata.Table.RowKey
                        }
                        Update-AzSATableRow -TableName 'PSRunnerInvocations' -Columns $TableRowColumns -SkipTableCheck | Out-Null
                    }
                #EndRegion
            }

            Write-Output $Output                    
        #EndRegion
    }
#EndRegion

#Region Clone Request
    function Get-ClonedObject {
        [CmdletBinding()]
        param(
            [Parameter(Mandatory=$True)]
            $InputObject
        )

        $NewObject = $InputObject | ConvertTo-Json | ConvertFrom-Json
        $NewObject
    }
#EndRegion

#Region Function Invoke-PSRunner
    function Invoke-PSRunner {
        [CmdletBinding()]
        param(
            $Request,
            $TriggerMetadata
        )

        try {
            #Region Update Invocation Table
                # Assign default CorrelationId if one was not provided
                $Request.Headers.correlationid = $Request.Headers.correlationid ?? (New-Guid).ToString()
                if($env:LOG_PSRUNNER_INVOCATIONS -eq 'True'){
                    $TableRowColumns = @{
                        LastUpdated   = Get-Date -Format "yyyy-MM-ddTHH:mm:ss.fffffffZ" -AsUTC
                        Status        = 'Running'
                        PartitionKey  = $TriggerMetadata.Table.PartitionKey
                        RowKey        = $TriggerMetadata.Table.RowKey
                        CorrelationId = $Request.Headers.correlationid
                    }
                    Update-AzSATableRow -TableName 'PSRunnerInvocations' -Columns $TableRowColumns -SkipTableCheck | Out-Null
                }
            #EndRegion

            #Region Variables
                $Async          = $Request.Headers.async -eq 'True'

                if ($Request.Headers.parameters) {
                    $Params = $Request.Headers.parameters | ForEach-Object{$_ -Replace '"','`"'} 
                }
                if($Request.Headers.params){
                    $Params = $Request.Headers.params     | ForEach-Object{$_ -Replace '"','`"'}
                }

                $PSCommand = Invoke-Expression "{
                    `$Params = `"$Params`" | ConvertFrom-Json -AsHashtable 
                    foreach(`$key in `$Params.Keys){
                        Set-Variable -Name `$key -Value `$Params.`$key
                    }

                    $($Request.Body)
                }"
                
                #Debug
                $DebugPreference     = if($Request.Headers.debug   -eq 'True'){'Continue'}else{'SilentlyContinue'}
                $VerbosePreference   = if($Request.Headers.verbose -eq 'True'){'Continue'}else{'SilentlyContinue'}
            #EndRegion

            #Region Run Command
                $CommandParams = @{
                    ScriptBlock         = $PSCommand
                    NoNewScope          = $true
                    InformationVariable = 'HostOutput'
                    ErrorVariable       = 'ErrorOutput'
                    WarningVariable     = 'WarningOutput'
                    ErrorAction         = 'Continue'
                }
                #Run Command
                $Result = Invoke-Command @CommandParams
            #EndRegion
        }
        catch {
            $E = $_
        }

        #Region HTTP Output
            #Default success Http Status Code
            $body = [ordered]@{
                Result     = $Result
                HostOutput = $HostOutput          | Out-String
                Error      = ($E ?? $ErrorOutput) | Out-String
                Streams    = [ordered]@{
                    Information = $HostOutput
                    Error       = $ErrorOutput | ConvertTo-Json -Depth 1 -EA 'Continue' | ConvertFrom-Json -EA 'Continue'
                    Warning     = $WarningOutput
                }
                CorrelationId = $Request.Headers.correlationid
            }

            #Region Update Invocation Table
                if($env:LOG_PSRUNNER_INVOCATIONS -eq 'True'){
                    try{
                        $TableRowColumns = @{
                            LastUpdated   = Get-Date -Format "yyyy-MM-ddTHH:mm:ss.fffffffZ" -AsUTC
                            CompletedTime = Get-Date -Format "yyyy-MM-ddTHH:mm:ss.fffffffZ" -AsUTC
                            Result        = $Result|ConvertTo-Json -Depth 4 -EA Continue||%{$_?.Substring(0, [Math]::Min($_?.Length, 32000))}
                            Error         = ($E ?? $ErrorOutput)|Out-String||%{$_.Substring(0, [Math]::Min($_.Length, 32000))} 
                            HostOutput    = $HostOutput|Out-String||%{$_.Substring(0, [Math]::Min($_.Length, 32000))}
                            InfoStream    = $HostOutput|ConvertTo-Json -EA Continue||%{$_?.Substring(0, [Math]::Min($_?.Length, 32000))}
                            ErrorStream   = $(try{$ErrorOutput|ConvertTo-Json -EA Continue}catch{$ErrorOutput|Out-String})||%{$_?.Substring(0, [Math]::Min($_?.Length, 32000))}
                            Status        = if($E -or $ErrorOutput){'Error'}else{'Completed'}
                            PartitionKey  = $TriggerMetadata.Table.PartitionKey
                            RowKey        = $TriggerMetadata.Table.RowKey
                        }
                        Update-AzSATableRow -TableName 'PSRunnerInvocations' -Columns $TableRowColumns -SkipTableCheck | Out-Null
                    }catch{
                        $TableRowColumns = @{
                            LastUpdated   = Get-Date -Format "yyyy-MM-ddTHH:mm:ss.fffffffZ" -AsUTC
                            CompletedTime = Get-Date -Format "yyyy-MM-ddTHH:mm:ss.fffffffZ" -AsUTC
                            Result        = ''
                            Error         = "[TableStorageError] Error Occured While Attempting to update table row: $($_|Out-String)"
                            ErrorCode     = 'TableStorageError'    
                            HostOutput    = ''
                            InfoStream    = ''
                            ErrorStream   = ''
                            Status        = ''
                            PartitionKey  = $TriggerMetadata.Table.PartitionKey
                            RowKey        = $TriggerMetadata.Table.RowKey
                        }
                        Update-AzSATableRow -TableName 'PSRunnerInvocations' -Columns $TableRowColumns -SkipTableCheck | Out-Null
                        $ErrorActionPreference = 'Continue'
                        Write-Error "[TableStorageError] Error Occured While Attempting to update table row: $($_|Out-String)"
                    }
                }
            #EndRegion
            Return $body
        #EndRegion
    }
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
#EndRegion

#Region Function New-Error
    function New-Error {
        [cmdletbinding(DefaultParameterSetName="FromNew",PositionalBinding)]
        [OutputType([System.Management.Automation.ErrorRecord])]
        [Alias("N-Exp","New-Er","New-Err")]
        param (
            [Parameter(Mandatory,ValueFromPipeline,ParameterSetName='FromExisting')]
            [Parameter(Mandatory,ValueFromPipeline,ParameterSetName='PrependMessage')]
            [Parameter(Mandatory,ValueFromPipeline,ParameterSetName='PreserveInvocationInfo')]
            [Alias("Er","Error","ErrRec","ERecord","ErrRecord")]
            [ValidateNotNullOrEmpty()]
            [System.Management.Automation.ErrorRecord]
            $ErrorRecord,
            
            [Parameter(Mandatory,ValueFromPipeline,ValueFromPipelineByPropertyName,ParameterSetName='FromNew')]
            [Parameter(ValueFromPipelineByPropertyName,ParameterSetName='FromExisting')]
            [Parameter(Mandatory,ValueFromPipelineByPropertyName,ParameterSetName='PrependMessage')]
            [Parameter(Mandatory, ParameterSetName='PreserveInvocationInfo')]
            [Alias("M","Msg")]
            [ValidateNotNullOrEmpty()]
            [string]
            $Message,
            
            [Parameter(ValueFromPipelineByPropertyName,ParameterSetName='FromExisting')]
            [Parameter(ValueFromPipelineByPropertyName,ParameterSetName='PrependMessage')]
            [Parameter(Mandatory,ValueFromPipelineByPropertyName,ParameterSetName='FromNew')]
            [Alias("TO","TarObj")]
            [ValidateNotNullOrEmpty()]
            [Object]
            $TargetObject,

            [Parameter(ValueFromPipelineByPropertyName,ParameterSetName='FromExisting')]
            [Parameter(ValueFromPipelineByPropertyName,ParameterSetName='PrependMessage')]
            [Parameter(ValueFromPipelineByPropertyName,ParameterSetName='FromNew')]
            [Alias("EId","Id")]
            [ValidateNotNullOrEmpty()]
            [string]
            $ErrorId = $ErrorRecord.FullyQualifiedErrorId ?? "CustomError",
            
            [Parameter(ValueFromPipelineByPropertyName,ParameterSetName='FromExisting')]
            [Parameter(ValueFromPipelineByPropertyName,ParameterSetName='PrependMessage')]
            [Parameter(ValueFromPipelineByPropertyName,ParameterSetName='FromNew')]
            [Alias("EC","ECat","ErrCat","Category")]
            [ValidateNotNullOrEmpty()]
            [ValidateSet('NotSpecified','OpenError','CloseError','DeviceError','DeadlockDetected','InvalidArgument','InvalidData','InvalidOperation','InvalidResult','InvalidType','MetadataError','NotImplemented','NotInstalled','ObjectNotFound','OperationStopped','OperationTimeout','SyntaxError','ParserError','PermissionDenied','ResourceBusy','ResourceExists','ResourceUnavailable','ReadError','WriteError','FromStdErr','SecurityError','ProtocolError','ConnectionError','AuthenticationError','LimitsExceeded','QuotaExceeded','NotEnabled')]
            [System.Management.Automation.ErrorCategory]
            $ErrorCategory = $ErrorRecord.CategoryInfo.Category ?? [System.Management.Automation.ErrorCategory]::NotSpecified,

            [Parameter(ValueFromPipelineByPropertyName,ParameterSetName='FromExisting')]
            [Parameter(ValueFromPipelineByPropertyName,ParameterSetName='PrependMessage')]
            [Parameter(ValueFromPipelineByPropertyName,ParameterSetName='FromNew')]
            [Parameter(ValueFromPipelineByPropertyName,ParameterSetName='PreserveInvocationInfo')]
            [Alias("Ex")]
            [ValidateNotNullOrEmpty()]
            [Exception]
            $Exception,

            [Parameter(Mandatory, ParameterSetName='PrependMessage')]
            [Parameter(ParameterSetName='PreserveInvocationInfo')]
            [Alias("PM","Prepend")]
            [switch]
            $PrependMessage,

            [Parameter(Mandatory, ParameterSetName='PreserveInvocationInfo')]
            [Alias("PI","Preserve","PreserveInv","PreserveInvInfo","KeepInvInfo","PreserveInvocation")]
            [switch]
            $PreserveInvocationInfo,

            [Parameter(ParameterSetName='PreserveInvocationInfo')]
            [switch]
            $Throw
        )

        $ErrorException = $Exception ?? $ErrorRecord.Exception ?? (New-Exception -Message $Message)

        $ErrorMessage = if($ErrorRecord){
            if($PrependMessage){
                $Message + $ErrorRecord.ErrorDetails.Message ?? $ErrorException.Message ?? $ErrorException.InnerException.Message
            }
            elseif ($Message) {
                $Message
            }
            else {
                $ErrorRecord.ErrorDetails.Message ?? $ErrorException.Message
            }
        }
        else{
            $Message
        }

        $NewErrorRecord = if($PreserveInvocationInfo){
            if($Exception){
                [System.Management.Automation.ErrorRecord]::new($ErrorRecord,$Exception)
            }
            else{
                $ErrorRecord
            }
        }
        else{
            [System.Management.Automation.ErrorRecord]::new(
                $ErrorException,
                $ErrorId,
                $ErrorCategory,
                $TargetObject ?? $ErrorRecord.TargetObject
            )
        }
        $NewErrorRecord.ErrorDetails = [System.Management.Automation.ErrorDetails]::new($ErrorMessage)

        if($PreserveInvocationInfo -and $Throw){
            throw $NewErrorRecord
        }else{
            return $NewErrorRecord 
        }
    
    }
    $New_Error = "function New-Error {${Function:New-Error}}"
#EndRegion

#Region Function ConvertFrom-ConnectionString
    function ConvertFrom-ConnectionString{
        [CmdletBinding(DefaultParameterSetName='ReturnAll')]
        [Alias(
            'ConvertFrom-ConString',
            'ConvertFrom-CString',
            'Convert-ConString',
            'Convert-ConStr',
            'CF-ConString',
            'CF-CS',
            'Parse-ConnectionString',
            'Parse-ConString'
        )]
        param(
            [Parameter(ParameterSetName='ReturnString',ValueFromPipeline,Position=1)]
            [Parameter(ParameterSetName='ReturnAll',ValueFromPipeline,Position=1)]
            [Alias('ConnectionString','ConString','Connection','CString','CS')]
            [string]
            $String = $env:AzureWebJobsStorage ?? $env:CONNECTION_STRING,

            [Parameter(ParameterSetName='ReturnString',Mandatory)]
            [ValidateSet('DefaultEndpointsProtocol','AccountName','AccountKey','BlobEndpoint','QueueEndpoint','TableEndpoint')]
            [Alias('Param','Attr','Return','Key')]
            [string]
            $Parameter,

            [Parameter(ParameterSetName='ReturnAll')]
            [Alias('ReturnAll')]
            [switch]
            $All
        )

        $ConArray = $String -split ';' | ConvertFrom-StringData -Delimiter "="

        if('EndpointSuffix' -in $ConArray.keys){
            'Blob','Queue','Table' | ForEach-Object{
                $ConArray += @{$($_+"Endpoint") = "$($ConArray.DefaultEndpointsProtocol)://$($ConArray.AccountName).$($_.ToLower()).$($ConArray.EndpointSuffix)"}
            }
        }

        if($PSCmdlet.ParameterSetName -eq 'ReturnAll'){
            Return $ConArray
        }else{
            Return $ConArray.$Parameter
        }
    }
#EndRegion

#Region Function Get-AzStAcctTable
    function Get-AzStAcctTable{
        [CmdletBinding(DefaultParameterSetName="__AllParameterSets")]
        [Alias(
            'Get-AzStAcctTableEntity',
            'Get-AzSATableEntity',
            'Get-AzStAcctTableRow',
            'Get-AzSATableRow',
            'Get-AzSATable',
            'Get-AzStAcctTables',
            'Get-AzSATables'
        )]
        param(
            [Parameter()]
            [Alias('ConnectionString','CString','String','ConStr')]
            [string]
            $ConString = $env:CONNECTION_STRING ?? $env:AzureWebJobsStorage,

            [Parameter()]
            [string]
            $AccountName = (Convert-ConStr $ConString).AccountName ?? "devstoreaccount1",

            [Parameter()]
            [string]
            $AccountKey = (Convert-ConStr $ConString).AccountKey ?? "Eby8vdM02xNOcqFlqUwJPLlmEtlCDXJ1OUzFT50uSRZ6IFsuFq2UVErCz4I6tq/K1SZFPTOtr/KBHBeksoGMGw==",

            [Parameter(
                HelpMessage="Include the Storage Account Name. Default for local is http://127.0.0.1:10002/devstoreaccount1."
            )]
            [string]
            $BaseURL = (Convert-ConStr $ConString).TableEndpoint ?? "http://127.0.0.1:10002/$AccountName",
            
            [Parameter()]
            [ValidateSet('Azure','Azurite')]
            [Alias('Location','StorageAccountLocation','StorageAccountType','Type')]
            [string]
            $StAcctLocation = $env:STORAGE_TYPE ?? 'Azurite',

            [Parameter()]
            [string]
            $TableName,

            [Parameter()]
            [string]
            $ApiVersion = '2019-07-07',
            
            [Parameter()]
            [ValidateSet(
                'application/json',
                'application/json;odata=nometadata',
                'application/json;odata=minimalmetadata',
                'application/json;odata=fullmetadata'
            )]
            [string]
            $Accept = 'application/json',

            [Parameter()]
            [string]
            $Filter,

            [Parameter()]
            [string]
            $Select,

            [Parameter(ParameterSetName='PartitionRow',Mandatory)]
            [string]
            $RowKey,

            [Parameter(ParameterSetName='PartitionRow',Mandatory)]
            [AllowEmptyString()]
            [string]
            $PartitionKey,

            [Parameter()]
            [ValidateNotNullOrEmpty()]
            [Alias("OutHttpResponse","OutResponseInfo","ResponseInfo","ReturnResponse","IncludeResponse","OutHttpInfo","IncludeHttpResponse","IncludeHttpInfo")]
            [switch]
            $IncludeResponseInfo,
            
            [Parameter()]
            [Alias("Ig","IgE","IgEr","IgError","IgErrors","IgnoreErrors","NoErrors","NoError")]
            [ValidateNotNullOrEmpty()]
            [switch]
            $IgnoreError,

            [Parameter()]
            [ValidateNotNullOrEmpty()]
            [Alias("OutError","RtnErrResponse","RtnErrorResponse","OutErrResponse","OutErrorResponse","ReturnErrors","OuputErrors")]
            [switch]
            $ReturnErrorResponse
        )

        $PartitionRow = if($RowKey){"PartitionKey='$PartitionKey',RowKey='$RowKey'"}else{$null}
        $QueryString  = "?`$filter=$Filter&`$select=$Select"
        $ResourcePath = if($TableName){"/$TableName($PartitionRow)$QueryString"}else{"/Tables()"}

        $TableServiceParams = @{
            ConString      = $ConString
            AccountName    = $AccountName
            AccountKey     = $AccountKey 
            ResourcePath   = $ResourcePath
            Method         = 'GET'
            BaseURL        = $BaseURL
            ApiVersion     = $ApiVersion
            Accept         = $Accept
            StAcctLocation = $StAcctLocation
            InvocationName = $PSCmdlet.MyInvocation.InvocationName
            IgnoreError    = $IgnoreError
            OutError       = $ReturnErrorResponse
            OutHttpInfo    = $IncludeResponseInfo
        }
        $Result = Invoke-AzStAcctTableService @TableServiceParams -ErrorVariable 'ErrorStream' -ErrorAction SilentlyContinue

        if ($ErrorStream -and !$ReturnErrorResponse){
            if($IgnoreError){
                Return $null
            }
            else{
                $ErrorRecord = New-Error -ErrorRecord ($ErrorStream | Select-Object -Last 1)
                Return Write-Error $ErrorRecord
            }
        }else{
            # Display the response
            return $Result
        }

    }
#EndRegion

#Region Function Set-AzStAcctTable
    function Set-AzStAcctTable{
        [CmdletBinding(DefaultParameterSetName="__AllParameterSets")]
        [Alias(
            'Add-AzStAcctTableEntity',
            'Add-AzSATableEntity',
            'New-AzStAcctTableEntity',
            'New-AzSATableEntity',
            'Update-AzStAcctTableEntity',
            'Update-AzSATableEntity',
            'Set-AzStAcctTableEntity',
            'Set-AzSATableEntity',
            'New-AzStAcctTableRow',
            'New-AzSATableRow',
            'Add-AzStAcctTableRow',
            'Add-AzSATableRow',
            'Update-AzStAcctTableRow',
            'Update-AzSATableRow',
            'Set-AzStAcctTableRow',
            'Set-AzSATableRow',
            'New-AzStAcctTable',
            'New-AzSATable',
            'Update-AzStAcctTable',
            'Update-AzSATable'
        )]
        param(
            [Parameter()]
            [Alias('ConnectionString','CString','String','ConStr')]
            [string]
            $ConString = $env:CONNECTION_STRING ?? $env:AzureWebJobsStorage,

            [Parameter()]
            [string]
            $AccountName = (Convert-ConStr $ConString).AccountName ?? "devstoreaccount1",

            [Parameter()]
            [string]
            $AccountKey = (Convert-ConStr $ConString).AccountKey ?? "Eby8vdM02xNOcqFlqUwJPLlmEtlCDXJ1OUzFT50uSRZ6IFsuFq2UVErCz4I6tq/K1SZFPTOtr/KBHBeksoGMGw==",

            [Parameter(
                HelpMessage="Include the Storage Account Name. Default for local is http://127.0.0.1:10002/devstoreaccount1."
            )]
            [string]
            $BaseURL = (Convert-ConStr $ConString).TableEndpoint ?? "http://127.0.0.1:10002/$AccountName",
            
            [Parameter()]
            [ValidateSet('Azure','Azurite')]
            [Alias('Location','StorageAccountLocation','StorageAccountType','Type')]
            [string]
            $StAcctLocation = $env:STORAGE_TYPE ?? 'Azurite',

            [Parameter(Mandatory)]
            [string]
            $TableName,

            [Parameter()]
            [Alias('EntityProperties','Body','EntityBody','EntityColumns','Columns','RowValues')]
            [hashtable]
            $Properties,

            [Parameter()]
            [string]
            $RowKey       = $Properties.RowKey,

            [Parameter()]
            [AllowEmptyString()]
            [string]
            $PartitionKey = $Properties.PartitionKey,

            [Parameter()]
            [string]
            $Filter,

            [Parameter()]
            [string]
            $ApiVersion = '2019-07-07',

            [Parameter()]
            [ValidateSet('return-no-content','return-content')]
            [string]
            $Prefer = 'return-content',

            [Parameter()]
            [ValidateNotNullOrEmpty()]
            [Alias("OutHttpResponse","OutResponseInfo","ResponseInfo","ReturnResponse","IncludeResponse","OutHttpInfo","IncludeHttpResponse","IncludeHttpInfo")]
            [switch]
            $IncludeResponseInfo,


            [Parameter()]
            [Alias("Ig","IgE","IgEr","IgError","IgErrors","IgnoreErrors","NoErrors","NoError")]
            [ValidateNotNullOrEmpty()]
            [switch]
            $IgnoreError,

            [Parameter()]
            [ValidateNotNullOrEmpty()]
            [Alias("OutError","RtnErrResponse","RtnErrorResponse","OutErrResponse","OutErrorResponse","ReturnErrors","OuputErrors")]
            [switch]
            $ReturnErrorResponse,

            [Parameter()]
            [Alias("SkipExistingTableCheck")]
            [switch]
            $SkipTableCheck
            
        )

        #Region Storage Account API Params
            $Result = $null
            $StAcctParams = @{
                ConString      = $ConString
                AccountName    = $AccountName
                AccountKey     = $AccountKey
                BaseURL        = $BaseURL
                Type           = $StAcctLocation
                ApiVersion     = $ApiVersion
                ErrorVariable  = 'ErrorStream'
                ErrorAction    = 'SilentlyContinue'
            }
            $InvocationName = $PSCmdlet.MyInvocation.InvocationName
        #EndRegion
        
        #Region Search for Existing Table
            if(!$SkipTableCheck){
                $Result = Get-AzStAcctTable  @StAcctParams -TableName $TableName -Filter $Filter -OutError -OutHttpInfo
                if (!$Result -or !$Result.HttpResponse.Body -or ($Result.Error -and $Result.Error.Code -ne "TableNotFound")){
                    if($Result.HttpResponse.Body.StatusCode -and $Result.HttpResponse.Body.StatusCode -notin 200..299){
                        $ErrCode    = $Result.Error.Code
                        $ErrMessage = $Result.Error.Message
                        $ErrorMessage = "[$InvocationName] In Response to the HTTP Request to retrieve info about Storage Account Table '$TableName' a status code was returned that did not indicate Success: [$($Result.HttpResponse.StatusCode)$($ErrCode ? " - $ErrCode" : $null)] $(($ErrMessage ?? $Result.HttpResponse.Body | Out-string).ReplaceLineEndings(' '))"
                    }else {
                        $ErrCode    = "NullResponseCode"
                        $ErrMessage = "Unkown Error Occured"
                        $ErrorMessage = "[$InvocationName] Unable to process the response to the HTTP Request to retrieve info about Storage Account Table '$TableName': $($ErrCode ? "[$ErrCode]" : $null) $ErrMessage"
                    }
                    if($IgnoreError){
                        Write-Debug $ErrorMessage
                        Return $null
                    }
                    elseif($ReturnErrorResponse){
                        $Result.ErrorMessage = $ErrorMessage
                        Return $Result
                    }else{
                        return Write-Error -Message $ErrorMessage
                    }
                }
                $Entities = $Result.HttpResponse.Body.Value
                if($Properties -and $Filter -and $Result.Error.Code -ne "TableNotFound"){
                    if(!$Entities -or $Entities.Length -gt 1){
                        if(!$Entities){
                            $ErrCode    = 'RetrievedEmptyArray'
                            $ErrMessage = 'No table entities were found that matched your filter query statement.'
                        }else{
                            $ErrCode    = 'ResultsGreaterThanOne'
                            $ErrMessage = 'More than one table entity matched your filter query statement. Provide a more restrictive filter query.'
                        }
                        $ErrorMessage =  "[$InvocationName] While Attempting to retrieve a table entity using filter `"$Filter`" an incorrect number of results was retrieved: [$ErrCode] $ErrMessage"
                        if($IgnoreError){
                            Write-Debug $ErrorMessage
                            Return $null
                        }
                        elseif($ReturnErrorResponse){
                            $Result.ErrorMessage = $ErrorMessage
                            Return $Result
                        }else{
                            return Write-Error -Message $ErrorMessage
                        }
                    }else{
                        $PartitionKey = $Entities.PartitionKey
                        $RowKey       = $Entities.RowKey
                    }
                    
                }
            }
        #EndRegion
        
        #Region Create Table if None is Found
            if($Result.Error.Code -eq "TableNotFound" -or ($SkipTableCheck -and !$Properties)){
                #Region Create Table
                    $TableServiceParams = @{
                        ResourcePath   = '/Tables'
                        Method         = 'POST'
                        Body           = @{TableName = $TableName} | ConvertTo-Json
                        Prefer         = $Prefer
                        InvocationName = $PSCmdlet.MyInvocation.InvocationName
                        IgnoreError    = $IgnoreError
                        OutError       = $ReturnErrorResponse
                        OutHttpInfo    = $IncludeResponseInfo
                    }
                    $Result = Invoke-AzStAcctTableService @TableServiceParams  @StAcctParams
                #EndRegion

                #Region Output
                    if ($ErrorStream){
                        if($IgnoreError){
                            Return $null
                        }
                        elseif($ReturnErrorResponse){
                            return $Result
                        }else{
                            $ErrorRecord = New-Error -ErrorRecord ($ErrorStream | Select-Object -Last 1)
                            Return Write-Error $ErrorRecord
                        }
                    }elseif(!$Properties){
                        # Display the response
                        return $Result
                    }
                #EndRegion
            }
        #EndRegion
        
        #Region Add/Update Table Entity
            if($Properties){
                #Region Set Row and Partition Keys
                    if(!$RowKey){
                        if($SkipTableCheck){
                            $ErrCode    = 'NowRowKeySupplied'
                            $ErrMessage = 'No Row Key was supplied and SkipTableCheck is $true. Please specify a Row Key or remove the SkipTableCheck Switch.'
                            $ErrorMessage =  "[$InvocationName] Unable to Create or Update table entity with the parameters provided: [$ErrCode] $ErrMessage"
                            if($IgnoreError){
                                Write-Debug $ErrorMessage
                                Return $null
                            }
                            elseif($ReturnErrorResponse){
                                $Result.ErrorMessage = $ErrorMessage
                                Return $Result
                            }else{
                                return Write-Error -Message $ErrorMessage
                            }
                        }
                        $Rows    = $Entities | Where-Object{$null -ne ($_.rowkey -as [Int])} 
                        $LastRow = $Rows | Where-Object{[int]$_.rowkey -eq ($Rows.rowkey | Measure-Object -Maximum).Maximum}
                        $digits  = if($LastRow.rowkey.length -le 1){16}else{$LastRow.rowkey.length}
                        $RowKey  = "{0:d$($digits)}" -f (([int]$LastRow.rowkey) + 1)
                    }

                    $PartitionKey = if(!$PartitionKey -and $LastRow.PartitionKey){$LastRow.PartitionKey}else{$PartitionKey}

                    $PartitionRow = "PartitionKey='$PartitionKey',RowKey='$RowKey'"

                    $Properties.PartitionKey = $PartitionKey
                    $Properties.RowKey       = $RowKey
                #EndRegion

                #Region Invoke Table Service
                    $TableServiceParams = @{
                        ResourcePath   = "/$TableName($PartitionRow)"
                        Method         = 'MERGE'
                        Body           = $Properties | ConvertTo-Json
                        Prefer         = 'return-content'
                        IgnoreError    = $IgnoreError
                        OutError       = $ReturnErrorResponse
                        OutHttpInfo    = $IncludeResponseInfo
                        InvocationName = $PSCmdlet.MyInvocation.InvocationName
                    }
                    $Result = Invoke-AzStAcctTableService @TableServiceParams @StAcctParams
                #EndRegion
                
                #Region Output 
                    if ($ErrorStream -and !$ReturnErrorResponse){
                        if($IgnoreError){
                            Return $null
                        }
                        else{
                            $ErrorRecord = New-Error -ErrorRecord ($ErrorStream | Select-Object -Last 1)
                            Return Write-Error $ErrorRecord
                        }
                    }else{
                        if($Prefer = 'return-content'){
                            if($Result -is [hashtable]){
                                $Result.TableName    = $TableName
                                $Result.RowKey       = $RowKey
                                $Result.PartitionKey = $PartitionKey
                                $Return = $Result
                            }else{
                                $Return = @{
                                    TableName    = $TableName
                                    RowKey       = $RowKey
                                    PartitionKey = $PartitionKey
                                }
                                if($Result){$Return.Result = $Result}
                            }
                            return $Return
                        }
                        # Display the response
                        return $Result
                    }
                #EndRegion
            }
        #EndRegion
    }
#EndRegion

#Region Function Remove-AzStAcctTable
    function Remove-AzStAcctTable{
        [CmdletBinding(DefaultParameterSetName="__AllParameterSets")]
        [Alias(
            'Remove-AzSATable'
        )]
        param(
            [Parameter()]
            [Alias('ConnectionString','CString','String','ConStr')]
            [string]
            $ConString = $env:CONNECTION_STRING ?? $env:AzureWebJobsStorage,

            [Parameter()]
            [string]
            $AccountName = (Convert-ConStr $ConString).AccountName ?? "devstoreaccount1",

            [Parameter()]
            [string]
            $AccountKey = (Convert-ConStr $ConString).AccountKey ?? "Eby8vdM02xNOcqFlqUwJPLlmEtlCDXJ1OUzFT50uSRZ6IFsuFq2UVErCz4I6tq/K1SZFPTOtr/KBHBeksoGMGw==",

            [Parameter(
                HelpMessage="Include the Storage Account Name. Default for local is http://127.0.0.1:10002/devstoreaccount1."
            )]
            [string]
            $BaseURL = (Convert-ConStr $ConString).TableEndpoint ?? "http://127.0.0.1:10002/$AccountName",
            
            [Parameter()]
            [ValidateSet('Azure','Azurite')]
            [Alias('Location','StorageAccountLocation','StorageAccountType','Type')]
            [string]
            $StAcctLocation = $env:STORAGE_TYPE ?? 'Azurite',

            [Parameter(Mandatory)]
            [string]
            $TableName,

            [Parameter()]
            [string]
            $ApiVersion = '2019-07-07',

            [Parameter()]
            [ValidateNotNullOrEmpty()]
            [Alias("OutHttpResponse","OutResponseInfo","ResponseInfo","ReturnResponse","IncludeResponse","OutHttpInfo","IncludeHttpResponse","IncludeHttpInfo")]
            [switch]
            $IncludeResponseInfo,


            [Parameter()]
            [Alias("Ig","IgE","IgEr","IgError","IgErrors","IgnoreErrors","NoErrors","NoError")]
            [ValidateNotNullOrEmpty()]
            [switch]
            $IgnoreError,

            [Parameter()]
            [ValidateNotNullOrEmpty()]
            [Alias("OutError","RtnErrResponse","RtnErrorResponse","OutErrResponse","OutErrorResponse","ReturnErrors","OuputErrors")]
            [switch]
            $ReturnErrorResponse
        )

        $TableServiceParams = @{
            ConString      = $ConString
            AccountName    = $AccountName
            AccountKey     = $AccountKey 
            ResourcePath   = "/Tables('$TableName')"
            Method         = 'DELETE'
            BaseURL        = $BaseURL
            ApiVersion     = $ApiVersion
            ContentType    = 'application/json'
            StAcctLocation = $StAcctLocation
            InvocationName = $PSCmdlet.MyInvocation.InvocationName
            IgnoreError    = $IgnoreError
            OutError       = $ReturnErrorResponse
            ErrorVariable  = 'ErrorStream'
            ErrorAction    = 'SilentlyContinue'
            OutHttpInfo    = $IncludeResponseInfo
        }
        $Result = Invoke-AzStAcctTableService @TableServiceParams

        if ($ErrorStream -and !$ReturnErrorResponse){
            if($IgnoreError){
                Return $null
            }
            else{
                $ErrorRecord = New-Error -ErrorRecord ($ErrorStream | Select-Object -Last 1)
                Return Write-Error $ErrorRecord
            }
        }else{
            # Display the response
            return $Result
        }
    }
#EndRegion

#Region Function Invoke-AzStAcctTableService
    function Invoke-AzStAcctTableService{
        [CmdletBinding()]
        [Alias('Invoke-AzSATableService')]
        param(
            [Parameter()]
            [Alias('ConnectionString','CString','String','ConStr')]
            [string]
            $ConString = $env:CONNECTION_STRING ?? $env:AzureWebJobsStorage,

            [Parameter()]
            [string]
            $AccountName = (Convert-ConStr $ConString).AccountName ?? "devstoreaccount1",

            [Parameter()]
            [string]
            $AccountKey = (Convert-ConStr $ConString).AccountKey ?? "Eby8vdM02xNOcqFlqUwJPLlmEtlCDXJ1OUzFT50uSRZ6IFsuFq2UVErCz4I6tq/K1SZFPTOtr/KBHBeksoGMGw==",

            [Parameter(
                HelpMessage="Include the Storage Account Name. Default for local is http://127.0.0.1:10002/devstoreaccount1."
            )]
            [string]
            $BaseURL = (Convert-ConStr $ConString).TableEndpoint ?? "http://127.0.0.1:10002/$AccountName",

            [Parameter()]
            [ValidateSet('Azure','Azurite')]
            [Alias('Location','StorageAccountLocation','StorageAccountType','Type')]
            [string]
            $StAcctLocation = $env:STORAGE_TYPE ?? 'Azurite',

            [Parameter()]
            [string]
            $ResourcePath = "/Tables",

            [Parameter()]
            [ValidateSet("GET","POST","DELETE","PATCH","PUT","MERGE")]
            [string]
            $Method = "GET",

            [Parameter()]
            [string]
            $ApiVersion = '2019-07-07',

            [Parameter()]
            [ValidateSet(
                'application/json',
                'application/json;odata=nometadata',
                'application/json;odata=minimalmetadata',
                'application/json;odata=fullmetadata'
            )]
            [string]
            $ContentType = 'application/json',

            [Parameter()]
            [string]
            $Body,

            [Parameter()]
            [ValidateSet(
                'application/json',
                'application/json;odata=nometadata',
                'application/json;odata=minimalmetadata',
                'application/json;odata=fullmetadata'
            )]
            [string]
            $Accept = 'application/json',

            [Parameter()]
            [ValidateSet('return-no-content','return-content')]
            [string]
            $Prefer,

            [Parameter()]
            [Alias("Ig","IgE","IgEr","IgError","IgErrors","IgnoreErrors","NoErrors","NoError")]
            [ValidateNotNullOrEmpty()]
            [switch]
            $IgnoreError,

            [Parameter()]
            [ValidateNotNullOrEmpty()]
            [Alias("OutHttpResponse","OutResponseInfo","ResponseInfo","ReturnResponse","IncludeResponse","OutHttpInfo","IncludeHttpResponse","IncludeHttpInfo")]
            [switch]
            $IncludeResponseInfo,

            [Parameter()]
            [ValidateNotNullOrEmpty()]
            [Alias("OutError","RtnErrResponse","RtnErrorResponse","OutErrResponse","OutErrorResponse","ReturnErrors","OuputErrors")]
            [switch]
            $ReturnErrorResponse,

            [Parameter()]
            [ValidateNotNullOrEmpty()]
            [Alias("CmdletName",'Cmdlet','FunctionName')]
            $InvocationName = $PSCmdlet.MyInvocation.InvocationName
        )

        $CanonicalizedResourcePath = if($ResourcePath -match "\?"){
            $ResourceArray = $ResourcePath -split '\?'
            if($ResourcePath -match "comp="){
                $ResourceArray[0]+"?$($ResourceArray[1] -split '&' | Where-Object{$_ -match "comp="})"
            }else{
                $ResourceArray[0]
            }
        }else{
            $ResourcePath
        }

        # Generate SharedKeyLite for authentication
        $GMTTime = (Get-Date).ToUniversalTime().ToString('R')
        if($StAcctLocation -eq 'Azurite'){
            $StringToSign = "$GMTTime`n/$AccountName/$AccountName$CanonicalizedResourcePath"
        }else{
            $StringToSign = "$GMTTime`n/$AccountName$CanonicalizedResourcePath"
        }

        $byteKey         = [System.Convert]::FromBase64String($accountKey)
        $hasher          = New-Object System.Security.Cryptography.HMACSHA256
        $hasher.Key      = $byteKey
        $signedSignature = [System.Convert]::ToBase64String($hasher.ComputeHash([Text.Encoding]::UTF8.GetBytes($stringToSign)))


        $InvocationParams = @{
            Uri     = $BaseURL + $ResourcePath
            Method  = $Method
            Body    = $Body
            Headers = @{
                'x-ms-date'      = $GMTTime
                'x-ms-version'   = $ApiVersion
                'Authorization'  = "SharedKeyLite $AccountName`:$signedSignature"
                'Content-Type'   = $ContentType
                'Accept'         = $Accept
            }
            StatusCodeVariable      = 'StatusCode'
            ResponseHeadersVariable = 'ResponseHeaders'
            SkipHttpErrorCheck      = $True
        }

        if($Prefer){$InvocationParams.Headers.Prefer = $Prefer}
        
        # Invoke the method
        $response = Invoke-RestMethod @InvocationParams

        $ReturnHash = @{
            HttpResponse = @{
                StatusCode = $StatusCode
                Headers    = $ResponseHeaders
                Body       = $response
            }
        }

        if ($StatusCode -notin 200..299){
            $ErrCode    = $response.'odata.error'.code ?? $response.error.code
            $ErrMessage = $response.'odata.error'.message.value ?? $response.error.message
            $ErrorMessage = "[$InvocationName] In Response to the HTTP Request a status code was returned that did not indicate Success: [$($StatusCode)$($ErrCode ? " - $ErrCode" : $null)] $(($ErrMessage ?? $response | Out-string).ReplaceLineEndings(' '))"
            if($IgnoreError){
                Write-Debug $ErrorMessage
                Return $null
            }
            elseif($ReturnErrorResponse){
                $ReturnHash.ErrorMessage = $ErrorMessage
                $ReturnHash.Error = @{
                    Code    = $ErrCode
                    Message = $ErrMessage
                }
                Return $ReturnHash
            }else{
                return Write-Error -Message $ErrorMessage
            }
        }else{
            if($IncludeResponseInfo){
                Return $ReturnHash
            }else{
                return $response
            }
        }
    }
#EndRegion

#Region Function Get-AzStAcctBlob
    function Get-AzStAcctBlob{
        [CmdletBinding(DefaultParameterSetName="__AllParameterSets")]
        [Alias(
            'Get-AzStAcctBlobContainer',
            'Get-AzSABlobContainer',
            'Get-StAcctContainer',
            'Get-AzSAContainer',
            'Get-StAcctContainers',
            'Get-AzSAContainers',
            'Get-AzStAcctBlobContainers',
            'Get-AzSABlobContainers',
            'Get-AzSABlob',
            'Get-AzStAcctBlobs',
            'Get-AzSABlobs'
        )]
        param(
            [Parameter()]
            [Alias('ConnectionString','CString','String','ConStr')]
            [string]
            $ConString = $env:CONNECTION_STRING ?? $env:AzureWebJobsStorage,

            [Parameter()]
            [string]
            $AccountName = (Convert-ConStr $ConString).AccountName ?? "devstoreaccount1",

            [Parameter()]
            [string]
            $AccountKey = (Convert-ConStr $ConString).AccountKey ?? "Eby8vdM02xNOcqFlqUwJPLlmEtlCDXJ1OUzFT50uSRZ6IFsuFq2UVErCz4I6tq/K1SZFPTOtr/KBHBeksoGMGw==",

            [Parameter(
                HelpMessage="Include the Storage Account Name. Default for local is http://127.0.0.1:10000/devstoreaccount1."
            )]
            [string]
            $BaseURL = (Convert-ConStr $ConString).BlobEndpoint ?? "http://127.0.0.1:10000/$AccountName",
            
            [Parameter()]
            [ValidateSet('Azure','Azurite')]
            [Alias('Location','StorageAccountLocation','StorageAccountType','Type')]
            [string]
            $StAcctLocation = $env:STORAGE_TYPE ?? 'Azurite',

            [Parameter()]
            [string]
            $ContainerName,

            [Parameter()]
            [string]
            $BlobName,

            [Parameter()]
            [string]
            $ApiVersion = '2019-07-07',
            
            [Parameter()]
            [string]
            $Accept,

            [Parameter()]
            [ValidateNotNullOrEmpty()]
            [Alias("OutHttpResponse","OutResponseInfo","ResponseInfo","ReturnResponse","IncludeResponse","OutHttpInfo","IncludeHttpResponse","IncludeHttpInfo")]
            [switch]
            $IncludeResponseInfo,
            
            [Parameter()]
            [Alias("Ig","IgE","IgEr","IgError","IgErrors","IgnoreErrors","NoErrors","NoError")]
            [ValidateNotNullOrEmpty()]
            [switch]
            $IgnoreError,

            [Parameter()]
            [ValidateNotNullOrEmpty()]
            [Alias("OutError","RtnErrResponse","RtnErrorResponse","OutErrResponse","OutErrorResponse","ReturnErrors","OuputErrors")]
            [switch]
            $ReturnErrorResponse,

            [Parameter()]
            [ValidateNotNullOrEmpty()]
            [Alias('OutRaw','OutputRawcontent','OutRawContent','DontProcessOutput','InvokeWebRequest')]
            [switch]
            $Raw,

            [Parameter()]
            [ValidateNotNullOrEmpty()]
            [Alias()]
            [switch]
            $ReturnEntireXMLObject
        )

        $ResourcePath = if(!$ContainerName){
            if($StAcctLocation -eq 'Azure'){
                '/?comp=list'
            }else{
                '?comp=list'
            }
        }elseif(!$BlobName){
            "/$ContainerName`?comp=list&restype=container"
        }else{
            "/$ContainerName/$BlobName"
        }

        $BlobServiceParams = @{
            ConString      = $ConString
            AccountName    = $AccountName
            AccountKey     = $AccountKey 
            ResourcePath   = $ResourcePath
            Method         = 'GET'
            BaseURL        = $BaseURL
            ApiVersion     = $ApiVersion
            StAcctLocation = $StAcctLocation
            InvocationName = $PSCmdlet.MyInvocation.InvocationName
            IgnoreError    = $IgnoreError
            OutError       = $ReturnErrorResponse
            OutHttpInfo    = $IncludeResponseInfo
            Raw            = $Raw
        }
        if($Accept){$BlobServiceParams.Accept = $Accept}
        $Result = Invoke-AzStAcctBlobService @BlobServiceParams -ErrorVariable 'ErrorStream' -ErrorAction SilentlyContinue

        if ($ErrorStream -and !$ReturnErrorResponse){
            if($IgnoreError){
                Return $null
            }
            else{
                $ErrorRecord = New-Error -ErrorRecord ($ErrorStream | Select-Object -Last 1)
                Return Write-Error $ErrorRecord
            }
        }else{
            if(!$ReturnEntireXMLObject -and (!$ContainerName -or !$BlobName) -and !$ErrorStream -and !$Raw){
                if(!$ContainerName){
                    return $Result.EnumerationResults.Containers.Container
                }elseif(!$BlobName){
                    return $Result.EnumerationResults.Blobs.Blob
                }
            }else{
                #Display the response
                return $Result
            }
            
        }

    }
#EndRegion

#Region Function Set-AzStAcctBlob
    function Set-AzStAcctBlob{
        [CmdletBinding(DefaultParameterSetName="__AllParameterSets")]
        [Alias(
            'Set-AzStAcctBlobContainer',
            'Set-AzSABlobContainer',
            'New-AzStAcctBlobContainer',
            'New-AzSABlobContainer',
            'Add-AzStAcctBlobContainer',
            'Add-AzSABlobContainer',
            'Update-AzStAcctBlobContainer',
            'Update-AzSABlobContainer',
            'Replace-AzStAcctBlobContainer',
            'Replace-AzSABlobContainer',
            'Set-StAcctContainer',
            'Set-AzSAContainer',
            'New-StAcctContainer',
            'New-AzSAContainer',
            'Add-StAcctContainer',
            'Add-AzSAContainer',
            'Update-StAcctContainer',
            'Update-AzSAContainer',
            'Replace-StAcctContainer',
            'Replace-AzSAContainer',
            'Set-AzSABlob',
            'New-AzStAcctBlob',
            'New-AzSABlob',
            'Add-AzStAcctBlob',
            'Add-AzSABlob',
            'Update-AzStAcctBlob',
            'Update-AzSABlob',
            'Replace-AzStAcctBlob',
            'Replace-AzSABlob'
        )]
        param(
            [Parameter()]
            [Alias('ConnectionString','CString','String','ConStr')]
            [string]
            $ConString = $env:CONNECTION_STRING ?? $env:AzureWebJobsStorage,

            [Parameter()]
            [string]
            $AccountName = (Convert-ConStr $ConString).AccountName ?? "devstoreaccount1",

            [Parameter()]
            [string]
            $AccountKey = (Convert-ConStr $ConString).AccountKey ?? "Eby8vdM02xNOcqFlqUwJPLlmEtlCDXJ1OUzFT50uSRZ6IFsuFq2UVErCz4I6tq/K1SZFPTOtr/KBHBeksoGMGw==",

            [Parameter(
                HelpMessage="Include the Storage Account Name. Default for local is http://127.0.0.1:10000/devstoreaccount1."
            )]
            [string]
            $BaseURL = (Convert-ConStr $ConString).BlobEndpoint ?? "http://127.0.0.1:10000/$AccountName",
            
            [Parameter()]
            [ValidateSet('Azure','Azurite')]
            [Alias('Location','StorageAccountLocation','StorageAccountType','Type')]
            [string]
            $StAcctLocation = $env:STORAGE_TYPE ?? 'Azurite',

            [Parameter()]
            [string]
            $ContainerName,

            [Parameter()]
            [string]
            $BlobName,

            [Parameter()]
            $File,

            [Parameter()]
            $Content,

            [Parameter()]
            [ValidateSet('BlockBlob','PageBlob','AppendBlob')]
            [string]
            $BlobType,

            [Parameter()]
            [string]
            $ApiVersion = '2019-07-07',
            
            [Parameter()]
            [AllowEmptyString()]
            [string]
            $ContentType,

            [Parameter()]
            [ValidateNotNullOrEmpty()]
            [Alias("OutHttpResponse","OutResponseInfo","ResponseInfo","ReturnResponse","IncludeResponse","OutHttpInfo","IncludeHttpResponse","IncludeHttpInfo")]
            [switch]
            $IncludeResponseInfo,
            
            [Parameter()]
            [Alias("Ig","IgE","IgEr","IgError","IgErrors","IgnoreErrors","NoErrors","NoError")]
            [ValidateNotNullOrEmpty()]
            [switch]
            $IgnoreError,

            [Parameter()]
            [ValidateNotNullOrEmpty()]
            [Alias("OutError","RtnErrResponse","RtnErrorResponse","OutErrResponse","OutErrorResponse","ReturnErrors","OuputErrors")]
            [switch]
            $ReturnErrorResponse,

            [Parameter()]
            [ValidateNotNullOrEmpty()]
            [Alias('OutRaw','OutputRawcontent','OutRawContent','DontProcessOutput','InvokeWebRequest')]
            [switch]
            $Raw
        )

        $ResourcePath = if(!$ContainerName){

        }elseif(!$BlobName){
            "/$ContainerName`?restype=container"
            $Method      = 'PUT'
            $ContentType = ''
            $Body        = ''
        }else{
            $ContentType = if(!$ContentType){'application/octet-stream'}else{$ContentType}
            "/$ContainerName/$BlobName"
            $Method = 'PUT'
            $Body = if($ContentType -eq 'application/octet-stream' -and $Content -is [string]){
                [System.Text.Encoding]::UTF8.GetBytes($Content)
            }else{
                $Content
            }
            $BlobType = if(!$BlobType){'BlockBlob'}else{$BlobType}
        }

        $BlobServiceParams = @{
            ConString      = $ConString
            AccountName    = $AccountName
            AccountKey     = $AccountKey 
            ResourcePath   = $ResourcePath
            Method         = $Method
            Body           = $Body
            File           = $file
            BaseURL        = $BaseURL
            ContentType    = $ContentType
            ApiVersion     = $ApiVersion
            StAcctLocation = $StAcctLocation
            InvocationName = $PSCmdlet.MyInvocation.InvocationName
            IgnoreError    = $IgnoreError
            OutError       = $ReturnErrorResponse
            OutHttpInfo    = $IncludeResponseInfo
            Raw            = $Raw
        }
        if($BlobType){$BlobServiceParams.BlobType = $BlobType}
        $Result = Invoke-AzStAcctBlobService @BlobServiceParams -ErrorVariable 'ErrorStream' -ErrorAction SilentlyContinue

        if ($ErrorStream -and !$ReturnErrorResponse){
            if($IgnoreError){
                Return $null
            }
            else{
                $ErrorRecord = New-Error -ErrorRecord ($ErrorStream | Select-Object -Last 1)
                Return Write-Error $ErrorRecord
            }
        }else{
            return $Result
        }

    }
#EndRegion

#Region Function Invoke-AzStAcctBlobService
    function Invoke-AzStAcctBlobService{
        [CmdletBinding()]
        [Alias(
            'Invoke-AzSABlobService',
            'Invoke-AzStAcctBlob',
            'Invoke-AzSABlob'
        )]
        param(
            [Parameter()]
            [Alias('ConnectionString','CString','String','ConStr')]
            [string]
            $ConString = $env:CONNECTION_STRING ?? $env:AzureWebJobsStorage,

            [Parameter()]
            [string]
            $AccountName = (Convert-ConStr $ConString).AccountName ?? "devstoreaccount1",

            [Parameter()]
            [string]
            $AccountKey = (Convert-ConStr $ConString).AccountKey ?? "Eby8vdM02xNOcqFlqUwJPLlmEtlCDXJ1OUzFT50uSRZ6IFsuFq2UVErCz4I6tq/K1SZFPTOtr/KBHBeksoGMGw==",

            [Parameter(
                HelpMessage="Include the Storage Account Name. Default for local is http://127.0.0.1:10000/devstoreaccount1."
            )]
            [string]
            $BaseURL = (Convert-ConStr $ConString).BlobEndpoint ?? "http://127.0.0.1:10000/$AccountName",

            [Parameter()]
            [ValidateSet('Azure','Azurite')]
            [Alias('Location','StorageAccountLocation','StorageAccountType','Type')]
            [string]
            $StAcctLocation = $env:STORAGE_TYPE ?? 'Azurite',

            [Parameter()]
            [string]
            $ResourcePath = "/?comp=list",

            [Parameter()]
            [ValidateSet("GET","POST","DELETE","PATCH","PUT","MERGE")]
            [string]
            $Method = "GET",

            [Parameter()]
            [string]
            $ApiVersion = '2019-07-07',

            [Parameter()]
            [AllowEmptyString()]
            [string]
            $ContentType,

            [Parameter()]
            $File,

            [Parameter()]
            $Body,

            [Parameter()]
            $ContentLength = $(if($Body.Length){$Body.Length}elseif($File){$(Get-Item $File).Length}else{$null}),

            [Parameter()]
            [AllowEmptyString()]
            [string]
            $Accept,

            [Parameter()]
            [ValidateSet('BlockBlob','PageBlob','AppendBlob')]
            [string]
            $BlobType,

            [Parameter()]
            [Alias("Ig","IgE","IgEr","IgError","IgErrors","IgnoreErrors","NoErrors","NoError")]
            [ValidateNotNullOrEmpty()]
            [switch]
            $IgnoreError,

            [Parameter()]
            [ValidateNotNullOrEmpty()]
            [Alias("OutHttpResponse","OutResponseInfo","ResponseInfo","ReturnResponse","IncludeResponse","OutHttpInfo","IncludeHttpResponse","IncludeHttpInfo")]
            [switch]
            $IncludeResponseInfo,

            [Parameter()]
            [ValidateNotNullOrEmpty()]
            [Alias("OutError","RtnErrResponse","RtnErrorResponse","OutErrResponse","OutErrorResponse","ReturnErrors","OuputErrors")]
            [switch]
            $ReturnErrorResponse,

            [Parameter()]
            [ValidateNotNullOrEmpty()]
            [Alias("CmdletName",'Cmdlet','FunctionName')]
            $InvocationName = $PSCmdlet.MyInvocation.InvocationName,

            [Parameter()]
            [ValidateNotNullOrEmpty()]
            [Alias('OutRaw','OutputRawcontent','OutRawContent','DontProcessOutput','InvokeWebRequest')]
            [switch]
            $Raw
        )

        $CanonicalizedResourcePath = $ResourcePath -replace "\?","`n" -replace "=",":" -replace "&","`n"
        if($StAcctLocation -eq 'Azurite'){
            $CanonicalizedResource = "/$AccountName/$AccountName$CanonicalizedResourcePath"
        }else{
            $CanonicalizedResource = "/$AccountName$CanonicalizedResourcePath"
        }
        $CanonBlobType  = if($BlobType){"x-ms-blob-type:$BlobType`n"}
        $GMTTime        = (Get-Date).ToUniversalTime().ToString('R')
        $CType          = if($Method -eq 'GET'){$Accept}else{$ContentType}
        $ContentMD5     = ""
        $Date           = ""
        $CanonicalizedHeaders = $CanonBlobType + "x-ms-date:$GMTTime`nx-ms-version:$ApiVersion"

        $StringToSign = "$Method`n`n`n$ContentLength`n$ContentMD5`n$CType`n$Date`n`n`n`n$IfUnModSince`n$Range`n$CanonicalizedHeaders`n$CanonicalizedResource"

        $byteKey         = [System.Convert]::FromBase64String($accountKey)
        $hasher          = New-Object System.Security.Cryptography.HMACSHA256
        $hasher.Key      = $byteKey
        $signedSignature = [System.Convert]::ToBase64String($hasher.ComputeHash([Text.Encoding]::UTF8.GetBytes($stringToSign)))


        $InvocationParams = @{
            Uri     = $BaseURL + $ResourcePath
            Method  = $Method
            Headers = @{
                'x-ms-date'      = $GMTTime
                'x-ms-version'   = $ApiVersion
                'Authorization'  = "SharedKey $AccountName`:$signedSignature"
                'Content-Type'   = $ContentType
                'Accept'         = $Accept
            }
            SkipHttpErrorCheck = $True
        }
        if($File    ){$InvocationParams.InFile  = $File}
        if($Body    ){$InvocationParams.Body    = $Body}
        if($BlobType){$InvocationParams.Headers.'x-ms-blob-type'=$BlobType}
        
        if(!$Raw){
            $InvocationParams.StatusCodeVariable      = 'StatusCode'
            $InvocationParams.ResponseHeadersVariable = 'ResponseHeaders'
            # Invoke the method
            $response = Invoke-RestMethod @InvocationParams 
        }else {
            $response = Invoke-WebRequest @InvocationParams
            $StatusCode      = $response.StatusCode
            $ResponseHeaders = $response.Headers
            if ($StatusCode -notin 200..299){
                $response = $response.Content | ConvertFrom-Json
            }else{
                $response = $response.Content
            }
        }

        $ReturnHash = @{
            HttpResponse = @{
                StatusCode = $StatusCode
                Headers    = $ResponseHeaders
                Body       = $response
            }
        }

        if ($StatusCode -notin 200..299){
            $ErrCode    = $response.'odata.error'.code ?? $response.error.code
            $ErrMessage = $response.'odata.error'.message.value ?? $response.error.message
            $ErrorMessage = "[$InvocationName] In Response to the HTTP Request a status code was returned that did not indicate Success: [$($StatusCode)$($ErrCode ? " - $ErrCode" : $null)] $(($ErrMessage ?? $response | Out-string).ReplaceLineEndings(' '))"
            if($IgnoreError){
                Write-Debug $ErrorMessage
                Return $null
            }
            elseif($ReturnErrorResponse){
                $ReturnHash.ErrorMessage = $ErrorMessage
                $ReturnHash.Error = @{
                    Code    = $ErrCode
                    Message = $ErrMessage
                }
                Return $ReturnHash
            }else{
                return Write-Error -Message $ErrorMessage
            }
        }else{
            if($IncludeResponseInfo){
                Return $ReturnHash
            }else{
                return $response
            }
        }
    }
#EndRegion