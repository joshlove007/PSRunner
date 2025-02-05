
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
Updates a data connection.
.Description
Updates a data connection.
.Example
$dataConnectionProperties = New-Object -Type Microsoft.Azure.PowerShell.Cmdlets.Kusto.Models.Api20221229.EventHubDataConnection -Property @{Location="East US"; Kind="EventHub"; EventHubResourceId="/subscriptions/$subscriptionId/resourcegroups/$resourceGroupName/providers/Microsoft.EventHub/namespaces/myeventhubns/eventhubs/myeventhub"; DataFormat="JSON"; ConsumerGroup='Default'; Compression= "None"; TableName = "Events"; MappingRuleName = "EventsMapping1"}
Update-AzKustoDataConnection -ResourceGroupName $resourceGroupName -ClusterName "testnewkustocluster" -DatabaseName "mykustodatabase" -DataConnectionName "mykustodataconnection" -Parameter $dataConnectionProperties

Kind     Location Name                                               Type
----     -------- ----                                               ----
EventHub East US  testnewkustocluster/mykustodatabase/mykustodataconnection Microsoft.Kusto/Clusters/Databases/DataConnections

.Link
https://learn.microsoft.com/powershell/module/az.kusto/update-azkustodataconnection
#>
function Update-AzKustoDataConnection {
    [OutputType([Microsoft.Azure.PowerShell.Cmdlets.Kusto.Models.Api20221229.IDataConnection])]
    [CmdletBinding(DefaultParameterSetName = 'UpdateExpandedEventHub', PositionalBinding = $false, SupportsShouldProcess, ConfirmImpact = 'Medium')]
    param(
        [Parameter(ParameterSetName = 'UpdateExpandedEventHub', Mandatory)]
        [Parameter(ParameterSetName = 'UpdateExpandedEventGrid', Mandatory)]
        [Parameter(ParameterSetName = 'UpdateExpandedIotHub', Mandatory)]
        [Parameter(ParameterSetName = 'UpdateExpandedCosmosDb', Mandatory)]
        [Microsoft.Azure.PowerShell.Cmdlets.Kusto.Category('Path')]
        [System.String]
        # The name of the Kusto cluster.
        ${ClusterName},

        [Parameter(ParameterSetName = 'UpdateExpandedEventHub', Mandatory)]
        [Parameter(ParameterSetName = 'UpdateExpandedEventGrid', Mandatory)]
        [Parameter(ParameterSetName = 'UpdateExpandedIotHub', Mandatory)]
        [Parameter(ParameterSetName = 'UpdateExpandedCosmosDb', Mandatory)]
        [Microsoft.Azure.PowerShell.Cmdlets.Kusto.Category('Path')]
        [System.String]
        # The name of the database in the Kusto cluster.
        ${DatabaseName},

        [Parameter(ParameterSetName = 'UpdateExpandedEventHub', Mandatory)]
        [Parameter(ParameterSetName = 'UpdateExpandedEventGrid', Mandatory)]
        [Parameter(ParameterSetName = 'UpdateExpandedIotHub', Mandatory)]
        [Parameter(ParameterSetName = 'UpdateExpandedCosmosDb', Mandatory)]
        [Alias('DataConnectionName')]
        [Microsoft.Azure.PowerShell.Cmdlets.Kusto.Category('Path')]
        [System.String]
        # The name of the data connection.
        ${Name},

        [Parameter(ParameterSetName = 'UpdateExpandedEventHub', Mandatory)]
        [Parameter(ParameterSetName = 'UpdateExpandedEventGrid', Mandatory)]
        [Parameter(ParameterSetName = 'UpdateExpandedIotHub', Mandatory)]
        [Parameter(ParameterSetName = 'UpdateExpandedCosmosDb', Mandatory)]
        [Microsoft.Azure.PowerShell.Cmdlets.Kusto.Category('Path')]
        [System.String]
        # The name of the resource group containing the Kusto cluster.
        ${ResourceGroupName},

        [Parameter(ParameterSetName = 'UpdateExpandedEventHub')]
        [Parameter(ParameterSetName = 'UpdateExpandedEventGrid')]
        [Parameter(ParameterSetName = 'UpdateExpandedIotHub')]
        [Parameter(ParameterSetName = 'UpdateExpandedCosmosDb')]
        [Microsoft.Azure.PowerShell.Cmdlets.Kusto.Category('Path')]
        [Microsoft.Azure.PowerShell.Cmdlets.Kusto.Runtime.DefaultInfo(Script = '(Get-AzContext).Subscription.Id')]
        [System.String]
        # Gets subscription credentials which uniquely identify Microsoft Azure subscription.
        # The subscription ID forms part of the URI for every service call.
        ${SubscriptionId},

        [Parameter(ParameterSetName = 'UpdateViaIdentityExpandedEventHub', Mandatory, ValueFromPipeline)]
        [Parameter(ParameterSetName = 'UpdateViaIdentityExpandedEventGrid', Mandatory, ValueFromPipeline)]
        [Parameter(ParameterSetName = 'UpdateViaIdentityExpandedIotHub', Mandatory, ValueFromPipeline)]
        [Parameter(ParameterSetName = 'UpdateViaIdentityExpandedCosmosDb', Mandatory, ValueFromPipeline)]
        [Microsoft.Azure.PowerShell.Cmdlets.Kusto.Category('Path')]
        [Microsoft.Azure.PowerShell.Cmdlets.Kusto.Models.IKustoIdentity]
        # Identity Parameter
        # To construct, see NOTES section for INPUTOBJECT properties and create a hash table.
        ${InputObject},

        [Parameter(Mandatory)]
        [ArgumentCompleter( { param ( $CommandName, $ParameterName, $WordToComplete, $CommandAst, $FakeBoundParameters ) return @('EventHub', 'EventGrid', 'IotHub', 'CosmosDb') })]
        [Microsoft.Azure.PowerShell.Cmdlets.Kusto.Category('Body')]
        [Microsoft.Azure.PowerShell.Cmdlets.Kusto.Support.Kind]
        # Kind of the endpoint for the data connection
        ${Kind},

        [Parameter(ParameterSetName = 'UpdateExpandedEventHub', Mandatory)]
        [Parameter(ParameterSetName = 'UpdateExpandedEventGrid', Mandatory)]
        [Parameter(ParameterSetName = 'UpdateViaIdentityExpandedEventHub', Mandatory)]
        [Parameter(ParameterSetName = 'UpdateViaIdentityExpandedEventGrid', Mandatory)]
        [Microsoft.Azure.PowerShell.Cmdlets.Kusto.Category('Body')]
        [System.String]
        # The resource ID of the event hub to be used to create a data connection / event grid is configured to send events.
        ${EventHubResourceId},

        [Parameter(ParameterSetName = 'UpdateExpandedEventHub', Mandatory)]
        [Parameter(ParameterSetName = 'UpdateExpandedEventGrid', Mandatory)]
        [Parameter(ParameterSetName = 'UpdateExpandedIotHub', Mandatory)]
        [Parameter(ParameterSetName = 'UpdateViaIdentityExpandedEventHub', Mandatory)]
        [Parameter(ParameterSetName = 'UpdateViaIdentityExpandedEventGrid', Mandatory)]
        [Parameter(ParameterSetName = 'UpdateViaIdentityExpandedIotHub', Mandatory)]
        [Microsoft.Azure.PowerShell.Cmdlets.Kusto.Category('Body')]
        [System.String]
        # The event/iot hub consumer group.
        ${ConsumerGroup},

        [Parameter(ParameterSetName = 'UpdateExpandedEventGrid')]
        [Parameter(ParameterSetName = 'UpdateViaIdentityExpandedEventGrid')]
        [Microsoft.Azure.PowerShell.Cmdlets.Kusto.Category('Body')]
        [Microsoft.Azure.PowerShell.Cmdlets.Kusto.Support.BlobStorageEventType]
        # The name of blob storage event type to process.
        ${BlobStorageEventType},

        [Parameter(ParameterSetName = 'UpdateExpandedEventGrid')]
        [Parameter(ParameterSetName = 'UpdateViaIdentityExpandedEventGrid')]
        [Microsoft.Azure.PowerShell.Cmdlets.Kusto.Category('Body')]
        [System.Management.Automation.SwitchParameter]
        # If set to true, indicates that ingestion should ignore the first record of every file.
        ${IgnoreFirstRecord},

        [Parameter(ParameterSetName = 'UpdateExpandedEventHub')]
        [Parameter(ParameterSetName = 'UpdateExpandedEventGrid')]
        [Parameter(ParameterSetName = 'UpdateExpandedIotHub')]
        [Parameter(ParameterSetName = 'UpdateViaIdentityExpandedEventHub')]
        [Parameter(ParameterSetName = 'UpdateViaIdentityExpandedEventGrid')]
        [Parameter(ParameterSetName = 'UpdateViaIdentityExpandedIotHub')]
        [Microsoft.Azure.PowerShell.Cmdlets.Kusto.Category('Body')]
        [System.String]
        [ValidateSet( "MULTIJSON", "JSON", "CSV", "TSV", "SCSV", "SOHSV", "PSV", "TXT", "RAW", "SINGLEJSON", "AVRO", "TSVE", "PARQUET", "ORC", "APACHEAVRO", "W3CLOGFILE")]
        # The data format of the message. Optionally the data format can be added to each message.
        ${DataFormat},

        [Parameter(ParameterSetName = 'UpdateExpandedEventHub')]
        [Parameter(ParameterSetName = 'UpdateExpandedIotHub')]
        [Parameter(ParameterSetName = 'UpdateViaIdentityExpandedEventHub')]
        [Parameter(ParameterSetName = 'UpdateViaIdentityExpandedIotHub')]
        [Microsoft.Azure.PowerShell.Cmdlets.Kusto.Category('Body')]
        [System.String[]]
        # System properties of the event/iot hub.
        ${EventSystemProperty},

        [Parameter()]
        [Microsoft.Azure.PowerShell.Cmdlets.Kusto.Category('Body')]
        [System.String]
        # The mapping rule to be used to ingest the data. Optionally the mapping information can be added to each message.
        ${MappingRuleName},

        [Parameter(ParameterSetName = 'UpdateExpandedEventHub')]
        [Parameter(ParameterSetName = 'UpdateExpandedEventGrid')]
        [Parameter(ParameterSetName = 'UpdateExpandedIotHub')]
        [Parameter(ParameterSetName = 'UpdateExpandedCosmosDb', Mandatory)]
        [Parameter(ParameterSetName = 'UpdateViaIdentityExpandedEventHub')]
        [Parameter(ParameterSetName = 'UpdateViaIdentityExpandedEventGrid')]
        [Parameter(ParameterSetName = 'UpdateViaIdentityExpandedIotHub')]
        [Parameter(ParameterSetName = 'UpdateViaIdentityExpandedCosmosDb', Mandatory)]
        [Microsoft.Azure.PowerShell.Cmdlets.Kusto.Category('Body')]
        [System.String]
        # The table where the data should be ingested. Optionally the table information can be added to each message.
        ${TableName},

        [Parameter(ParameterSetName = 'UpdateExpandedEventHub')]
        [Parameter(ParameterSetName = 'UpdateViaIdentityExpandedEventHub')]
        [Microsoft.Azure.PowerShell.Cmdlets.Kusto.Category('Body')]
        [Microsoft.Azure.PowerShell.Cmdlets.Kusto.Support.Compression]
        # The event hub messages compression type.
        ${Compression},

        [Parameter(ParameterSetName = 'UpdateExpandedEventGrid', Mandatory)]
        [Parameter(ParameterSetName = 'UpdateViaIdentityExpandedEventGrid', Mandatory)]
        [Microsoft.Azure.PowerShell.Cmdlets.Kusto.Category('Body')]
        [System.String]
        # The resource ID of the storage account where the data resides.
        ${StorageAccountResourceId},

        [Parameter(ParameterSetName = 'UpdateExpandedIotHub', Mandatory)]
        [Parameter(ParameterSetName = 'UpdateViaIdentityExpandedIotHub', Mandatory)]
        [Microsoft.Azure.PowerShell.Cmdlets.Kusto.Category('Body')]
        [System.String]
        # The resource ID of the Iot hub to be used to create a data connection.
        ${IotHubResourceId},

        [Parameter(ParameterSetName = 'UpdateExpandedIotHub', Mandatory)]
        [Parameter(ParameterSetName = 'UpdateViaIdentityExpandedIotHub', Mandatory)]
        [Microsoft.Azure.PowerShell.Cmdlets.Kusto.Category('Body')]
        [System.String]
        # The name of the share access policy.
        ${SharedAccessPolicyName},

        [Parameter(ParameterSetName = 'UpdateExpandedEventHub')]
        [Parameter(ParameterSetName = 'UpdateViaIdentityExpandedEventHub')]
        [Parameter(ParameterSetName = 'UpdateExpandedEventGrid')]
        [Parameter(ParameterSetName = 'UpdateViaIdentityExpandedEventGrid')]
        [Parameter(ParameterSetName = 'UpdateExpandedCosmosDb', Mandatory)]
        [Parameter(ParameterSetName = 'UpdateViaIdentityExpandedCosmosDb', Mandatory)]
        [Microsoft.Azure.PowerShell.Cmdlets.Kusto.Category('Body')]
        [System.String]
        # The resource ID of a managed identity (system or user assigned) to be used to authenticate with external resources.
        ${ManagedIdentityResourceId},

        [Parameter(ParameterSetName = 'UpdateExpandedEventHub')]
        [Parameter(ParameterSetName = 'UpdateViaIdentityExpandedEventHub')]
        [Parameter(ParameterSetName = 'UpdateExpandedEventGrid')]
        [Parameter(ParameterSetName = 'UpdateViaIdentityExpandedEventGrid')]
        [Parameter(ParameterSetName = 'UpdateExpandedIotHub')]
        [Parameter(ParameterSetName = 'UpdateViaIdentityExpandedIotHub')]
        [Microsoft.Azure.PowerShell.Cmdlets.Kusto.Category('Body')]
        [Microsoft.Azure.PowerShell.Cmdlets.Kusto.Support.DatabaseRouting]
        # Indication for database routing information from the data connection, by default only database routing information is allowed.
        ${DatabaseRouting},

        [Parameter(ParameterSetName = 'UpdateExpandedEventHub')]
        [Parameter(ParameterSetName = 'UpdateViaIdentityExpandedEventHub')]
        [Parameter(ParameterSetName = 'UpdateExpandedIotHub')]
        [Parameter(ParameterSetName = 'UpdateViaIdentityExpandedIotHub')]
        [Parameter(ParameterSetName = 'UpdateExpandedCosmosDb')]
        [Parameter(ParameterSetName = 'UpdateViaIdentityExpandedCosmosDb')]
        [Microsoft.Azure.PowerShell.Cmdlets.Kusto.Category('Body')]
        [System.DateTime]
        # When defined, the data connection retrieves existing Event hub events created since the Retrieval start date. It can only retrieve events retained by the Event hub, based on its retention period.
        ${RetrievalStartDate},

        [Parameter(ParameterSetName = 'UpdateExpandedEventGrid')]
        [Parameter(ParameterSetName = 'UpdateViaIdentityExpandedEventGrid')]
        [Microsoft.Azure.PowerShell.Cmdlets.Kusto.Category('Body')]
        [System.String]
        # The resource ID of the event grid that is subscribed to the storage account events.
        ${EventGridResourceId},

        [Parameter(ParameterSetName = 'UpdateExpandedCosmosDb', Mandatory)]
        [Parameter(ParameterSetName = 'UpdateViaIdentityExpandedCosmosDb', Mandatory)]
        [Microsoft.Azure.PowerShell.Cmdlets.Kusto.Category('Body')]
        [System.String]
        # The resource ID of the Cosmos DB account used to create the data connection.
        ${CosmosDbAccountResourceId},

        [Parameter(ParameterSetName = 'UpdateExpandedCosmosDb', Mandatory)]
        [Parameter(ParameterSetName = 'UpdateViaIdentityExpandedCosmosDb', Mandatory)]
        [Microsoft.Azure.PowerShell.Cmdlets.Kusto.Category('Body')]
        [System.String]
        # The name of an existing database in the Cosmos DB account.
        ${CosmosDbDatabase},

        [Parameter(ParameterSetName = 'UpdateExpandedCosmosDb', Mandatory)]
        [Parameter(ParameterSetName = 'UpdateViaIdentityExpandedCosmosDb', Mandatory)]
        [Microsoft.Azure.PowerShell.Cmdlets.Kusto.Category('Body')]
        [System.String]
        # The name of an existing container in the Cosmos DB database.
        ${CosmosDbContainer},

        [Parameter(Mandatory)]
        [Microsoft.Azure.PowerShell.Cmdlets.Kusto.Category('Body')]
        [System.String]
        # Resource location.
        ${Location},

        [Parameter()]
        [Alias('AzureRMContext', 'AzureCredential')]
        [ValidateNotNull()]
        [Microsoft.Azure.PowerShell.Cmdlets.Kusto.Category('Azure')]
        [System.Management.Automation.PSObject]
        # The credentials, account, tenant, and subscription used for communication with Azure.
        ${DefaultProfile},

        [Parameter()]
        [Microsoft.Azure.PowerShell.Cmdlets.Kusto.Category('Runtime')]
        [System.Management.Automation.SwitchParameter]
        # Run the command as a job
        ${AsJob},

        [Parameter(DontShow)]
        [Microsoft.Azure.PowerShell.Cmdlets.Kusto.Category('Runtime')]
        [System.Management.Automation.SwitchParameter]
        # Wait for .NET debugger to attach
        ${Break},

        [Parameter(DontShow)]
        [ValidateNotNull()]
        [Microsoft.Azure.PowerShell.Cmdlets.Kusto.Category('Runtime')]
        [Microsoft.Azure.PowerShell.Cmdlets.Kusto.Runtime.SendAsyncStep[]]
        # SendAsync Pipeline Steps to be appended to the front of the pipeline
        ${HttpPipelineAppend},

        [Parameter(DontShow)]
        [ValidateNotNull()]
        [Microsoft.Azure.PowerShell.Cmdlets.Kusto.Category('Runtime')]
        [Microsoft.Azure.PowerShell.Cmdlets.Kusto.Runtime.SendAsyncStep[]]
        # SendAsync Pipeline Steps to be prepended to the front of the pipeline
        ${HttpPipelinePrepend},

        [Parameter()]
        [Microsoft.Azure.PowerShell.Cmdlets.Kusto.Category('Runtime')]
        [System.Management.Automation.SwitchParameter]
        # Run the command asynchronously
        ${NoWait},

        [Parameter(DontShow)]
        [Microsoft.Azure.PowerShell.Cmdlets.Kusto.Category('Runtime')]
        [System.Uri]
        # The URI for the proxy server to use
        ${Proxy},

        [Parameter(DontShow)]
        [ValidateNotNull()]
        [Microsoft.Azure.PowerShell.Cmdlets.Kusto.Category('Runtime')]
        [System.Management.Automation.PSCredential]
        # Credentials for a proxy server to use for the remote call
        ${ProxyCredential},

        [Parameter(DontShow)]
        [Microsoft.Azure.PowerShell.Cmdlets.Kusto.Category('Runtime')]
        [System.Management.Automation.SwitchParameter]
        # Use the default credentials for the proxy
        ${ProxyUseDefaultCredentials}
    )

    process {
        try {
            if ($PSBoundParameters['Kind'] -eq 'EventHub') {
                $Parameter = [Microsoft.Azure.PowerShell.Cmdlets.Kusto.Models.Api20221229.EventHubDataConnection]::new()
                
                $Parameter.EventHubResourceId = $PSBoundParameters['EventHubResourceId']            
                $null = $PSBoundParameters.Remove('EventHubResourceId')

                if ($PSBoundParameters.ContainsKey('DataFormat')) {
                    $Parameter.DataFormat = $PSBoundParameters['DataFormat']
                    $null = $PSBoundParameters.Remove('DataFormat')
                }

                if ($PSBoundParameters.ContainsKey('ConsumerGroup')) {
                    $Parameter.ConsumerGroup = $PSBoundParameters['ConsumerGroup']
                    $null = $PSBoundParameters.Remove('ConsumerGroup')
                }
                
                if ($PSBoundParameters.ContainsKey('EventSystemProperty')) {
                    $Parameter.EventSystemProperty = $PSBoundParameters['EventSystemProperty']
                    $null = $PSBoundParameters.Remove('EventSystemProperty')
                }

                if ($PSBoundParameters.ContainsKey('Compression')) {
                    $Parameter.Compression = $PSBoundParameters['Compression']
                    $null = $PSBoundParameters.Remove('Compression')
                }

                if ($PSBoundParameters.ContainsKey('ManagedIdentityResourceId')) {
                    $Parameter.ManagedIdentityResourceId = $PSBoundParameters['ManagedIdentityResourceId']
                    $null = $PSBoundParameters.Remove('ManagedIdentityResourceId')
                }

                if ($PSBoundParameters.ContainsKey('DatabaseRouting')) {
                    $Parameter.DatabaseRouting = $PSBoundParameters['DatabaseRouting']
                    $null = $PSBoundParameters.Remove('DatabaseRouting')
                }

                if ($PSBoundParameters.ContainsKey('RetrievalStartDate')) {
                    $Parameter.RetrievalStartDate = $PSBoundParameters['RetrievalStartDate']
                    $null = $PSBoundParameters.Remove('RetrievalStartDate')
                }
            }
            elseif ($PSBoundParameters['Kind'] -eq 'EventGrid') {
                $Parameter = [Microsoft.Azure.PowerShell.Cmdlets.Kusto.Models.Api20221229.EventGridDataConnection]::new()
            
                $Parameter.EventHubResourceId = $PSBoundParameters['EventHubResourceId']
                $null = $PSBoundParameters.Remove('EventHubResourceId')

                $Parameter.StorageAccountResourceId = $PSBoundParameters['StorageAccountResourceId']
                $null = $PSBoundParameters.Remove('StorageAccountResourceId')

                if ($PSBoundParameters.ContainsKey('DataFormat')) {
                    $Parameter.DataFormat = $PSBoundParameters['DataFormat']
                    $null = $PSBoundParameters.Remove('DataFormat')
                }

                if ($PSBoundParameters.ContainsKey('ConsumerGroup')) {
                    $Parameter.ConsumerGroup = $PSBoundParameters['ConsumerGroup']
                    $null = $PSBoundParameters.Remove('ConsumerGroup')
                }
                
                if ($PSBoundParameters.ContainsKey('BlobStorageEventType')) {
                    $Parameter.BlobStorageEventType = $PSBoundParameters['BlobStorageEventType']
                    $null = $PSBoundParameters.Remove('BlobStorageEventType')
                }

                if ($PSBoundParameters.ContainsKey('IgnoreFirstRecord')) {
                    $Parameter.IgnoreFirstRecord = $PSBoundParameters['IgnoreFirstRecord']
                    $null = $PSBoundParameters.Remove('IgnoreFirstRecord')
                }

                if ($PSBoundParameters.ContainsKey('EventGridResourceId')) {
                    $Parameter.EventGridResourceId = $PSBoundParameters['EventGridResourceId']
                    $null = $PSBoundParameters.Remove('EventGridResourceId')
                }

                if ($PSBoundParameters.ContainsKey('ManagedIdentityResourceId')) {
                    $Parameter.ManagedIdentityResourceId = $PSBoundParameters['ManagedIdentityResourceId']
                    $null = $PSBoundParameters.Remove('ManagedIdentityResourceId')
                }

                if ($PSBoundParameters.ContainsKey('DatabaseRouting')) {
                    $Parameter.DatabaseRouting = $PSBoundParameters['DatabaseRouting']
                    $null = $PSBoundParameters.Remove('DatabaseRouting')
                }
            }
            elseif ($PSBoundParameters['Kind'] -eq 'IotHub') {
                $Parameter = [Microsoft.Azure.PowerShell.Cmdlets.Kusto.Models.Api20221229.IotHubDataConnection]::new()

                $Parameter.IotHubResourceId = $PSBoundParameters['IotHubResourceId']
                $null = $PSBoundParameters.Remove('IotHubResourceId')

                $Parameter.SharedAccessPolicyName = $PSBoundParameters['SharedAccessPolicyName']
                $null = $PSBoundParameters.Remove('SharedAccessPolicyName')

                if ($PSBoundParameters.ContainsKey('DataFormat')) {
                    $Parameter.DataFormat = $PSBoundParameters['DataFormat']
                    $null = $PSBoundParameters.Remove('DataFormat')
                }

                if ($PSBoundParameters.ContainsKey('ConsumerGroup')) {
                    $Parameter.ConsumerGroup = $PSBoundParameters['ConsumerGroup']
                    $null = $PSBoundParameters.Remove('ConsumerGroup')
                }
                
                if ($PSBoundParameters.ContainsKey('EventSystemProperty')) {
                    $Parameter.EventSystemProperty = $PSBoundParameters['EventSystemProperty']
                    $null = $PSBoundParameters.Remove('EventSystemProperty')
                }

                if ($PSBoundParameters.ContainsKey('DatabaseRouting')) {
                    $Parameter.DatabaseRouting = $PSBoundParameters['DatabaseRouting']
                    $null = $PSBoundParameters.Remove('DatabaseRouting')
                }

                if ($PSBoundParameters.ContainsKey('RetrievalStartDate')) {
                    $Parameter.RetrievalStartDate = $PSBoundParameters['RetrievalStartDate']
                    $null = $PSBoundParameters.Remove('RetrievalStartDate')
                }
            }
            elseif ($PSBoundParameters['Kind'] -eq 'CosmosDb') {
                $Parameter = [Microsoft.Azure.PowerShell.Cmdlets.Kusto.Models.Api20221229.CosmosDbDataConnection]::new()

                $Parameter.TableName = $PSBoundParameters['TableName']
                $null = $PSBoundParameters.Remove('TableName')

                $Parameter.ManagedIdentityResourceId = $PSBoundParameters['ManagedIdentityResourceId']
                $null = $PSBoundParameters.Remove('ManagedIdentityResourceId')

                $Parameter.CosmosDbAccountResourceId = $PSBoundParameters['CosmosDbAccountResourceId']
                $null = $PSBoundParameters.Remove('CosmosDbAccountResourceId')

                $Parameter.CosmosDbDatabase = $PSBoundParameters['CosmosDbDatabase']
                $null = $PSBoundParameters.Remove('CosmosDbDatabase')

                $Parameter.CosmosDbContainer = $PSBoundParameters['CosmosDbContainer']
                $null = $PSBoundParameters.Remove('CosmosDbContainer')

                if ($PSBoundParameters.ContainsKey('RetrievalStartDate')) {
                    $Parameter.RetrievalStartDate = $PSBoundParameters['RetrievalStartDate']
                    $null = $PSBoundParameters.Remove('RetrievalStartDate')
                }
            }

            $Parameter.Kind = $PSBoundParameters['Kind']
            $null = $PSBoundParameters.Remove('Kind')

            $Parameter.Location = $PSBoundParameters['Location']
            $null = $PSBoundParameters.Remove('Location')
            
            if ($PSBoundParameters.ContainsKey('MappingRuleName')) {
                $Parameter.MappingRuleName = $PSBoundParameters['MappingRuleName']
                $null = $PSBoundParameters.Remove('MappingRuleName')
            }

            if ($PSBoundParameters.ContainsKey('TableName')) {
                $Parameter.TableName = $PSBoundParameters['TableName']
                $null = $PSBoundParameters.Remove('TableName')
            }            

            $null = $PSBoundParameters.Add('Parameter', $Parameter)

            Az.Kusto.internal\Update-AzKustoDataConnection @PSBoundParameters
        }
        catch {
            throw
        }
    }
}

# SIG # Begin signature block
# MIInvwYJKoZIhvcNAQcCoIInsDCCJ6wCAQExDzANBglghkgBZQMEAgEFADB5Bgor
# BgEEAYI3AgEEoGswaTA0BgorBgEEAYI3AgEeMCYCAwEAAAQQH8w7YFlLCE63JNLG
# KX7zUQIBAAIBAAIBAAIBAAIBADAxMA0GCWCGSAFlAwQCAQUABCBzxsr8rPYabdjy
# 8q2a6a1t8aguw5VWqtBKxpOSJa4moKCCDXYwggX0MIID3KADAgECAhMzAAACy7d1
# OfsCcUI2AAAAAALLMA0GCSqGSIb3DQEBCwUAMH4xCzAJBgNVBAYTAlVTMRMwEQYD
# VQQIEwpXYXNoaW5ndG9uMRAwDgYDVQQHEwdSZWRtb25kMR4wHAYDVQQKExVNaWNy
# b3NvZnQgQ29ycG9yYXRpb24xKDAmBgNVBAMTH01pY3Jvc29mdCBDb2RlIFNpZ25p
# bmcgUENBIDIwMTEwHhcNMjIwNTEyMjA0NTU5WhcNMjMwNTExMjA0NTU5WjB0MQsw
# CQYDVQQGEwJVUzETMBEGA1UECBMKV2FzaGluZ3RvbjEQMA4GA1UEBxMHUmVkbW9u
# ZDEeMBwGA1UEChMVTWljcm9zb2Z0IENvcnBvcmF0aW9uMR4wHAYDVQQDExVNaWNy
# b3NvZnQgQ29ycG9yYXRpb24wggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIB
# AQC3sN0WcdGpGXPZIb5iNfFB0xZ8rnJvYnxD6Uf2BHXglpbTEfoe+mO//oLWkRxA
# wppditsSVOD0oglKbtnh9Wp2DARLcxbGaW4YanOWSB1LyLRpHnnQ5POlh2U5trg4
# 3gQjvlNZlQB3lL+zrPtbNvMA7E0Wkmo+Z6YFnsf7aek+KGzaGboAeFO4uKZjQXY5
# RmMzE70Bwaz7hvA05jDURdRKH0i/1yK96TDuP7JyRFLOvA3UXNWz00R9w7ppMDcN
# lXtrmbPigv3xE9FfpfmJRtiOZQKd73K72Wujmj6/Su3+DBTpOq7NgdntW2lJfX3X
# a6oe4F9Pk9xRhkwHsk7Ju9E/AgMBAAGjggFzMIIBbzAfBgNVHSUEGDAWBgorBgEE
# AYI3TAgBBggrBgEFBQcDAzAdBgNVHQ4EFgQUrg/nt/gj+BBLd1jZWYhok7v5/w4w
# RQYDVR0RBD4wPKQ6MDgxHjAcBgNVBAsTFU1pY3Jvc29mdCBDb3Jwb3JhdGlvbjEW
# MBQGA1UEBRMNMjMwMDEyKzQ3MDUyODAfBgNVHSMEGDAWgBRIbmTlUAXTgqoXNzci
# tW2oynUClTBUBgNVHR8ETTBLMEmgR6BFhkNodHRwOi8vd3d3Lm1pY3Jvc29mdC5j
# b20vcGtpb3BzL2NybC9NaWNDb2RTaWdQQ0EyMDExXzIwMTEtMDctMDguY3JsMGEG
# CCsGAQUFBwEBBFUwUzBRBggrBgEFBQcwAoZFaHR0cDovL3d3dy5taWNyb3NvZnQu
# Y29tL3BraW9wcy9jZXJ0cy9NaWNDb2RTaWdQQ0EyMDExXzIwMTEtMDctMDguY3J0
# MAwGA1UdEwEB/wQCMAAwDQYJKoZIhvcNAQELBQADggIBAJL5t6pVjIRlQ8j4dAFJ
# ZnMke3rRHeQDOPFxswM47HRvgQa2E1jea2aYiMk1WmdqWnYw1bal4IzRlSVf4czf
# zx2vjOIOiaGllW2ByHkfKApngOzJmAQ8F15xSHPRvNMmvpC3PFLvKMf3y5SyPJxh
# 922TTq0q5epJv1SgZDWlUlHL/Ex1nX8kzBRhHvc6D6F5la+oAO4A3o/ZC05OOgm4
# EJxZP9MqUi5iid2dw4Jg/HvtDpCcLj1GLIhCDaebKegajCJlMhhxnDXrGFLJfX8j
# 7k7LUvrZDsQniJZ3D66K+3SZTLhvwK7dMGVFuUUJUfDifrlCTjKG9mxsPDllfyck
# 4zGnRZv8Jw9RgE1zAghnU14L0vVUNOzi/4bE7wIsiRyIcCcVoXRneBA3n/frLXvd
# jDsbb2lpGu78+s1zbO5N0bhHWq4j5WMutrspBxEhqG2PSBjC5Ypi+jhtfu3+x76N
# mBvsyKuxx9+Hm/ALnlzKxr4KyMR3/z4IRMzA1QyppNk65Ui+jB14g+w4vole33M1
# pVqVckrmSebUkmjnCshCiH12IFgHZF7gRwE4YZrJ7QjxZeoZqHaKsQLRMp653beB
# fHfeva9zJPhBSdVcCW7x9q0c2HVPLJHX9YCUU714I+qtLpDGrdbZxD9mikPqL/To
# /1lDZ0ch8FtePhME7houuoPcMIIHejCCBWKgAwIBAgIKYQ6Q0gAAAAAAAzANBgkq
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
# /Xmfwb1tbWrJUnMTDXpQzTGCGZ8wghmbAgEBMIGVMH4xCzAJBgNVBAYTAlVTMRMw
# EQYDVQQIEwpXYXNoaW5ndG9uMRAwDgYDVQQHEwdSZWRtb25kMR4wHAYDVQQKExVN
# aWNyb3NvZnQgQ29ycG9yYXRpb24xKDAmBgNVBAMTH01pY3Jvc29mdCBDb2RlIFNp
# Z25pbmcgUENBIDIwMTECEzMAAALLt3U5+wJxQjYAAAAAAsswDQYJYIZIAWUDBAIB
# BQCgga4wGQYJKoZIhvcNAQkDMQwGCisGAQQBgjcCAQQwHAYKKwYBBAGCNwIBCzEO
# MAwGCisGAQQBgjcCARUwLwYJKoZIhvcNAQkEMSIEID/vgrUI8kkc2vWw+DNwkUld
# Qy3HsYQdOGyKbCONSSjPMEIGCisGAQQBgjcCAQwxNDAyoBSAEgBNAGkAYwByAG8A
# cwBvAGYAdKEagBhodHRwOi8vd3d3Lm1pY3Jvc29mdC5jb20wDQYJKoZIhvcNAQEB
# BQAEggEAVGVzXxclQLmUGoUryA097298MMBVahl8juqiCBSTbeCLmKW2z/OCZH/R
# tx9kcM75hMPOn37L/mQC039ildYnv3Vf9tgUuCSu4rT3w42jRJTCf42RfqpG1YxR
# fjU2V00GR91qJl4r1lBqhmTeoofhJqmH/vNKP6x7glZfgjtwtwdzODKwguWGhfsR
# h6oAIkmMRICC8lEwcTK2p8Uc657qaABmQdhZo6FEX0HMrpA6lQx7acg7+zkagZcx
# kVHyXq/P6QWaBEd787XVOB+Ne59RmdT2NHg1MzrzbeE/kAI3fRrXAayEh1lgApjL
# FADXg2qn9/gngDbuooOIH/HrUOZpM6GCFykwghclBgorBgEEAYI3AwMBMYIXFTCC
# FxEGCSqGSIb3DQEHAqCCFwIwghb+AgEDMQ8wDQYJYIZIAWUDBAIBBQAwggFZBgsq
# hkiG9w0BCRABBKCCAUgEggFEMIIBQAIBAQYKKwYBBAGEWQoDATAxMA0GCWCGSAFl
# AwQCAQUABCBbNWgSYoEYKVjZQOvod8VzogKAvLtr4N1dg/gm40pklwIGZBsIZTzk
# GBMyMDIzMDMzMDA1NDQzOC44ODdaMASAAgH0oIHYpIHVMIHSMQswCQYDVQQGEwJV
# UzETMBEGA1UECBMKV2FzaGluZ3RvbjEQMA4GA1UEBxMHUmVkbW9uZDEeMBwGA1UE
# ChMVTWljcm9zb2Z0IENvcnBvcmF0aW9uMS0wKwYDVQQLEyRNaWNyb3NvZnQgSXJl
# bGFuZCBPcGVyYXRpb25zIExpbWl0ZWQxJjAkBgNVBAsTHVRoYWxlcyBUU1MgRVNO
# OjNCRDQtNEI4MC02OUMzMSUwIwYDVQQDExxNaWNyb3NvZnQgVGltZS1TdGFtcCBT
# ZXJ2aWNloIIReDCCBycwggUPoAMCAQICEzMAAAG0+4AIRAXSLfoAAQAAAbQwDQYJ
# KoZIhvcNAQELBQAwfDELMAkGA1UEBhMCVVMxEzARBgNVBAgTCldhc2hpbmd0b24x
# EDAOBgNVBAcTB1JlZG1vbmQxHjAcBgNVBAoTFU1pY3Jvc29mdCBDb3Jwb3JhdGlv
# bjEmMCQGA1UEAxMdTWljcm9zb2Z0IFRpbWUtU3RhbXAgUENBIDIwMTAwHhcNMjIw
# OTIwMjAyMjA5WhcNMjMxMjE0MjAyMjA5WjCB0jELMAkGA1UEBhMCVVMxEzARBgNV
# BAgTCldhc2hpbmd0b24xEDAOBgNVBAcTB1JlZG1vbmQxHjAcBgNVBAoTFU1pY3Jv
# c29mdCBDb3Jwb3JhdGlvbjEtMCsGA1UECxMkTWljcm9zb2Z0IElyZWxhbmQgT3Bl
# cmF0aW9ucyBMaW1pdGVkMSYwJAYDVQQLEx1UaGFsZXMgVFNTIEVTTjozQkQ0LTRC
# ODAtNjlDMzElMCMGA1UEAxMcTWljcm9zb2Z0IFRpbWUtU3RhbXAgU2VydmljZTCC
# AiIwDQYJKoZIhvcNAQEBBQADggIPADCCAgoCggIBALRHpp5lBzJCH7zortuyvOmW
# 8FoZLBsFe9g5dbhnaq9qSpvpn86E/mJ4JKvWixH/lw7QA8gPtiiGVNIjvFhu/XiY
# 889vX5WaQSmyoPMZdj9zvXa5XrkMN05zXzTePkCIIzF6RN7cTxezOyESymTIjrdx
# X5BVlZolyQAOxNziMCYKYYNPbYd0786fDE/PhzrRt23a0Xf8trvFa0LEEy2YlcE2
# eqg2CjU/D0GZe8Ra0kjt0M12vdS4qWZ2Dpd7IhiQwnntQWu19Ytd3UBR8SpeRX+C
# cw3bjgWfOXtla6chctWt2shlMwayMOfY4TG4yMPWFXELfZFFp7cgpjZNeVsmwkvo
# V6RAwy1Y9V+VvbJ5qFtartN/rp6a0I1kGlbjuwX3L0HTVXcikqgHistXk9h3HOZ9
# WgFXlxZurG1SZmcz0BEEdya+1vGHE45KguYU9qq2LiHGBjn9z4+DqnV5tUKobsLb
# JMb4r+8st2fj8SacSsftnusxkWqEJiJS34P2uNlzVR03+ls6+ZO0NcO79LgP7BbI
# MipiOx8yh19PMQw0piaKFwOW7Q+gdJcfy6rOkG+CrYZwOzdiBHSebIzCIch2cAa+
# 38w7JFP/koKdlJ36qzdVXWv4G/qZpWycIvDKYbxJWM40+z2Stg5uHqK3I8e09kFX
# txCHpS7hm8c8m25WaEU5AgMBAAGjggFJMIIBRTAdBgNVHQ4EFgQUy0SF5fGUuDqc
# uxIot07eOMwy2X4wHwYDVR0jBBgwFoAUn6cVXQBeYl2D9OXSZacbUzUZ6XIwXwYD
# VR0fBFgwVjBUoFKgUIZOaHR0cDovL3d3dy5taWNyb3NvZnQuY29tL3BraW9wcy9j
# cmwvTWljcm9zb2Z0JTIwVGltZS1TdGFtcCUyMFBDQSUyMDIwMTAoMSkuY3JsMGwG
# CCsGAQUFBwEBBGAwXjBcBggrBgEFBQcwAoZQaHR0cDovL3d3dy5taWNyb3NvZnQu
# Y29tL3BraW9wcy9jZXJ0cy9NaWNyb3NvZnQlMjBUaW1lLVN0YW1wJTIwUENBJTIw
# MjAxMCgxKS5jcnQwDAYDVR0TAQH/BAIwADAWBgNVHSUBAf8EDDAKBggrBgEFBQcD
# CDAOBgNVHQ8BAf8EBAMCB4AwDQYJKoZIhvcNAQELBQADggIBABLRDwWMKbeCYqEq
# tI6Bs8KmF+kqDR+2G6qYAK3ZZ63bert7pCkRJbihFaktl2o18cdFJFxnOF4vXadm
# 0sabskJ05KviEMJIO6dXSq8AGtr3Zmjc895q0mnlBLuNMgk4R8KrkJMHqBuHqkUW
# XtfTrVUpgwzQt2UOiINKs+/b4r14MuXRVpOJ6cQOS8UhkeMAWl2iLlYaBGtOr3f/
# f9mLEPfWwoke0sSUbdV60OZCRh1ItBYYM9efKr14H5qu6jan6n00prEEa7W3uGb/
# 1/qj6P5emnvkqy5HI0X69DjVdLxVbjSsegm/dA+S4DaXPcfFf6iBxK/iV21l1upg
# EVVajUApl5VR40wY4XF8EpmnUdTqLXDf7CqdhDjPST2K/OjvWPyQGQvc7oPapYyk
# 66GU32AOyyHXJj6+vbtRUg/+ory+h0R2Xf5NhC+xbWcMzXEUXRRf1YKZDsRyH6r4
# 12pm8KDKE/r7Rk7aoKK7oYUpNGzNRf6QaYv5z2bVTSxkzWivFrepLHGwvRun9PYM
# /8AQSTgZr0yzzjk/97WghkqCaAwAVpyvg3uaYnuCl/AccSkGyb8c+70bFSeUephs
# fgb2r+QI7Mb2WcOnkJpCNLz0XJMS/UwlQn1ktLsiCpsqOk3aLJ2wTv6LK3u69I0v
# QB/LKRKlZYRXKUDXzoPwr3UtsTVTMIIHcTCCBVmgAwIBAgITMwAAABXF52ueAptJ
# mQAAAAAAFTANBgkqhkiG9w0BAQsFADCBiDELMAkGA1UEBhMCVVMxEzARBgNVBAgT
# Cldhc2hpbmd0b24xEDAOBgNVBAcTB1JlZG1vbmQxHjAcBgNVBAoTFU1pY3Jvc29m
# dCBDb3Jwb3JhdGlvbjEyMDAGA1UEAxMpTWljcm9zb2Z0IFJvb3QgQ2VydGlmaWNh
# dGUgQXV0aG9yaXR5IDIwMTAwHhcNMjEwOTMwMTgyMjI1WhcNMzAwOTMwMTgzMjI1
# WjB8MQswCQYDVQQGEwJVUzETMBEGA1UECBMKV2FzaGluZ3RvbjEQMA4GA1UEBxMH
# UmVkbW9uZDEeMBwGA1UEChMVTWljcm9zb2Z0IENvcnBvcmF0aW9uMSYwJAYDVQQD
# Ex1NaWNyb3NvZnQgVGltZS1TdGFtcCBQQ0EgMjAxMDCCAiIwDQYJKoZIhvcNAQEB
# BQADggIPADCCAgoCggIBAOThpkzntHIhC3miy9ckeb0O1YLT/e6cBwfSqWxOdcjK
# NVf2AX9sSuDivbk+F2Az/1xPx2b3lVNxWuJ+Slr+uDZnhUYjDLWNE893MsAQGOhg
# fWpSg0S3po5GawcU88V29YZQ3MFEyHFcUTE3oAo4bo3t1w/YJlN8OWECesSq/XJp
# rx2rrPY2vjUmZNqYO7oaezOtgFt+jBAcnVL+tuhiJdxqD89d9P6OU8/W7IVWTe/d
# vI2k45GPsjksUZzpcGkNyjYtcI4xyDUoveO0hyTD4MmPfrVUj9z6BVWYbWg7mka9
# 7aSueik3rMvrg0XnRm7KMtXAhjBcTyziYrLNueKNiOSWrAFKu75xqRdbZ2De+JKR
# Hh09/SDPc31BmkZ1zcRfNN0Sidb9pSB9fvzZnkXftnIv231fgLrbqn427DZM9itu
# qBJR6L8FA6PRc6ZNN3SUHDSCD/AQ8rdHGO2n6Jl8P0zbr17C89XYcz1DTsEzOUyO
# ArxCaC4Q6oRRRuLRvWoYWmEBc8pnol7XKHYC4jMYctenIPDC+hIK12NvDMk2ZItb
# oKaDIV1fMHSRlJTYuVD5C4lh8zYGNRiER9vcG9H9stQcxWv2XFJRXRLbJbqvUAV6
# bMURHXLvjflSxIUXk8A8FdsaN8cIFRg/eKtFtvUeh17aj54WcmnGrnu3tz5q4i6t
# AgMBAAGjggHdMIIB2TASBgkrBgEEAYI3FQEEBQIDAQABMCMGCSsGAQQBgjcVAgQW
# BBQqp1L+ZMSavoKRPEY1Kc8Q/y8E7jAdBgNVHQ4EFgQUn6cVXQBeYl2D9OXSZacb
# UzUZ6XIwXAYDVR0gBFUwUzBRBgwrBgEEAYI3TIN9AQEwQTA/BggrBgEFBQcCARYz
# aHR0cDovL3d3dy5taWNyb3NvZnQuY29tL3BraW9wcy9Eb2NzL1JlcG9zaXRvcnku
# aHRtMBMGA1UdJQQMMAoGCCsGAQUFBwMIMBkGCSsGAQQBgjcUAgQMHgoAUwB1AGIA
# QwBBMAsGA1UdDwQEAwIBhjAPBgNVHRMBAf8EBTADAQH/MB8GA1UdIwQYMBaAFNX2
# VsuP6KJcYmjRPZSQW9fOmhjEMFYGA1UdHwRPME0wS6BJoEeGRWh0dHA6Ly9jcmwu
# bWljcm9zb2Z0LmNvbS9wa2kvY3JsL3Byb2R1Y3RzL01pY1Jvb0NlckF1dF8yMDEw
# LTA2LTIzLmNybDBaBggrBgEFBQcBAQROMEwwSgYIKwYBBQUHMAKGPmh0dHA6Ly93
# d3cubWljcm9zb2Z0LmNvbS9wa2kvY2VydHMvTWljUm9vQ2VyQXV0XzIwMTAtMDYt
# MjMuY3J0MA0GCSqGSIb3DQEBCwUAA4ICAQCdVX38Kq3hLB9nATEkW+Geckv8qW/q
# XBS2Pk5HZHixBpOXPTEztTnXwnE2P9pkbHzQdTltuw8x5MKP+2zRoZQYIu7pZmc6
# U03dmLq2HnjYNi6cqYJWAAOwBb6J6Gngugnue99qb74py27YP0h1AdkY3m2CDPVt
# I1TkeFN1JFe53Z/zjj3G82jfZfakVqr3lbYoVSfQJL1AoL8ZthISEV09J+BAljis
# 9/kpicO8F7BUhUKz/AyeixmJ5/ALaoHCgRlCGVJ1ijbCHcNhcy4sa3tuPywJeBTp
# kbKpW99Jo3QMvOyRgNI95ko+ZjtPu4b6MhrZlvSP9pEB9s7GdP32THJvEKt1MMU0
# sHrYUP4KWN1APMdUbZ1jdEgssU5HLcEUBHG/ZPkkvnNtyo4JvbMBV0lUZNlz138e
# W0QBjloZkWsNn6Qo3GcZKCS6OEuabvshVGtqRRFHqfG3rsjoiV5PndLQTHa1V1QJ
# sWkBRH58oWFsc/4Ku+xBZj1p/cvBQUl+fpO+y/g75LcVv7TOPqUxUYS8vwLBgqJ7
# Fx0ViY1w/ue10CgaiQuPNtq6TPmb/wrpNPgkNWcr4A245oyZ1uEi6vAnQj0llOZ0
# dFtq0Z4+7X6gMTN9vMvpe784cETRkPHIqzqKOghif9lwY1NNje6CbaUFEMFxBmoQ
# tB1VM1izoXBm8qGCAtQwggI9AgEBMIIBAKGB2KSB1TCB0jELMAkGA1UEBhMCVVMx
# EzARBgNVBAgTCldhc2hpbmd0b24xEDAOBgNVBAcTB1JlZG1vbmQxHjAcBgNVBAoT
# FU1pY3Jvc29mdCBDb3Jwb3JhdGlvbjEtMCsGA1UECxMkTWljcm9zb2Z0IElyZWxh
# bmQgT3BlcmF0aW9ucyBMaW1pdGVkMSYwJAYDVQQLEx1UaGFsZXMgVFNTIEVTTjoz
# QkQ0LTRCODAtNjlDMzElMCMGA1UEAxMcTWljcm9zb2Z0IFRpbWUtU3RhbXAgU2Vy
# dmljZaIjCgEBMAcGBSsOAwIaAxUAZZzYkPObl/ZzeCkSbf4B5CceCQiggYMwgYCk
# fjB8MQswCQYDVQQGEwJVUzETMBEGA1UECBMKV2FzaGluZ3RvbjEQMA4GA1UEBxMH
# UmVkbW9uZDEeMBwGA1UEChMVTWljcm9zb2Z0IENvcnBvcmF0aW9uMSYwJAYDVQQD
# Ex1NaWNyb3NvZnQgVGltZS1TdGFtcCBQQ0EgMjAxMDANBgkqhkiG9w0BAQUFAAIF
# AOfPabAwIhgPMjAyMzAzMzAwOTUxNDRaGA8yMDIzMDMzMTA5NTE0NFowdDA6Bgor
# BgEEAYRZCgQBMSwwKjAKAgUA589psAIBADAHAgEAAgIN0DAHAgEAAgIRnjAKAgUA
# 59C7MAIBADA2BgorBgEEAYRZCgQCMSgwJjAMBgorBgEEAYRZCgMCoAowCAIBAAID
# B6EgoQowCAIBAAIDAYagMA0GCSqGSIb3DQEBBQUAA4GBAEYSRYuQRKaq6SjytFrp
# QcIP4EaEpZQmehZzz1xfon6wbt6oPYjHJ1yXO4IfxKu600PWbkmGclEkiwtec/Du
# 3qrLVY+whKFMhuc4VOq62hS3AzQ98vgz/XXlrXUCMNR7Jv0DwXtkgLN1osB+9CPB
# IdF7Csflw/QIDQUh5rzMVZhdMYIEDTCCBAkCAQEwgZMwfDELMAkGA1UEBhMCVVMx
# EzARBgNVBAgTCldhc2hpbmd0b24xEDAOBgNVBAcTB1JlZG1vbmQxHjAcBgNVBAoT
# FU1pY3Jvc29mdCBDb3Jwb3JhdGlvbjEmMCQGA1UEAxMdTWljcm9zb2Z0IFRpbWUt
# U3RhbXAgUENBIDIwMTACEzMAAAG0+4AIRAXSLfoAAQAAAbQwDQYJYIZIAWUDBAIB
# BQCgggFKMBoGCSqGSIb3DQEJAzENBgsqhkiG9w0BCRABBDAvBgkqhkiG9w0BCQQx
# IgQgGsPx7I+hCQWKRNbyzOIFzfOgJzcQqw84Dzj5BZf2uekwgfoGCyqGSIb3DQEJ
# EAIvMYHqMIHnMIHkMIG9BCDTyPd75qMwcAZRcb36/6xJa3hT0eLse71ysdp4twH3
# BjCBmDCBgKR+MHwxCzAJBgNVBAYTAlVTMRMwEQYDVQQIEwpXYXNoaW5ndG9uMRAw
# DgYDVQQHEwdSZWRtb25kMR4wHAYDVQQKExVNaWNyb3NvZnQgQ29ycG9yYXRpb24x
# JjAkBgNVBAMTHU1pY3Jvc29mdCBUaW1lLVN0YW1wIFBDQSAyMDEwAhMzAAABtPuA
# CEQF0i36AAEAAAG0MCIEIG2jPyLnfKbKzmLcxbQlkDP0/YCbCzkyLqUmFxUD6VkU
# MA0GCSqGSIb3DQEBCwUABIICAJNJ2zvDhLH2GglO0GUwOeobjWLkzmuX0kKW988x
# DrT8HEviA4dVLOuXiVTScpZY/7QuJqTTet5qfQn7MXfWuOFRs0x2pFlFHOSzzL9g
# 4yVJSRNUh4ylovAVX60kVkdcldcosZTs86VijlZWsMQxFM7w2dw2ZnmiT98KuNa/
# dT0thJhBrEKtEwkenXBlStsCtxACcXGbwjV80f8q9UQABPHIBVF7PEfaXYcA7oMp
# Q33JuDIgLtq4fvf3ulMtw0ZRtbIADy923S5hPMMiVvEUBn3uYGBjjgWwybtAyg9C
# uhsQkDmSrm1cgH/xBZ1eVw3sk6G8F0xXOiPZlGPOITXMJRzplWRp4hYOUc3MFq93
# RYhIFjGWXt5eQwsSqO+RYWq17YFSWl82/AYTOeNptEgI8GVWuwUO3fMxjgOliopa
# l/bLghr2xq8jwlERdfgbYF1Dznfsy3xQQ1ZHRWxyE7N/ttLPu9bVA4456aXRRxla
# CWroua2YTuW6YroFuEIN5N/m3Dfjfd9S+q0H5Brs1S3PiWQY5W2YbD4XG2bWzy1p
# q5lV4+SL8DXKPVnY06rqSZVmq9qZUySvt+1G8+zqXkfFlMvklXWNAkZMC2Xkhgf3
# QZgV6ol3FhA6R+1JaVNkMQPW+K0jmfnZvP8WB3d+7oSZBMSO94EFaTdoISChFbOe
# kL74
# SIG # End signature block
