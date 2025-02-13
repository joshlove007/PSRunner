using namespace System.Net
param($Request, $TriggerMetadata)
Import-Module -Name PSRunnerFunctions

#Region Update Invocation Table - Create New Row 
    if($env:LOG_PSRUNNER_INVOCATIONS -eq 'True'){
        $TableRowColumns = @{
            StartedTime  = Get-Date -Format "yyyy-MM-ddTHH:mm:ss.fffffffZ" -AsUTC
            Input        = @{Request=$Request;TriggerMetadata=$TriggerMetadata} | ConvertTo-Json -Depth 4 -Compress
            Script       = $Request.Body||%{$_?.Substring(0, [Math]::Min($_?.Length, 32000))}
            Params       = $($Request.Headers.Parameters ?? $Request.Headers.Params)||%{$_?.Substring(0, [Math]::Min($_?.Length, 32000))}
            Headers      = $Request.Headers|ConvertTo-Json -Depth 4 -EA Continue||%{$_.Substring(0, [Math]::Min($_.Length, 32000))}
            InvocationId = $TriggerMetadata.InvocationId
            Status       = 'Started'
            LastUpdated  = Get-Date -Format "yyyy-MM-ddTHH:mm:ss.fffffffZ" -AsUTC
        }
        $TriggerMetadata.Table = New-AzStAcctTableRow -TableName 'PSRunnerInvocations' -Columns $TableRowColumns
    }
#EndRegion

#Region Parameters
    #Validate Parameters
    $ParameterError = Confirm-Parameters -Request $Request -TriggerMetadata $TriggerMetadata
    
    #Set Vars           
    $Async            = $Request.Headers.Async            -eq 'True'          
    $RunAsDurableTask = $Request.Headers.RunAsDurableTask -eq 'True'
#EndRegion

#Region Durable Function (Async)
    if ($ParameterError) {
        #Region Push-OutputBinding
            $Response = $ParameterError.Response
        #EndRegion
    } elseif($Async -or $RunAsDurableTask){
        $OrchestratorInput = @{Request=$Request;TriggerMetadata=$TriggerMetadata}
        $InstanceId = Start-DurableOrchestration -FunctionName 'PSRunnerOrchestrator' -Input $OrchestratorInput 
        Write-Host "Started orchestration with ID = '$InstanceId'"
        
        $OrchResponse = New-DurableOrchestrationCheckStatusResponse -Request $Request -InstanceId $InstanceId

        if(!$Async){
            $LoopStartTime = Get-Date
            do{
                $StatusResponse = Invoke-RestMethod -Uri $OrchResponse.Body.statusQueryGetUri
            }while($StatusResponse.runtimeStatus -ne 'Completed' -and $LoopStartTime.AddMinutes(5) -gt (Get-Date))
            $OrchResponse.Body.Status = $StatusResponse
        }
        $Response = $OrchResponse
    }
#EndRegion

#Region Synchronous Function
    else{
        $Body = Invoke-PSRunner -Request $Request -TriggerMetadata $TriggerMetadata

        $Response = [HttpResponseContext]@{
            StatusCode = [HttpStatusCode]::OK
            Body       = $Body | ConvertTo-Json -EscapeHandling EscapeHtml -Depth 3
        }
    }
#EndRegion

#Respond to Client
Push-OutputBinding -Name Response -Value $Response 