
# ----------------------------------------------------------------------------------
#
# Copyright Microsoft Corporation
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# http://www.apache.org/licenses/LICENSE-2.0
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# ----------------------------------------------------------------------------------
 
<#
.Synopsis
Creates or updates the data connector.
.Description
Creates or updates the data connector.

.Link
https://learn.microsoft.com/powershell/module/az.securityinsights/new-azsentineldataconnector
#>
function New-AzSentinelDataConnector {
    [OutputType([Microsoft.Azure.PowerShell.Cmdlets.SecurityInsights.Models.Api20210901Preview.DataConnector])]
    [CmdletBinding(DefaultParameterSetName = 'AADAATP', PositionalBinding = $false, SupportsShouldProcess, ConfirmImpact = 'Medium')]
    param(
        [Parameter()]
        [Microsoft.Azure.PowerShell.Cmdlets.SecurityInsights.Category('Path')]
        [Microsoft.Azure.PowerShell.Cmdlets.SecurityInsights.Runtime.DefaultInfo(Script = '(Get-AzContext).Subscription.Id')]
        [System.String]
        # Gets subscription credentials which uniquely identify Microsoft Azure subscription.
        # The subscription ID forms part of the URI for every service call.
        ${SubscriptionId},
         
        [Parameter(Mandatory)]
        [Microsoft.Azure.PowerShell.Cmdlets.SecurityInsights.Category('Path')]
        [System.String]
        # The Resource Group Name.
        ${ResourceGroupName},

        [Parameter(Mandatory)]
        [Microsoft.Azure.PowerShell.Cmdlets.SecurityInsights.Category('Path')]
        [System.String]
        # The name of the workspace.
        ${WorkspaceName},

        [Microsoft.Azure.PowerShell.Cmdlets.SecurityInsights.Category('Path')]
        [Microsoft.Azure.PowerShell.Cmdlets.SecurityInsights.Runtime.DefaultInfo(Script = '(New-Guid).Guid')]
        [System.String]
        # The Id of the Data Connector.
        ${Id},
        
        [Parameter(Mandatory)]
        [ArgumentCompleter([Microsoft.Azure.PowerShell.Cmdlets.SecurityInsights.Support.DataConnectorKind])]
        [Microsoft.Azure.PowerShell.Cmdlets.SecurityInsights.Category('Body')]
        [Microsoft.Azure.PowerShell.Cmdlets.SecurityInsights.Support.DataConnectorKind]
        # Kind of the the data connection
        ${Kind},

        [Parameter(ParameterSetName = 'AADAATP')]
        [Parameter(ParameterSetName = 'Dynamics365')]
        [Parameter(ParameterSetName = 'MicrosoftCloudAppSecurity')]
        [Parameter(ParameterSetName = 'MicrosoftDefenderAdvancedThreatProtection')]
        [Parameter(ParameterSetName = 'MicrosoftThreatIntelligence')]
        [Parameter(ParameterSetName = 'MicrosoftThreatProtection')]
        [Parameter(ParameterSetName = 'Office365')]
        [Parameter(ParameterSetName = 'OfficeATP')]
        [Parameter(ParameterSetName = 'OfficeIRM')]
        [Parameter(ParameterSetName = 'ThreatIntelligence')]
        [Parameter(ParameterSetName = 'ThreatIntelligenceTaxii')]
        [Microsoft.Azure.PowerShell.Cmdlets.SecurityInsights.Category('Body')]
        [Microsoft.Azure.PowerShell.Cmdlets.SecurityInsights.Runtime.DefaultInfo(Script = '(Get-AzContext).Tenant.Id')]
        [System.String]
        # The TenantId.
        ${TenantId},

        [Parameter(ParameterSetName = 'AzureSecurityCenter', Mandatory)]
        [Microsoft.Azure.PowerShell.Cmdlets.SecurityInsights.Category('Body')]
        [System.String]
        # ASC Subscription Id.
        ${ASCSubscriptionId},

        [Parameter(ParameterSetName = 'AADAATP')]
        [Parameter(ParameterSetName = 'AzureSecurityCenter')]
        [Parameter(ParameterSetName = 'MicrosoftCloudAppSecurity')]
        [Parameter(ParameterSetName = 'MicrosoftDefenderAdvancedThreatProtection')]
        [Parameter(ParameterSetName = 'OfficeATP')]
        [Parameter(ParameterSetName = 'OfficeIRM')]
        [ArgumentCompleter([Microsoft.Azure.PowerShell.Cmdlets.SecurityInsights.Support.DataTypeState])]
        [Microsoft.Azure.PowerShell.Cmdlets.SecurityInsights.Category('Body')]
        [System.String]
        ${Alerts},

        [Parameter(ParameterSetName = 'Dynamics365')]
        [ArgumentCompleter([Microsoft.Azure.PowerShell.Cmdlets.SecurityInsights.Support.DataTypeState])]
        [Microsoft.Azure.PowerShell.Cmdlets.SecurityInsights.Category('Body')]
        [System.String]
        ${CommonDataServiceActivity},

        [Parameter(ParameterSetName = 'MicrosoftCloudAppSecurity')]
        [ArgumentCompleter([Microsoft.Azure.PowerShell.Cmdlets.SecurityInsights.Support.DataTypeState])]
        [Microsoft.Azure.PowerShell.Cmdlets.SecurityInsights.Category('Body')]
        [System.String]
        ${DiscoveryLog},

        [Parameter(ParameterSetName = 'MicrosoftThreatIntelligence')]
        [ArgumentCompleter([Microsoft.Azure.PowerShell.Cmdlets.SecurityInsights.Support.DataTypeState])]
        [Microsoft.Azure.PowerShell.Cmdlets.SecurityInsights.Category('Body')]
        [System.String]
        ${BingSafetyPhishingURL},

        [Parameter(ParameterSetName = 'MicrosoftThreatIntelligence')]
        [Microsoft.Azure.PowerShell.Cmdlets.SecurityInsights.Category('Body')]
        [ValidateSet('OneDay', 'OneWeek', 'OneMonth', 'All')]
        [System.String]
        ${BingSafetyPhishingUrlLookbackPeriod},

        [Parameter(ParameterSetName = 'MicrosoftThreatIntelligence')]
        [ArgumentCompleter([Microsoft.Azure.PowerShell.Cmdlets.SecurityInsights.Support.DataTypeState])]
        [Microsoft.Azure.PowerShell.Cmdlets.SecurityInsights.Category('Body')]
        [System.String]
        ${MicrosoftEmergingThreatFeed},

        [Parameter(ParameterSetName = 'MicrosoftThreatIntelligence')]
        [Microsoft.Azure.PowerShell.Cmdlets.SecurityInsights.Category('Body')]
        [ValidateSet('OneDay', 'OneWeek', 'OneMonth', 'All')]
        [System.String]
        ${MicrosoftEmergingThreatFeedLookbackPeriod},

        [Parameter(ParameterSetName = 'MicrosoftThreatProtection')]
        [ArgumentCompleter([Microsoft.Azure.PowerShell.Cmdlets.SecurityInsights.Support.DataTypeState])]
        [Microsoft.Azure.PowerShell.Cmdlets.SecurityInsights.Category('Body')]
        [System.String]
        ${Incident},

        [Parameter(ParameterSetName = 'Office365')]
        [ArgumentCompleter([Microsoft.Azure.PowerShell.Cmdlets.SecurityInsights.Support.DataTypeState])]
        [Microsoft.Azure.PowerShell.Cmdlets.SecurityInsights.Category('Body')]
        [System.String]
        ${Exchange},

        [Parameter(ParameterSetName = 'Office365')]
        [ArgumentCompleter([Microsoft.Azure.PowerShell.Cmdlets.SecurityInsights.Support.DataTypeState])]
        [Microsoft.Azure.PowerShell.Cmdlets.SecurityInsights.Category('Body')]
        [System.String]
        ${SharePoint},

        [Parameter(ParameterSetName = 'Office365')]
        [ArgumentCompleter([Microsoft.Azure.PowerShell.Cmdlets.SecurityInsights.Support.DataTypeState])]
        [Microsoft.Azure.PowerShell.Cmdlets.SecurityInsights.Category('Body')]
        [System.String]
        ${Teams},

        [Parameter(ParameterSetName = 'ThreatIntelligence')]
        [ArgumentCompleter([Microsoft.Azure.PowerShell.Cmdlets.SecurityInsights.Support.DataTypeState])]
        [Microsoft.Azure.PowerShell.Cmdlets.SecurityInsights.Category('Body')]
        [System.String]
        ${Indicator},

        [Parameter(ParameterSetName = 'ThreatIntelligenceTaxii', Mandatory)]
        [Microsoft.Azure.PowerShell.Cmdlets.SecurityInsights.Category('Body')]
        [System.String]
        ${WorkspaceId},

        [Parameter(ParameterSetName = 'ThreatIntelligenceTaxii', Mandatory)]
        [Microsoft.Azure.PowerShell.Cmdlets.SecurityInsights.Category('Body')]
        [System.String]
        ${FriendlyName},

        [Parameter(ParameterSetName = 'ThreatIntelligenceTaxii', Mandatory)]
        [Microsoft.Azure.PowerShell.Cmdlets.SecurityInsights.Category('Body')]
        [System.String]
        ${APIRootURL},

        [Parameter(ParameterSetName = 'ThreatIntelligenceTaxii', Mandatory)]
        [Microsoft.Azure.PowerShell.Cmdlets.SecurityInsights.Category('Body')]
        [System.String]
        ${CollectionId},

        [Parameter(ParameterSetName = 'ThreatIntelligenceTaxii')]
        [Microsoft.Azure.PowerShell.Cmdlets.SecurityInsights.Category('Body')]
        [System.String]
        ${UserName},

        [Parameter(ParameterSetName = 'ThreatIntelligenceTaxii')]
        [Microsoft.Azure.PowerShell.Cmdlets.SecurityInsights.Category('Body')]
        [System.String]
        ${Password},

        [Parameter(ParameterSetName = 'ThreatIntelligenceTaxii')]
        [Microsoft.Azure.PowerShell.Cmdlets.SecurityInsights.Category('Body')]
        [ValidateSet('OneDay', 'OneWeek', 'OneMonth', 'All')]
        [System.String]
        ${TaxiiLookbackPeriod},

        [Parameter(ParameterSetName = 'ThreatIntelligenceTaxii', Mandatory)]
        [ArgumentCompleter([Microsoft.Azure.PowerShell.Cmdlets.SecurityInsights.Support.PollingFrequency])]
        [Microsoft.Azure.PowerShell.Cmdlets.SecurityInsights.Category('Body')]
        [Microsoft.Azure.PowerShell.Cmdlets.SecurityInsights.Support.PollingFrequency]
        ${PollingFrequency},

        [Parameter(ParameterSetName = 'AmazonWebServicesCloudTrail', Mandatory)]
        [Parameter(ParameterSetName = 'AmazonWebServicesS3', Mandatory)]
        [Microsoft.Azure.PowerShell.Cmdlets.SecurityInsights.Category('Body')]
        [System.String]
        ${AWSRoleArn},

        [Parameter(ParameterSetName = 'AmazonWebServicesCloudTrail')]
        [Parameter(ParameterSetName = 'AmazonWebServicesS3', Mandatory)]
        [ArgumentCompleter([Microsoft.Azure.PowerShell.Cmdlets.SecurityInsights.Support.DataTypeState])]
        [Microsoft.Azure.PowerShell.Cmdlets.SecurityInsights.Category('Body')]
        [System.String]
        ${Log},

        [Parameter(ParameterSetName = 'AmazonWebServicesS3', Mandatory)]
        [Microsoft.Azure.PowerShell.Cmdlets.SecurityInsights.Category('Body')]
        [String[]]
        ${SQSURL},

        [Parameter(ParameterSetName = 'AmazonWebServicesS3', Mandatory)]
        [Microsoft.Azure.PowerShell.Cmdlets.SecurityInsights.Category('Body')]
        [System.String]
        ${DetinationTable},

        [Parameter(ParameterSetName = 'GenericUI', Mandatory)]
        #[Parameter(ParameterSetName = 'APIPolling', Mandatory)]
        [Microsoft.Azure.PowerShell.Cmdlets.SecurityInsights.Category('Body')]
        [System.String]
        ${UiConfigTitle},

        [Parameter(ParameterSetName = 'GenericUI', Mandatory)]
        #[Parameter(ParameterSetName = 'APIPolling', Mandatory)]
        [Microsoft.Azure.PowerShell.Cmdlets.SecurityInsights.Category('Body')]
        [System.String]
        ${UiConfigPublisher},

        [Parameter(ParameterSetName = 'GenericUI', Mandatory)]
        #[Parameter(ParameterSetName = 'APIPolling', Mandatory)]
        [Microsoft.Azure.PowerShell.Cmdlets.SecurityInsights.Category('Body')]
        [System.String]
        ${UiConfigDescriptionMarkdown},

        [Parameter(ParameterSetName = 'GenericUI')]
        #[Parameter(ParameterSetName = 'APIPolling')]
        [Microsoft.Azure.PowerShell.Cmdlets.SecurityInsights.Category('Body')]
        [System.String]
        ${UiConfigCustomImage},

        [Parameter(ParameterSetName = 'GenericUI', Mandatory)]
        #[Parameter(ParameterSetName = 'APIPolling', Mandatory)]
        [Microsoft.Azure.PowerShell.Cmdlets.SecurityInsights.Category('Body')]
        [System.String]
        ${UiConfigGraphQueriesTableName},

        [Parameter(ParameterSetName = 'GenericUI', Mandatory)]
        #[Parameter(ParameterSetName = 'APIPolling', Mandatory)]
        [Microsoft.Azure.PowerShell.Cmdlets.SecurityInsights.Category('Body')]
        [Microsoft.Azure.PowerShell.Cmdlets.SecurityInsights.Models.Api20210901Preview.GraphQueries[]]
        ${UiConfigGraphQuery},

        [Parameter(ParameterSetName = 'GenericUI', Mandatory)]
        #[Parameter(ParameterSetName = 'APIPolling', Mandatory)]
        [Microsoft.Azure.PowerShell.Cmdlets.SecurityInsights.Category('Body')]
        [Microsoft.Azure.PowerShell.Cmdlets.SecurityInsights.Models.Api20210901Preview.SampleQueries[]]
        ${UiConfigSampleQuery},

        [Parameter(ParameterSetName = 'GenericUI', Mandatory)]
        #[Parameter(ParameterSetName = 'APIPolling', Mandatory)]
        [Microsoft.Azure.PowerShell.Cmdlets.SecurityInsights.Category('Body')]
        [Microsoft.Azure.PowerShell.Cmdlets.SecurityInsights.Models.Api20210901Preview.LastDataReceivedDataType[]]
        ${UiConfigDataType},

        [Parameter(ParameterSetName = 'GenericUI', Mandatory)]
        #[Parameter(ParameterSetName = 'APIPolling', Mandatory)]
        [Microsoft.Azure.PowerShell.Cmdlets.SecurityInsights.Category('Body')]
        [Microsoft.Azure.PowerShell.Cmdlets.SecurityInsights.Models.Api20210901Preview.ConnectivityCriteria[]]
        ${UiConfigConnectivityCriterion},

        [Parameter(ParameterSetName = 'GenericUI', Mandatory)]
        #[Parameter(ParameterSetName = 'APIPolling', Mandatory)]
        [Microsoft.Azure.PowerShell.Cmdlets.SecurityInsights.Category('Body')]
        [Bool]
        ${AvailabilityIsPreview},

        [Parameter(ParameterSetName = 'GenericUI')]
        #[Parameter(ParameterSetName = 'APIPolling')]
        [Microsoft.Azure.PowerShell.Cmdlets.SecurityInsights.Category('Body')]
        [Microsoft.Azure.PowerShell.Cmdlets.SecurityInsights.Runtime.DefaultInfo(Script = 1)]
        [Int]
        ${AvailabilityStatus},

        [Parameter(ParameterSetName = 'GenericUI')]
        #[Parameter(ParameterSetName = 'APIPolling')]
        [Microsoft.Azure.PowerShell.Cmdlets.SecurityInsights.Category('Body')]
        [Microsoft.Azure.PowerShell.Cmdlets.SecurityInsights.Models.Api20210901Preview.PermissionsResourceProviderItem[]] 
        ${PermissionResourceProvider},

        [Parameter(ParameterSetName = 'GenericUI')]
        #[Parameter(ParameterSetName = 'APIPolling')]
        [Microsoft.Azure.PowerShell.Cmdlets.SecurityInsights.Category('Body')]
        [Microsoft.Azure.PowerShell.Cmdlets.SecurityInsights.Models.Api20210901Preview.PermissionsCustomsItem[]]
        ${PermissionCustom},

        [Parameter(ParameterSetName = 'GenericUI', Mandatory)]
        #[Parameter(ParameterSetName = 'APIPolling', Mandatory)]
        [Microsoft.Azure.PowerShell.Cmdlets.SecurityInsights.Category('Body')]
        [Microsoft.Azure.PowerShell.Cmdlets.SecurityInsights.Models.Api20210901Preview.InstructionSteps[]]
        ${UiConfigInstructionStep},

        [Parameter()]
        [Alias('AzureRMContext', 'AzureCredential')]
        [ValidateNotNull()]
        [Microsoft.Azure.PowerShell.Cmdlets.SecurityInsights.Category('Azure')]
        [System.Management.Automation.PSObject]
        # The credentials, account, tenant, and subscription used for communication with Azure.
        ${DefaultProfile},

        [Parameter()]
        [Microsoft.Azure.PowerShell.Cmdlets.SecurityInsights.Category('Runtime')]
        [System.Management.Automation.SwitchParameter]
        # Run the command as a job
        ${AsJob},

        [Parameter(DontShow)]
        [Microsoft.Azure.PowerShell.Cmdlets.SecurityInsights.Category('Runtime')]
        [System.Management.Automation.SwitchParameter]
        # Wait for .NET debugger to attach
        ${Break},

        [Parameter(DontShow)]
        [ValidateNotNull()]
        [Microsoft.Azure.PowerShell.Cmdlets.SecurityInsights.Category('Runtime')]
        [Microsoft.Azure.PowerShell.Cmdlets.SecurityInsights.Runtime.SendAsyncStep[]]
        # SendAsync Pipeline Steps to be appended to the front of the pipeline
        ${HttpPipelineAppend},

        [Parameter(DontShow)]
        [ValidateNotNull()]
        [Microsoft.Azure.PowerShell.Cmdlets.SecurityInsights.Category('Runtime')]
        [Microsoft.Azure.PowerShell.Cmdlets.SecurityInsights.Runtime.SendAsyncStep[]]
        # SendAsync Pipeline Steps to be prepended to the front of the pipeline
        ${HttpPipelinePrepend},

        [Parameter()]
        [Microsoft.Azure.PowerShell.Cmdlets.SecurityInsights.Category('Runtime')]
        [System.Management.Automation.SwitchParameter]
        # Run the command asynchronously
        ${NoWait},

        [Parameter(DontShow)]
        [Microsoft.Azure.PowerShell.Cmdlets.SecurityInsights.Category('Runtime')]
        [System.Uri]
        # The URI for the proxy server to use
        ${Proxy},

        [Parameter(DontShow)]
        [ValidateNotNull()]
        [Microsoft.Azure.PowerShell.Cmdlets.SecurityInsights.Category('Runtime')]
        [System.Management.Automation.PSCredential]
        # Credentials for a proxy server to use for the remote call
        ${ProxyCredential},

        [Parameter(DontShow)]
        [Microsoft.Azure.PowerShell.Cmdlets.SecurityInsights.Category('Runtime')]
        [System.Management.Automation.SwitchParameter]
        # Use the default credentials for the proxy
        ${ProxyUseDefaultCredentials}
    )

    process {
        try {
            if ($PSBoundParameters['Kind'] -eq 'AzureActiveDirectory'){
                $DataConnector = [Microsoft.Azure.PowerShell.Cmdlets.SecurityInsights.Models.Api20210901Preview.AadDataConnector]::new()
                
                $DataConnector.TenantId = $PSBoundParameters['TenantId']
                $null = $PSBoundParameters.Remove('TenantId')
                
                If($PSBoundParameters['Alerts']){
                    $DataConnector.AlertState = $PSBoundParameters['Alerts']
                    $null = $PSBoundParameters.Remove('Alerts')
                }
            }
            if($PSBoundParameters['Kind'] -eq 'AzureAdvancedThreatProtection'){
                $DataConnector = [Microsoft.Azure.PowerShell.Cmdlets.SecurityInsights.Models.Api20210901Preview.AatpDataConnector]::new()
                
                $DataConnector.TenantId = $PSBoundParameters['TenantId']
                $null = $PSBoundParameters.Remove('TenantId')
                
                If($PSBoundParameters['Alerts']){
                    $DataConnector.AlertState = $PSBoundParameters['Alerts']
                    $null = $PSBoundParameters.Remove('Alerts')
                }
            }
            if($PSBoundParameters['Kind'] -eq 'Dynamics365'){
                $DataConnector = [Microsoft.Azure.PowerShell.Cmdlets.SecurityInsights.Models.Api20210901Preview.Dynamics365DataConnector]::new()
                
                $DataConnector.TenantId = $PSBoundParameters['TenantId']
                $null = $PSBoundParameters.Remove('TenantId')

                If($PSBoundParameters['CommonDataServiceActivity']){
                    $DataConnector.Dynamics365CdActivityState = $PSBoundParameters['CommonDataServiceActivity']
                    $null = $PSBoundParameters.Remove('CommonDataServiceActivity')
                }
            }
            if($PSBoundParameters['Kind'] -eq 'MicrosoftCloudAppSecurity'){
                $DataConnector = [Microsoft.Azure.PowerShell.Cmdlets.SecurityInsights.Models.Api20210901Preview.McasDataConnector]::new()
                
                $DataConnector.TenantId = $PSBoundParameters['TenantId']
                $null = $PSBoundParameters.Remove('TenantId')

                If($PSBoundParameters['Alerts']){
                    $DataConnector.DataTypeAlertState = $PSBoundParameters['Alerts']
                    $null = $PSBoundParameters.Remove('Alerts')
                }

                If($PSBoundParameters['DiscoveryLog']){
                    $DataConnector.DiscoveryLogState = $PSBoundParameters['DiscoveryLog']
                    $null = $PSBoundParameters.Remove('DiscoveryLog')
                }
            }
            if($PSBoundParameters['Kind'] -eq 'MicrosoftDefenderAdvancedThreatProtection'){
                $DataConnector = [Microsoft.Azure.PowerShell.Cmdlets.SecurityInsights.Models.Api20210901Preview.MdatpDataConnector]::new()

                $DataConnector.TenantId = $PSBoundParameters['TenantId']
                $null = $PSBoundParameters.Remove('TenantId')

                If($PSBoundParameters['Alerts']){
                    $DataConnector.AlertState = $PSBoundParameters['Alerts']
                    $null = $PSBoundParameters.Remove('Alerts')
                }
            }
            if($PSBoundParameters['Kind'] -eq 'MicrosoftThreatIntelligence'){
                $DataConnector = [Microsoft.Azure.PowerShell.Cmdlets.SecurityInsights.Models.Api20210901Preview.MstiDataConnector]::new()
                
                $DataConnector.TenantId = $PSBoundParameters['TenantId']
                $null = $PSBoundParameters.Remove('TenantId')
                
                If($PSBoundParameters['BingSafetyPhishingURL']){
                    $DataConnector.BingSafetyPhishingUrlState = $PSBoundParameters['BingSafetyPhishingURL']
                    $null = $PSBoundParameters.Remove('BingSafetyPhishingURL')
                }

                If($PSBoundParameters['BingSafetyPhishingUrlLookbackPeriod']){
                    if($PSBoundParameters['BingSafetyPhishingUrlLookbackPeriod'] -eq 'OneDay'){
                        $DataConnector.BingSafetyPhishingUrlLookbackPeriod = ((Get-Date).AddDays(-1).ToUniversalTime() | Get-DAte -Format yyyy-MM-ddTHH:mm:ss.fffZ).ToString()
                    }
                    elseif ($PSBoundParameters['BingSafetyPhishingUrlLookbackPeriod'] -eq 'OneWeek') {
                        $DataConnector.BingSafetyPhishingUrlLookbackPeriod = ((Get-Date).AddDays(-7).ToUniversalTime() | Get-DAte -Format yyyy-MM-ddTHH:mm:ss.fffZ).ToString()
                    }
                    elseif ($PSBoundParameters['BingSafetyPhishingUrlLookbackPeriod'] -eq 'OneMonth') {
                        $DataConnector.BingSafetyPhishingUrlLookbackPeriod = ((Get-Date).AddMonths(-1).ToUniversalTime() | Get-DAte -Format yyyy-MM-ddTHH:mm:ss.fffZ).ToString()
                    }
                    elseif ($PSBoundParameters['BingSafetyPhishingUrlLookbackPeriod'] -eq 'All') {
                        $DataConnector.BingSafetyPhishingUrlLookbackPeriod = "1970-01-01T00:00:00.000Z"
                    }
                    $null = $PSBoundParameters.Remove('BingSafetyPhishingUrlLookbackPeriod')
                }
                else{
                    $DataConnector.BingSafetyPhishingUrlLookbackPeriod = "1970-01-01T00:00:00.000Z"
                }
                
                If($PSBoundParameters['MicrosoftEmergingThreatFeed']){
                    $DataConnector.MicrosoftEmergingThreatFeedState = $PSBoundParameters['MicrosoftEmergingThreatFeed']
                    $null = $PSBoundParameters.Remove('MicrosoftEmergingThreatFeed')
                }
                
                If($PSBoundParameters['MicrosoftEmergingThreatFeedLookbackPeriod']){
                    if($PSBoundParameters['MicrosoftEmergingThreatFeedLookbackPeriod'] -eq 'OneDay'){
                        $DataConnector.MicrosoftEmergingThreatFeedLookbackPeriod = ((Get-Date).AddDays(-1).ToUniversalTime() | Get-DAte -Format yyyy-MM-ddTHH:mm:ss.fffZ).ToString()
                    }
                    elseif ($PSBoundParameters['MicrosoftEmergingThreatFeedLookbackPeriod'] -eq 'OneWeek') {
                        $DataConnector.MicrosoftEmergingThreatFeedLookbackPeriod = ((Get-Date).AddDays(-7).ToUniversalTime() | Get-DAte -Format yyyy-MM-ddTHH:mm:ss.fffZ).ToString()
                    }
                    elseif ($PSBoundParameters['MicrosoftEmergingThreatFeedLookbackPeriod'] -eq 'OneMonth') {
                        $DataConnector.MicrosoftEmergingThreatFeedLookbackPeriod = ((Get-Date).AddMonths(-1).ToUniversalTime() | Get-DAte -Format yyyy-MM-ddTHH:mm:ss.fffZ).ToString()
                    }
                    elseif ($PSBoundParameters['MicrosoftEmergingThreatFeedLookbackPeriod'] -eq 'All') {
                        $DataConnector.MicrosoftEmergingThreatFeedLookbackPeriod = "1970-01-01T00:00:00.000Z"
                    }
                    $null = $PSBoundParameters.Remove('MicrosoftEmergingThreatFeedLookbackPeriod')
                }
                else{
                    $DataConnector.MicrosoftEmergingThreatFeedLookbackPeriod = "1970-01-01T00:00:00.000Z"
                }
            }

            if($PSBoundParameters['Kind'] -eq 'MicrosoftThreatProtection'){
                $DataConnector = [Microsoft.Azure.PowerShell.Cmdlets.SecurityInsights.Models.Api20210901Preview.MtpDataConnector]::new()
                
                $DataConnector.TenantId = $PSBoundParameters['TenantId']
                $null = $PSBoundParameters.Remove('TenantId')

                If($PSBoundParameters['Incident']){
                    $DataConnector.IncidentState = $PSBoundParameters['Incident']
                    $null = $PSBoundParameters.Remove('Incident')
                }
            }
            if($PSBoundParameters['Kind'] -eq 'Office365'){
                $DataConnector = [Microsoft.Azure.PowerShell.Cmdlets.SecurityInsights.Models.Api20210901Preview.OfficeDataConnector]::new()
                
                $DataConnector.TenantId = $PSBoundParameters['TenantId']
                $null = $PSBoundParameters.Remove('TenantId')

                If($PSBoundParameters['Exchange']){
                    $DataConnector.ExchangeState = $PSBoundParameters['Exchange']
                    $null = $PSBoundParameters.Remove('Exchange')
                }

                If($PSBoundParameters['SharePoint']){
                    $DataConnector.SharePointState = $PSBoundParameters['SharePoint']
                    $null = $PSBoundParameters.Remove('SharePoint')
                }

                If($PSBoundParameters['Teams']){
                    $DataConnector.TeamState = $PSBoundParameters['Teams']
                    $null = $PSBoundParameters.Remove('Teams')
                }
            }
            if($PSBoundParameters['Kind'] -eq 'OfficeATP'){
                $DataConnector = [Microsoft.Azure.PowerShell.Cmdlets.SecurityInsights.Models.Api20210901Preview.OfficeAtpDataConnector]::new()
                
                $DataConnector.TenantId = $PSBoundParameters['TenantId']
                $null = $PSBoundParameters.Remove('TenantId')
                
                If($PSBoundParameters['Alerts']){
                    $DataConnector.AlertState = $PSBoundParameters['Alerts']
                    $null = $PSBoundParameters.Remove('Alerts')
                }
            }
            if($PSBoundParameters['Kind'] -eq 'OfficeIRM'){
                $DataConnector = [Microsoft.Azure.PowerShell.Cmdlets.SecurityInsights.Models.Api20210901Preview.OfficeIrmDataConnector]::new()
                
                $DataConnector.TenantId = $PSBoundParameters['TenantId']
                $null = $PSBoundParameters.Remove('TenantId')
                
                If($PSBoundParameters['Alerts']){
                    $DataConnector.AlertState = $PSBoundParameters['Alerts']
                    $null = $PSBoundParameters.Remove('Alerts')
                }
            }
            if($PSBoundParameters['Kind'] -eq 'ThreatIntelligence'){
                $DataConnector = [Microsoft.Azure.PowerShell.Cmdlets.SecurityInsights.Models.Api20210901Preview.TiDataConnector]::new()
                
                $DataConnector.TenantId = $PSBoundParameters['TenantId']
                $null = $PSBoundParameters.Remove('TenantId')

                $DataConnector.TipLookbackPeriod = "1970-01-01T00:00:00.000Z"
                
                If($PSBoundParameters['Indicator']){
                    $DataConnector.IndicatorState = $PSBoundParameters['Indicator']
                    $null = $PSBoundParameters.Remove('Indicator')
                }
            }
            if($PSBoundParameters['Kind'] -eq 'ThreatIntelligenceTaxii'){
                $DataConnector = [Microsoft.Azure.PowerShell.Cmdlets.SecurityInsights.Models.Api20210901Preview.TiTaxiiDataConnector]::new()
                
                $DataConnector.TenantId = $PSBoundParameters['TenantId']
                $null = $PSBoundParameters.Remove('TenantId')

                $DataConnector.FriendlyName = $PSBoundParameters['FriendlyName']
                $null = $PSBoundParameters.Remove('FriendlyName')

                $DataConnector.TaxiiServer = $PSBoundParameters['APIRootURL']
                $null = $PSBoundParameters.Remove('APIRootURL')

                $DataConnector.CollectionId = $PSBoundParameters['CollectionId']
                $null = $PSBoundParameters.Remove('CollectionId')

                If($PSBoundParameters['UserName']){
                    $DataConnector.UserName = $PSBoundParameters['UserName']
                    $null = $PSBoundParameters.Remove('UserName')
                }

                If($PSBoundParameters['Password']){
                    $DataConnector.Password = $PSBoundParameters['Password']
                    $null = $PSBoundParameters.Remove('Password')
                }

                $DataConnector.WorkspaceId = $PSBoundParameters['WorkspaceId']
                $null = $PSBoundParameters.Remove('WorkspaceId')

                
                if($PSBoundParameters['PollingFrequency'] -eq 'OnceADay'){
                    $DataConnector.PollingFrequency = "OnceADay"
                }
                elseif ($PSBoundParameters['PollingFrequency'] -eq 'OnceAMinute') {
                    $DataConnector.PollingFrequency = "OnceAMinute"
                }
                elseif ($PSBoundParameters['PollingFrequency'] -eq 'OnceAnHour') {
                    $DataConnector.PollingFrequency = "OnceAnHour"
                }
                $null = $PSBoundParameters.Remove('PollingFrequency')

            }

            if($PSBoundParameters['Kind'] -eq 'AzureSecurityCenter'){
                $DataConnector = [Microsoft.Azure.PowerShell.Cmdlets.SecurityInsights.Models.Api20210901Preview.AscDataConnector]::new()
                
                $DataConnector.SubscriptionId = $PSBoundParameters['ASCSubscriptionId']
                $null = $PSBoundParameters.Remove('ASCSubscriptionId')

                If($PSBoundParameters['Alerts']){
                    $DataConnector.AlertState = $PSBoundParameters['Alerts']
                    $null = $PSBoundParameters.Remove('Alerts')
                }
            }
            if($PSBoundParameters['Kind'] -eq 'AmazonWebServicesCloudTrail'){
                $DataConnector = [Microsoft.Azure.PowerShell.Cmdlets.SecurityInsights.Models.Api20210901Preview.AwsCloudTrailDataConnector]::new()
                
                $DataConnector.AWSRoleArn = $PSBoundParameters['AWSRoleArn']
                $null = $PSBoundParameters.Remove('AWSRoleArn')

                If($PSBoundParameters['Log']){
                    $DataConnector.LogState = $PSBoundParameters['Log']
                    $null = $PSBoundParameters.Remove('Log')
                }
            }
            if($PSBoundParameters['Kind'] -eq 'AmazonWebServicesS3'){
                $DataConnector = [Microsoft.Azure.PowerShell.Cmdlets.SecurityInsights.Models.Api20210901Preview.AwsCloudTrailDataConnector]::new()
                
                $DataConnector.RoleArn = $PSBoundParameters['AWSRoleArn']
                $null = $PSBoundParameters.Remove('AWSRoleArn')

                If($PSBoundParameters['Log']){
                    $DataConnector.LogState = $PSBoundParameters['Log']
                    $null = $PSBoundParameters.Remove('Log')
                }
                
                $DataConnector.SqsUrl = $PSBoundParameters['SQSURL']
                $null = $PSBoundParameters.Remove('SQSURL')
                
                $DataConnector.DestinationTable = $PSBoundParameters['DetinationTable']
                $null = $PSBoundParameters.Remove('DetinationTable')
            }
            if($PSBoundParameters['Kind'] -eq 'GenericUI'){
                $DataConnector = [Microsoft.Azure.PowerShell.Cmdlets.SecurityInsights.Models.Api20210901Preview.CodelessUiDataConnector]::new()
                
                $DataConnector.ConnectorUiConfigTitle = $PSBoundParameters['UiConfigTitle']
                $null = $PSBoundParameters.Remove('UiConfigTitle')

                $DataConnector.ConnectorUiConfigPublisher = $PSBoundParameters['UiConfigPublisher']
                $null = $PSBoundParameters.Remove('UiConfigPublisher')

                $DataConnector.ConnectorUiConfigDescriptionMarkdown = $PSBoundParameters['UiConfigDescriptionMarkdown']
                $null = $PSBoundParameters.Remove('UiConfigDescriptionMarkdown')

                If($PSBoundParameters['UiConfigCustomImage']){
                    $DataConnector.ConnectorUiConfigCustomImage = $PSBoundParameters['UiConfigCustomImage']
                    $null = $PSBoundParameters.Remove('UiConfigCustomImage')
                }

                $DataConnector.ConnectorUiConfigGraphQueriesTableName = $PSBoundParameters['UiConfigGraphQueriesTableName']
                $null = $PSBoundParameters.Remove('UiConfigGraphQueriesTableName')

                $DataConnector.ConnectorUiConfigGraphQuery = $PSBoundParameters['UiConfigGraphQuery']
                $null = $PSBoundParameters.Remove('UiConfigGraphQuery')

                $DataConnector.ConnectorUiConfigSampleQuery = $PSBoundParameters['UiConfigSampleQuery']
                $null = $PSBoundParameters.Remove('UiConfigSampleQuery')
        
                $DataConnector.ConnectorUiConfigDataType = $PSBoundParameters['UiConfigDataType']
                $null = $PSBoundParameters.Remove('UiConfigDataType')

                $DataConnector.ConnectorUiConfigConnectivityCriterion = $PSBoundParameters['UiConfigConnectivityCriterion']
                $null = $PSBoundParameters.Remove('UiConfigConnectivityCriterion')

                $DataConnector.AvailabilityIsPreview = $PSBoundParameters['AvailabilityIsPreview']
                $null = $PSBoundParameters.Remove('AvailabilityIsPreview')

                If($PSBoundParameters['AvailabilityStatus']){
                    $DataConnector.AvailabilityStatus = $PSBoundParameters['AvailabilityStatus']
                    $null = $PSBoundParameters.Remove('AvailabilityStatus')
                }

                If($PSBoundParameters['PermissionResourceProvider']){
                    $DataConnector.AvailabilityStatus = $PSBoundParameters['PermissionResourceProvider']
                    $null = $PSBoundParameters.Remove('PermissionResourceProvider')
                }
                ElseIf($PSBoundParameters['PermissionCustom']){
                    $DataConnector.AvailabilityStatus = $PSBoundParameters['PermissionCustom']
                    $null = $PSBoundParameters.Remove('PermissionCustom')
                }
                Else {
                    Write-Host -ForegroundColor Red "You must provide either a Resource Provider Permission or Custom Permissions"
                    break
                }

                $DataConnector.ConnectorUiConfigInstructionStep = $PSBoundParameters['UiConfigInstructionStep']
                $null = $PSBoundParameters.Remove('UiConfigInstructionStep')

            }
    
            $DataConnector.Kind = $PSBoundParameters['Kind']
            $null = $PSBoundParameters.Remove('Kind')

            $null = $PSBoundParameters.Remove('DataConnector')
            $null = $PSBoundParameters.Add('DataConnector', $DataConnector)

            Az.SecurityInsights.internal\New-AzSentinelDataConnector @PSBoundParameters
        }
        catch {
            throw
        }
    }
}
# SIG # Begin signature block
# MIInrQYJKoZIhvcNAQcCoIInnjCCJ5oCAQExDzANBglghkgBZQMEAgEFADB5Bgor
# BgEEAYI3AgEEoGswaTA0BgorBgEEAYI3AgEeMCYCAwEAAAQQH8w7YFlLCE63JNLG
# KX7zUQIBAAIBAAIBAAIBAAIBADAxMA0GCWCGSAFlAwQCAQUABCB1Fjzn1PB4+nmQ
# yu48IKPlEZJb0ikzwY+Vs76HIPRGNqCCDYEwggX/MIID56ADAgECAhMzAAACzI61
# lqa90clOAAAAAALMMA0GCSqGSIb3DQEBCwUAMH4xCzAJBgNVBAYTAlVTMRMwEQYD
# VQQIEwpXYXNoaW5ndG9uMRAwDgYDVQQHEwdSZWRtb25kMR4wHAYDVQQKExVNaWNy
# b3NvZnQgQ29ycG9yYXRpb24xKDAmBgNVBAMTH01pY3Jvc29mdCBDb2RlIFNpZ25p
# bmcgUENBIDIwMTEwHhcNMjIwNTEyMjA0NjAxWhcNMjMwNTExMjA0NjAxWjB0MQsw
# CQYDVQQGEwJVUzETMBEGA1UECBMKV2FzaGluZ3RvbjEQMA4GA1UEBxMHUmVkbW9u
# ZDEeMBwGA1UEChMVTWljcm9zb2Z0IENvcnBvcmF0aW9uMR4wHAYDVQQDExVNaWNy
# b3NvZnQgQ29ycG9yYXRpb24wggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIB
# AQCiTbHs68bADvNud97NzcdP0zh0mRr4VpDv68KobjQFybVAuVgiINf9aG2zQtWK
# No6+2X2Ix65KGcBXuZyEi0oBUAAGnIe5O5q/Y0Ij0WwDyMWaVad2Te4r1Eic3HWH
# UfiiNjF0ETHKg3qa7DCyUqwsR9q5SaXuHlYCwM+m59Nl3jKnYnKLLfzhl13wImV9
# DF8N76ANkRyK6BYoc9I6hHF2MCTQYWbQ4fXgzKhgzj4zeabWgfu+ZJCiFLkogvc0
# RVb0x3DtyxMbl/3e45Eu+sn/x6EVwbJZVvtQYcmdGF1yAYht+JnNmWwAxL8MgHMz
# xEcoY1Q1JtstiY3+u3ulGMvhAgMBAAGjggF+MIIBejAfBgNVHSUEGDAWBgorBgEE
# AYI3TAgBBggrBgEFBQcDAzAdBgNVHQ4EFgQUiLhHjTKWzIqVIp+sM2rOHH11rfQw
# UAYDVR0RBEkwR6RFMEMxKTAnBgNVBAsTIE1pY3Jvc29mdCBPcGVyYXRpb25zIFB1
# ZXJ0byBSaWNvMRYwFAYDVQQFEw0yMzAwMTIrNDcwNTI5MB8GA1UdIwQYMBaAFEhu
# ZOVQBdOCqhc3NyK1bajKdQKVMFQGA1UdHwRNMEswSaBHoEWGQ2h0dHA6Ly93d3cu
# bWljcm9zb2Z0LmNvbS9wa2lvcHMvY3JsL01pY0NvZFNpZ1BDQTIwMTFfMjAxMS0w
# Ny0wOC5jcmwwYQYIKwYBBQUHAQEEVTBTMFEGCCsGAQUFBzAChkVodHRwOi8vd3d3
# Lm1pY3Jvc29mdC5jb20vcGtpb3BzL2NlcnRzL01pY0NvZFNpZ1BDQTIwMTFfMjAx
# MS0wNy0wOC5jcnQwDAYDVR0TAQH/BAIwADANBgkqhkiG9w0BAQsFAAOCAgEAeA8D
# sOAHS53MTIHYu8bbXrO6yQtRD6JfyMWeXaLu3Nc8PDnFc1efYq/F3MGx/aiwNbcs
# J2MU7BKNWTP5JQVBA2GNIeR3mScXqnOsv1XqXPvZeISDVWLaBQzceItdIwgo6B13
# vxlkkSYMvB0Dr3Yw7/W9U4Wk5K/RDOnIGvmKqKi3AwyxlV1mpefy729FKaWT7edB
# d3I4+hldMY8sdfDPjWRtJzjMjXZs41OUOwtHccPazjjC7KndzvZHx/0VWL8n0NT/
# 404vftnXKifMZkS4p2sB3oK+6kCcsyWsgS/3eYGw1Fe4MOnin1RhgrW1rHPODJTG
# AUOmW4wc3Q6KKr2zve7sMDZe9tfylonPwhk971rX8qGw6LkrGFv31IJeJSe/aUbG
# dUDPkbrABbVvPElgoj5eP3REqx5jdfkQw7tOdWkhn0jDUh2uQen9Atj3RkJyHuR0
# GUsJVMWFJdkIO/gFwzoOGlHNsmxvpANV86/1qgb1oZXdrURpzJp53MsDaBY/pxOc
# J0Cvg6uWs3kQWgKk5aBzvsX95BzdItHTpVMtVPW4q41XEvbFmUP1n6oL5rdNdrTM
# j/HXMRk1KCksax1Vxo3qv+13cCsZAaQNaIAvt5LvkshZkDZIP//0Hnq7NnWeYR3z
# 4oFiw9N2n3bb9baQWuWPswG0Dq9YT9kb+Cs4qIIwggd6MIIFYqADAgECAgphDpDS
# AAAAAAADMA0GCSqGSIb3DQEBCwUAMIGIMQswCQYDVQQGEwJVUzETMBEGA1UECBMK
# V2FzaGluZ3RvbjEQMA4GA1UEBxMHUmVkbW9uZDEeMBwGA1UEChMVTWljcm9zb2Z0
# IENvcnBvcmF0aW9uMTIwMAYDVQQDEylNaWNyb3NvZnQgUm9vdCBDZXJ0aWZpY2F0
# ZSBBdXRob3JpdHkgMjAxMTAeFw0xMTA3MDgyMDU5MDlaFw0yNjA3MDgyMTA5MDla
# MH4xCzAJBgNVBAYTAlVTMRMwEQYDVQQIEwpXYXNoaW5ndG9uMRAwDgYDVQQHEwdS
# ZWRtb25kMR4wHAYDVQQKExVNaWNyb3NvZnQgQ29ycG9yYXRpb24xKDAmBgNVBAMT
# H01pY3Jvc29mdCBDb2RlIFNpZ25pbmcgUENBIDIwMTEwggIiMA0GCSqGSIb3DQEB
# AQUAA4ICDwAwggIKAoICAQCr8PpyEBwurdhuqoIQTTS68rZYIZ9CGypr6VpQqrgG
# OBoESbp/wwwe3TdrxhLYC/A4wpkGsMg51QEUMULTiQ15ZId+lGAkbK+eSZzpaF7S
# 35tTsgosw6/ZqSuuegmv15ZZymAaBelmdugyUiYSL+erCFDPs0S3XdjELgN1q2jz
# y23zOlyhFvRGuuA4ZKxuZDV4pqBjDy3TQJP4494HDdVceaVJKecNvqATd76UPe/7
# 4ytaEB9NViiienLgEjq3SV7Y7e1DkYPZe7J7hhvZPrGMXeiJT4Qa8qEvWeSQOy2u
# M1jFtz7+MtOzAz2xsq+SOH7SnYAs9U5WkSE1JcM5bmR/U7qcD60ZI4TL9LoDho33
# X/DQUr+MlIe8wCF0JV8YKLbMJyg4JZg5SjbPfLGSrhwjp6lm7GEfauEoSZ1fiOIl
# XdMhSz5SxLVXPyQD8NF6Wy/VI+NwXQ9RRnez+ADhvKwCgl/bwBWzvRvUVUvnOaEP
# 6SNJvBi4RHxF5MHDcnrgcuck379GmcXvwhxX24ON7E1JMKerjt/sW5+v/N2wZuLB
# l4F77dbtS+dJKacTKKanfWeA5opieF+yL4TXV5xcv3coKPHtbcMojyyPQDdPweGF
# RInECUzF1KVDL3SV9274eCBYLBNdYJWaPk8zhNqwiBfenk70lrC8RqBsmNLg1oiM
# CwIDAQABo4IB7TCCAekwEAYJKwYBBAGCNxUBBAMCAQAwHQYDVR0OBBYEFEhuZOVQ
# BdOCqhc3NyK1bajKdQKVMBkGCSsGAQQBgjcUAgQMHgoAUwB1AGIAQwBBMAsGA1Ud
# DwQEAwIBhjAPBgNVHRMBAf8EBTADAQH/MB8GA1UdIwQYMBaAFHItOgIxkEO5FAVO
# 4eqnxzHRI4k0MFoGA1UdHwRTMFEwT6BNoEuGSWh0dHA6Ly9jcmwubWljcm9zb2Z0
# LmNvbS9wa2kvY3JsL3Byb2R1Y3RzL01pY1Jvb0NlckF1dDIwMTFfMjAxMV8wM18y
# Mi5jcmwwXgYIKwYBBQUHAQEEUjBQME4GCCsGAQUFBzAChkJodHRwOi8vd3d3Lm1p
# Y3Jvc29mdC5jb20vcGtpL2NlcnRzL01pY1Jvb0NlckF1dDIwMTFfMjAxMV8wM18y
# Mi5jcnQwgZ8GA1UdIASBlzCBlDCBkQYJKwYBBAGCNy4DMIGDMD8GCCsGAQUFBwIB
# FjNodHRwOi8vd3d3Lm1pY3Jvc29mdC5jb20vcGtpb3BzL2RvY3MvcHJpbWFyeWNw
# cy5odG0wQAYIKwYBBQUHAgIwNB4yIB0ATABlAGcAYQBsAF8AcABvAGwAaQBjAHkA
# XwBzAHQAYQB0AGUAbQBlAG4AdAAuIB0wDQYJKoZIhvcNAQELBQADggIBAGfyhqWY
# 4FR5Gi7T2HRnIpsLlhHhY5KZQpZ90nkMkMFlXy4sPvjDctFtg/6+P+gKyju/R6mj
# 82nbY78iNaWXXWWEkH2LRlBV2AySfNIaSxzzPEKLUtCw/WvjPgcuKZvmPRul1LUd
# d5Q54ulkyUQ9eHoj8xN9ppB0g430yyYCRirCihC7pKkFDJvtaPpoLpWgKj8qa1hJ
# Yx8JaW5amJbkg/TAj/NGK978O9C9Ne9uJa7lryft0N3zDq+ZKJeYTQ49C/IIidYf
# wzIY4vDFLc5bnrRJOQrGCsLGra7lstnbFYhRRVg4MnEnGn+x9Cf43iw6IGmYslmJ
# aG5vp7d0w0AFBqYBKig+gj8TTWYLwLNN9eGPfxxvFX1Fp3blQCplo8NdUmKGwx1j
# NpeG39rz+PIWoZon4c2ll9DuXWNB41sHnIc+BncG0QaxdR8UvmFhtfDcxhsEvt9B
# xw4o7t5lL+yX9qFcltgA1qFGvVnzl6UJS0gQmYAf0AApxbGbpT9Fdx41xtKiop96
# eiL6SJUfq/tHI4D1nvi/a7dLl+LrdXga7Oo3mXkYS//WsyNodeav+vyL6wuA6mk7
# r/ww7QRMjt/fdW1jkT3RnVZOT7+AVyKheBEyIXrvQQqxP/uozKRdwaGIm1dxVk5I
# RcBCyZt2WwqASGv9eZ/BvW1taslScxMNelDNMYIZgjCCGX4CAQEwgZUwfjELMAkG
# A1UEBhMCVVMxEzARBgNVBAgTCldhc2hpbmd0b24xEDAOBgNVBAcTB1JlZG1vbmQx
# HjAcBgNVBAoTFU1pY3Jvc29mdCBDb3Jwb3JhdGlvbjEoMCYGA1UEAxMfTWljcm9z
# b2Z0IENvZGUgU2lnbmluZyBQQ0EgMjAxMQITMwAAAsyOtZamvdHJTgAAAAACzDAN
# BglghkgBZQMEAgEFAKCBrjAZBgkqhkiG9w0BCQMxDAYKKwYBBAGCNwIBBDAcBgor
# BgEEAYI3AgELMQ4wDAYKKwYBBAGCNwIBFTAvBgkqhkiG9w0BCQQxIgQgEntjigW0
# 6nDegf6ATRgHTX6yAvlfQR+iMEvZpYj64N0wQgYKKwYBBAGCNwIBDDE0MDKgFIAS
# AE0AaQBjAHIAbwBzAG8AZgB0oRqAGGh0dHA6Ly93d3cubWljcm9zb2Z0LmNvbTAN
# BgkqhkiG9w0BAQEFAASCAQBPXpVyVj4Xhrg9RMAK1D0c4jqQT1mt2hFIGL9FnvzE
# OxsC1x+6KX/6+OTQMIk0BlCDsQfC5nKD5ueK+zh1yDmHCXaBN4haEwPoOdn7mXpu
# Ki8NQgVLecbEwzdBo8sKQtJAz4lJ161K2U6ziAGZ8aN+RwBUJBnekMziEreaKnST
# uQ5ZnapNEzGIfjsLZdR/SqUewj4p5gdyOoTFgVYQA7uTaf84EYy+8RF5vejZ1W2o
# m+03hBJzTYoUxB2uQZ5yFrTBq+0QZKJI/FiSIZx5ewXBNBnlGAxychBmVtQWi1xT
# HjVAf2ao6uOM8yG6Y87AuzC/f8xIGNtzZNg0c1eoeFrUoYIXDDCCFwgGCisGAQQB
# gjcDAwExghb4MIIW9AYJKoZIhvcNAQcCoIIW5TCCFuECAQMxDzANBglghkgBZQME
# AgEFADCCAVUGCyqGSIb3DQEJEAEEoIIBRASCAUAwggE8AgEBBgorBgEEAYRZCgMB
# MDEwDQYJYIZIAWUDBAIBBQAEICUm1Yr7bgBUuBzQ/AzCMwkYf85LKAak6umtGkl3
# bIPuAgZjoaGkq40YEzIwMjMwMTA2MTAwNTE4LjM5M1owBIACAfSggdSkgdEwgc4x
# CzAJBgNVBAYTAlVTMRMwEQYDVQQIEwpXYXNoaW5ndG9uMRAwDgYDVQQHEwdSZWRt
# b25kMR4wHAYDVQQKExVNaWNyb3NvZnQgQ29ycG9yYXRpb24xKTAnBgNVBAsTIE1p
# Y3Jvc29mdCBPcGVyYXRpb25zIFB1ZXJ0byBSaWNvMSYwJAYDVQQLEx1UaGFsZXMg
# VFNTIEVTTjo3ODgwLUUzOTAtODAxNDElMCMGA1UEAxMcTWljcm9zb2Z0IFRpbWUt
# U3RhbXAgU2VydmljZaCCEV8wggcQMIIE+KADAgECAhMzAAABqFXwYanMMBhcAAEA
# AAGoMA0GCSqGSIb3DQEBCwUAMHwxCzAJBgNVBAYTAlVTMRMwEQYDVQQIEwpXYXNo
# aW5ndG9uMRAwDgYDVQQHEwdSZWRtb25kMR4wHAYDVQQKExVNaWNyb3NvZnQgQ29y
# cG9yYXRpb24xJjAkBgNVBAMTHU1pY3Jvc29mdCBUaW1lLVN0YW1wIFBDQSAyMDEw
# MB4XDTIyMDMwMjE4NTEyM1oXDTIzMDUxMTE4NTEyM1owgc4xCzAJBgNVBAYTAlVT
# MRMwEQYDVQQIEwpXYXNoaW5ndG9uMRAwDgYDVQQHEwdSZWRtb25kMR4wHAYDVQQK
# ExVNaWNyb3NvZnQgQ29ycG9yYXRpb24xKTAnBgNVBAsTIE1pY3Jvc29mdCBPcGVy
# YXRpb25zIFB1ZXJ0byBSaWNvMSYwJAYDVQQLEx1UaGFsZXMgVFNTIEVTTjo3ODgw
# LUUzOTAtODAxNDElMCMGA1UEAxMcTWljcm9zb2Z0IFRpbWUtU3RhbXAgU2Vydmlj
# ZTCCAiIwDQYJKoZIhvcNAQEBBQADggIPADCCAgoCggIBAKPabcrALiXX8pjyXpcM
# N89KTvcmlAiDw4pU+HejZhibUeo/HUy+P9VxWhCX7ogeeKPJ677+LeVdPdG5hTvG
# DgSuo3w+AcmzcXZ2QCGUgUReLUKbmrr06bB0xhvtZwoelhxtPkjJFsbTGtSt+V7E
# 4VCjPdYqQZ/iN0ArXXmgbEfVyCwS+h2uooBhM5UcbPogtr5VpgdzbUM4/rWupmFV
# jPB1asn3+wv7aBCK8j9QUJroY4y1pmZSf0SuGMWY7cm2cvrbdm7XldljqRdHW+CQ
# AB4EqiOqgumfR+aSpo5T75KG0+nsBkjlGSsU1Bi15p4rP88pZnSop73Gem9GWO2G
# RLwP15YEnKsczxhGY+Z8NEa0QwMMiVlksdPU7J5qK9gxAQjOJzqISJzhIwQWtELq
# gJoHwkqTxem3grY7B7DOzQTnQpKWoL0HWR9KqIvaC7i9XlPv+ue89j9e7fmB4nh1
# hulzEJzX6RMU9THJMlbO6OrP3NNEKJW8jipCny8H1fuvSuFfuB7t++KK9g2c2NKu
# 5EzSs1nKNqtl4KO3UzyXLWvTRDO4D5PVQOda0tqjS/AWoUrxKC5ZPlkLE+YPsS5G
# +E/VCgCaghPyBZsHNK7wHlSf/26uhLnKp6XRAIroiEYl/5yW0mShjvnARPr0GIlS
# m0KrqSwCjR5ckWT1sKaEb8w3AgMBAAGjggE2MIIBMjAdBgNVHQ4EFgQUNsfb4+L4
# UutlNh/MxjGkj0kLItUwHwYDVR0jBBgwFoAUn6cVXQBeYl2D9OXSZacbUzUZ6XIw
# XwYDVR0fBFgwVjBUoFKgUIZOaHR0cDovL3d3dy5taWNyb3NvZnQuY29tL3BraW9w
# cy9jcmwvTWljcm9zb2Z0JTIwVGltZS1TdGFtcCUyMFBDQSUyMDIwMTAoMSkuY3Js
# MGwGCCsGAQUFBwEBBGAwXjBcBggrBgEFBQcwAoZQaHR0cDovL3d3dy5taWNyb3Nv
# ZnQuY29tL3BraW9wcy9jZXJ0cy9NaWNyb3NvZnQlMjBUaW1lLVN0YW1wJTIwUENB
# JTIwMjAxMCgxKS5jcnQwDAYDVR0TAQH/BAIwADATBgNVHSUEDDAKBggrBgEFBQcD
# CDANBgkqhkiG9w0BAQsFAAOCAgEAcTuCS2Rqqmf2mPr6OUydhmUx+m6vpEPszWio
# JXbnsRbny62nF9YXTKuSNWH1QFfyc/2N3YTEp4hE8YthYKgDM/HUhUREX3WTwGse
# YuuDeSxWRJWCorAHF1kwQzIKgrUc3G+uVwAmG/EI1ELRExA4ftx0Ehrf59aJm7On
# gn0lTSSiKUeuGA+My6oCi/V8ETxz+eblvQANaltJgGfppuWXYT4jisQKETvoJjBv
# 5x+BA0oEFu7gGaeMDkZjnO5vdf6HeKneILs9ZvwIWkgYQi2ZeozbxglG5YwExoix
# ekxrRTDZwMokIYxXmccscQ0xXmh+I3vo7hV9ZMKTa9Paz5ne4cc8Odw1T+624mB0
# WaW9HAE1hojB6CbfundtV/jwxmdKh15plJXnN1yM7OL924HqAiJisHanpOEJ4Um9
# b3hFUXE2uEJL9aYuIgksVYIq1P29rR4X7lz3uEJH6COkoE6+UcauN6JYFghN9I8J
# RBWAhHX4GQHlngsdftWLLiDZMynlgRCZzkYI24N9cx+D367YwclqNY6CZuAgzwy1
# 2uRYFQasYHYK1hpzyTtuI/A2B8cG+HM6X1jf2d9uARwH6+hLkPtt3/5NBlLXpOl5
# iZyRlBi7iDXkWNa3juGfLAJ3ISDyNh7yu+H4yQYyRs/MVrCkWUJs9EivLKsNJ2B/
# IjNrStYwggdxMIIFWaADAgECAhMzAAAAFcXna54Cm0mZAAAAAAAVMA0GCSqGSIb3
# DQEBCwUAMIGIMQswCQYDVQQGEwJVUzETMBEGA1UECBMKV2FzaGluZ3RvbjEQMA4G
# A1UEBxMHUmVkbW9uZDEeMBwGA1UEChMVTWljcm9zb2Z0IENvcnBvcmF0aW9uMTIw
# MAYDVQQDEylNaWNyb3NvZnQgUm9vdCBDZXJ0aWZpY2F0ZSBBdXRob3JpdHkgMjAx
# MDAeFw0yMTA5MzAxODIyMjVaFw0zMDA5MzAxODMyMjVaMHwxCzAJBgNVBAYTAlVT
# MRMwEQYDVQQIEwpXYXNoaW5ndG9uMRAwDgYDVQQHEwdSZWRtb25kMR4wHAYDVQQK
# ExVNaWNyb3NvZnQgQ29ycG9yYXRpb24xJjAkBgNVBAMTHU1pY3Jvc29mdCBUaW1l
# LVN0YW1wIFBDQSAyMDEwMIICIjANBgkqhkiG9w0BAQEFAAOCAg8AMIICCgKCAgEA
# 5OGmTOe0ciELeaLL1yR5vQ7VgtP97pwHB9KpbE51yMo1V/YBf2xK4OK9uT4XYDP/
# XE/HZveVU3Fa4n5KWv64NmeFRiMMtY0Tz3cywBAY6GB9alKDRLemjkZrBxTzxXb1
# hlDcwUTIcVxRMTegCjhuje3XD9gmU3w5YQJ6xKr9cmmvHaus9ja+NSZk2pg7uhp7
# M62AW36MEBydUv626GIl3GoPz130/o5Tz9bshVZN7928jaTjkY+yOSxRnOlwaQ3K
# Ni1wjjHINSi947SHJMPgyY9+tVSP3PoFVZhtaDuaRr3tpK56KTesy+uDRedGbsoy
# 1cCGMFxPLOJiss254o2I5JasAUq7vnGpF1tnYN74kpEeHT39IM9zfUGaRnXNxF80
# 3RKJ1v2lIH1+/NmeRd+2ci/bfV+AutuqfjbsNkz2K26oElHovwUDo9Fzpk03dJQc
# NIIP8BDyt0cY7afomXw/TNuvXsLz1dhzPUNOwTM5TI4CvEJoLhDqhFFG4tG9ahha
# YQFzymeiXtcodgLiMxhy16cg8ML6EgrXY28MyTZki1ugpoMhXV8wdJGUlNi5UPkL
# iWHzNgY1GIRH29wb0f2y1BzFa/ZcUlFdEtsluq9QBXpsxREdcu+N+VLEhReTwDwV
# 2xo3xwgVGD94q0W29R6HXtqPnhZyacaue7e3PmriLq0CAwEAAaOCAd0wggHZMBIG
# CSsGAQQBgjcVAQQFAgMBAAEwIwYJKwYBBAGCNxUCBBYEFCqnUv5kxJq+gpE8RjUp
# zxD/LwTuMB0GA1UdDgQWBBSfpxVdAF5iXYP05dJlpxtTNRnpcjBcBgNVHSAEVTBT
# MFEGDCsGAQQBgjdMg30BATBBMD8GCCsGAQUFBwIBFjNodHRwOi8vd3d3Lm1pY3Jv
# c29mdC5jb20vcGtpb3BzL0RvY3MvUmVwb3NpdG9yeS5odG0wEwYDVR0lBAwwCgYI
# KwYBBQUHAwgwGQYJKwYBBAGCNxQCBAweCgBTAHUAYgBDAEEwCwYDVR0PBAQDAgGG
# MA8GA1UdEwEB/wQFMAMBAf8wHwYDVR0jBBgwFoAU1fZWy4/oolxiaNE9lJBb186a
# GMQwVgYDVR0fBE8wTTBLoEmgR4ZFaHR0cDovL2NybC5taWNyb3NvZnQuY29tL3Br
# aS9jcmwvcHJvZHVjdHMvTWljUm9vQ2VyQXV0XzIwMTAtMDYtMjMuY3JsMFoGCCsG
# AQUFBwEBBE4wTDBKBggrBgEFBQcwAoY+aHR0cDovL3d3dy5taWNyb3NvZnQuY29t
# L3BraS9jZXJ0cy9NaWNSb29DZXJBdXRfMjAxMC0wNi0yMy5jcnQwDQYJKoZIhvcN
# AQELBQADggIBAJ1VffwqreEsH2cBMSRb4Z5yS/ypb+pcFLY+TkdkeLEGk5c9MTO1
# OdfCcTY/2mRsfNB1OW27DzHkwo/7bNGhlBgi7ulmZzpTTd2YurYeeNg2LpypglYA
# A7AFvonoaeC6Ce5732pvvinLbtg/SHUB2RjebYIM9W0jVOR4U3UkV7ndn/OOPcbz
# aN9l9qRWqveVtihVJ9AkvUCgvxm2EhIRXT0n4ECWOKz3+SmJw7wXsFSFQrP8DJ6L
# GYnn8AtqgcKBGUIZUnWKNsIdw2FzLixre24/LAl4FOmRsqlb30mjdAy87JGA0j3m
# Sj5mO0+7hvoyGtmW9I/2kQH2zsZ0/fZMcm8Qq3UwxTSwethQ/gpY3UA8x1RtnWN0
# SCyxTkctwRQEcb9k+SS+c23Kjgm9swFXSVRk2XPXfx5bRAGOWhmRaw2fpCjcZxko
# JLo4S5pu+yFUa2pFEUep8beuyOiJXk+d0tBMdrVXVAmxaQFEfnyhYWxz/gq77EFm
# PWn9y8FBSX5+k77L+DvktxW/tM4+pTFRhLy/AsGConsXHRWJjXD+57XQKBqJC482
# 2rpM+Zv/Cuk0+CQ1ZyvgDbjmjJnW4SLq8CdCPSWU5nR0W2rRnj7tfqAxM328y+l7
# vzhwRNGQ8cirOoo6CGJ/2XBjU02N7oJtpQUQwXEGahC0HVUzWLOhcGbyoYIC0jCC
# AjsCAQEwgfyhgdSkgdEwgc4xCzAJBgNVBAYTAlVTMRMwEQYDVQQIEwpXYXNoaW5n
# dG9uMRAwDgYDVQQHEwdSZWRtb25kMR4wHAYDVQQKExVNaWNyb3NvZnQgQ29ycG9y
# YXRpb24xKTAnBgNVBAsTIE1pY3Jvc29mdCBPcGVyYXRpb25zIFB1ZXJ0byBSaWNv
# MSYwJAYDVQQLEx1UaGFsZXMgVFNTIEVTTjo3ODgwLUUzOTAtODAxNDElMCMGA1UE
# AxMcTWljcm9zb2Z0IFRpbWUtU3RhbXAgU2VydmljZaIjCgEBMAcGBSsOAwIaAxUA
# bLr8xJ9BB4rL4Yg58X1LZ5iQdyyggYMwgYCkfjB8MQswCQYDVQQGEwJVUzETMBEG
# A1UECBMKV2FzaGluZ3RvbjEQMA4GA1UEBxMHUmVkbW9uZDEeMBwGA1UEChMVTWlj
# cm9zb2Z0IENvcnBvcmF0aW9uMSYwJAYDVQQDEx1NaWNyb3NvZnQgVGltZS1TdGFt
# cCBQQ0EgMjAxMDANBgkqhkiG9w0BAQUFAAIFAOdh4KswIhgPMjAyMzAxMDYwMzUw
# MDNaGA8yMDIzMDEwNzAzNTAwM1owdzA9BgorBgEEAYRZCgQBMS8wLTAKAgUA52Hg
# qwIBADAKAgEAAgIPEwIB/zAHAgEAAgISwjAKAgUA52MyKwIBADA2BgorBgEEAYRZ
# CgQCMSgwJjAMBgorBgEEAYRZCgMCoAowCAIBAAIDB6EgoQowCAIBAAIDAYagMA0G
# CSqGSIb3DQEBBQUAA4GBAAUhHiHBiVBXNsC+ZxVLdMveezPz8XlvNOnKNuXRKryC
# yn2FGjH0f6BeyawuSatYyt+dz4QvpFjyjGQ794ESU5NhLVtCZUgv/zLg0IbN3Y3I
# apfwWy5dj4blfF4KqNjXZgj7HS83jWWAZUotz06DYtthqE/8WcqJU58vOCiifEQm
# MYIEDTCCBAkCAQEwgZMwfDELMAkGA1UEBhMCVVMxEzARBgNVBAgTCldhc2hpbmd0
# b24xEDAOBgNVBAcTB1JlZG1vbmQxHjAcBgNVBAoTFU1pY3Jvc29mdCBDb3Jwb3Jh
# dGlvbjEmMCQGA1UEAxMdTWljcm9zb2Z0IFRpbWUtU3RhbXAgUENBIDIwMTACEzMA
# AAGoVfBhqcwwGFwAAQAAAagwDQYJYIZIAWUDBAIBBQCgggFKMBoGCSqGSIb3DQEJ
# AzENBgsqhkiG9w0BCRABBDAvBgkqhkiG9w0BCQQxIgQgnz6i60IqVcW7bUgjx+PR
# ZHldRGR+MIy9L7tu92sW4+4wgfoGCyqGSIb3DQEJEAIvMYHqMIHnMIHkMIG9BCB0
# /ssdAMsHwnNwhfFBXPlFnRvWhHqSX9YLUxBDl1xlpjCBmDCBgKR+MHwxCzAJBgNV
# BAYTAlVTMRMwEQYDVQQIEwpXYXNoaW5ndG9uMRAwDgYDVQQHEwdSZWRtb25kMR4w
# HAYDVQQKExVNaWNyb3NvZnQgQ29ycG9yYXRpb24xJjAkBgNVBAMTHU1pY3Jvc29m
# dCBUaW1lLVN0YW1wIFBDQSAyMDEwAhMzAAABqFXwYanMMBhcAAEAAAGoMCIEIC1E
# 2fUXKUsOZ49KP+VfCiL7d+asqyi6Na3MUsZRmDk5MA0GCSqGSIb3DQEBCwUABIIC
# AI2EImdXuyysug9+b4CvjhfQGODGxb4xzmopuFqPO6EeNX0FoxbTnm4/UUVGB4id
# JMDCQ/AS+nb3jr7mSS21xQ6pZaKZI/LC0luClpatmKGtp7Q0z7CGW670aLwaYqFi
# vIHzUf/slPW5tnXiqGgli9+BUlMkdjBkDpmLT+pOqmfumz37oA6tQPUmdLmg61L/
# U/GZwbLCQbxR++3La06WefRbzM/0ok1d4o8Sk2ezbDciTzrT7JzuwRzVHHOPs+KE
# wub3nLf4GiUf0sER4XHDyg4R7AzuqAaB7Y27TiyVj9usIZu2hgrJMnKPxcpfU00P
# FHbvnxNMmOU2OSYZOGhSmM0Oy7yDuYxdht0va1QKjY1FXK7jQ1bMECjseYg9H5Ov
# K3vr6Lk5sf/D1cVqcrqrV+Yody8265dYeA/Y8lOJdX1PZnCXcoGCOLgUaGm7rLej
# /mnzHayCotTErNCcJmo4pd+2Zw7/6tBuQywnkWNk30beEgHwwIyob/XCb6ASJ+oI
# iMTH7bA3aXXjUzZg9rrDYc5i7StE8cRgh0yIDnf1+pncPI1RQ4lAbOLjO4pYYwB0
# +bsY+Y92LvXk+BrpJjz3wRhj0e1bMLJ58BTVlRryYvuaR9WqDBdWYRY1mzix4j2r
# ZXaF3XzQ7ynjGq4MiI7t20rW34eptTeHxR9/4XyxY59k
# SIG # End signature block
