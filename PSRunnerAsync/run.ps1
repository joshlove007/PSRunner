param($ActivityInput)

$Request         = $ActivityInput.Request
$TriggerMetadata = $ActivityInput.TriggerMetadata
Invoke-PSRunner -Request $Request -TriggerMetadata $TriggerMetadata