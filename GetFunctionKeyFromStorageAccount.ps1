#Import PSRunnerFunctions 
Import-Module ".\Modules\PsRunnerFunctions\PSRunnerFunctions.psd1" -Force

#Set Your Accountkey and BlobEndpoint
$ConnectionString = "DefaultEndpointsProtocol=http;AccountName=psrunner;AccountKey=Eby8vdM02xNOcqFlqUwJPLlmEtlCDXJ1OUzFT50uSRZ6IFsuFq2UVErCz4I6tq/K1SZFPTOtr/KBHBeksoGMGw==;BlobEndpoint=http://127.0.0.1:10000/psrunner"

#Get the Blob containing the Function App Secrets
$Blob = Get-AzSABlob -ContainerName 'azure-webjobs-secrets' -BlobName 'psrunner/host.json' -ConString $ConnectionString -StAcctType "Azurite"

#This is the Current Secret you will append to your function app calls. For example "http://localhost:7071/api/PSRunner?code=AxFZ8ImABWVEgsr9NhCNJxVCSIdCqWA6wzSLYWLhZJJlAzFuKTOP7g=="
$CurrentFunctionKeyValue = ($Blob.functionKeys | Where-Object{$_.name -eq "default"}).value

#If you want to change the value of your function key to rotate it or give it a custom value you would continue below

#Here we are changing/setting the value of the function key to our custom value
$Blob.functionKeys[0].value = "AxFZ8ImABWVEgsr9NhCNJxVCSIdCqWA6wzSLYWLhZJJlAzFuKTOP7z=="

#We then convert the PSCustomObject (containing our custom key) into JSON then encode it as a Byte Array
$Content = ($Blob | ConvertTo-Json)
$Bytes = [byte[]][System.Text.Encoding]::UTF8.GetBytes($Content)

#Finally we put our changed blob into our Storage Account
$Response = Set-AzSABlob -ContainerName 'azure-webjobs-secrets' -BlobName 'psrunner/host.json' -ConString $ConnectionString -Content $Bytes -StAcctType Azurite -ContentType 'application/octet-stream'