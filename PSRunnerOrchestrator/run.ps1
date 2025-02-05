param($Context)

$InputObject = $Context.Input

$output = @()

$output += Invoke-DurableActivity -FunctionName 'PSRunnerAsync' -Input $InputObject

$output
