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
Create a CloudService Resource
.Description
Create a CloudService Resource 
#>

function New-AzCloudService {
    [OutputType('Microsoft.Azure.PowerShell.Cmdlets.CloudService.Models.Api20220904.ICloudService')]
    [CmdletBinding(PositionalBinding=$false, SupportsShouldProcess, ConfirmImpact='Medium')]
    param(
        [Parameter(ParameterSetName='quickCreateParameterSetWithoutStorage', Mandatory)]
        [Parameter(ParameterSetName='quickCreateParameterSetWithStorage', Mandatory)]
        [Alias('CloudServiceName')]
        [Microsoft.Azure.PowerShell.Cmdlets.CloudService.Category('Path')]
        [System.String]
        # Name of the cloud service.
        ${Name},

        [Parameter(ParameterSetName='quickCreateParameterSetWithoutStorage', Mandatory)]
        [Parameter(ParameterSetName='quickCreateParameterSetWithStorage', Mandatory)]
        [Microsoft.Azure.PowerShell.Cmdlets.CloudService.Category('Path')]
        [System.String]
        # Name of the resource group.
        ${ResourceGroupName},

        [Parameter(ParameterSetName='quickCreateParameterSetWithoutStorage')]
        [Parameter(ParameterSetName='quickCreateParameterSetWithStorage')]
        [Microsoft.Azure.PowerShell.Cmdlets.CloudService.Category('Path')]
        [Microsoft.Azure.PowerShell.Cmdlets.CloudService.Runtime.DefaultInfo(Script='(Get-AzContext).Subscription.Id')]
        [System.String]
        # Subscription credentials which uniquely identify Microsoft Azure subscription.
        # The subscription ID forms part of the URI for every service call.
        ${SubscriptionId},

        [Parameter(ParameterSetName='quickCreateParameterSetWithoutStorage', Mandatory)]
        [Parameter(ParameterSetName='quickCreateParameterSetWithStorage', Mandatory)]
        [Microsoft.Azure.PowerShell.Cmdlets.CloudService.Category('Body')]
        [System.String]
        # Resource location.
        ${Location},

        [Parameter(ParameterSetName='quickCreateParameterSetWithoutStorage', Mandatory)]
        [Parameter(ParameterSetName='quickCreateParameterSetWithStorage', Mandatory)]
        [Microsoft.Azure.PowerShell.Cmdlets.CloudService.Category('Body')]
        [System.String]
        # Specifies the XML service configuration (.cscfg) for the cloud service.
        ${ConfigurationFile},
        
        [Parameter(ParameterSetName='quickCreateParameterSetWithoutStorage', Mandatory, HelpMessage="Path to .csdef file.")]
        [Parameter(ParameterSetName='quickCreateParameterSetWithStorage', Mandatory, HelpMessage="Path to .csdef file.")]
        [System.String]
        # Specifies the XML service definitions (.csdef) for the cloud service. 
        ${DefinitionFile},

        [Parameter(ParameterSetName='quickCreateParameterSetWithoutStorage', Mandatory, HelpMessage='URL that refers to the location of the service package in the Blob service.')]
        [Microsoft.Azure.PowerShell.Cmdlets.CloudService.Category('Body')]
        [System.String]
        # Specifies a URL that refers to the location of the service package in the Blob service.
        # The service package URL can be Shared Access Signature (SAS) URI from any storage account.This is a write-only property and is not returned in GET calls.
        ${PackageUrl},

        [Parameter(ParameterSetName='quickCreateParameterSetWithStorage', Mandatory, HelpMessage='Path to .cspkg file. It will be uploaded to a blob')]
        [System.String]
        ${PackageFile},

        [Parameter(ParameterSetName='quickCreateParameterSetWithStorage', Mandatory, HelpMessage='Name of the storage account that will store the Package file.')]
        [System.String]
        ${StorageAccount},

        [Parameter(ParameterSetName='quickCreateParameterSetWithoutStorage', HelpMessage="Describes a cloud service extension profile.")]
        [Parameter(ParameterSetName='quickCreateParameterSetWithStorage', HelpMessage="Describes a cloud service extension profile.")]
        [Microsoft.Azure.PowerShell.Cmdlets.CloudService.Category('Body')]
        [Microsoft.Azure.PowerShell.Cmdlets.CloudService.Models.Api20220904.ICloudServiceExtensionProfile]
        # Describes a cloud service extension profile.
        # To construct, see NOTES section for EXTENSIONPROFILE properties and create a hash table.
        ${ExtensionProfile},

        [Parameter(ParameterSetName='quickCreateParameterSetWithoutStorage', HelpMessage="Indicates whether to start the cloud service immediately after it is created.")]
        [Parameter(ParameterSetName='quickCreateParameterSetWithStorage', HelpMessage="Indicates whether to start the cloud service immediately after it is created.")]
        [Microsoft.Azure.PowerShell.Cmdlets.CloudService.Category('Body')]
        [System.Management.Automation.SwitchParameter]
        # (Optional) Indicates whether to start the cloud service immediately after it is created.
        # The default value is `true`.If false, the service model is still deployed, but the code is not run immediately.
        # Instead, the service is PoweredOff until you call Start, at which time the service will be started.
        # A deployed service still incurs charges, even if it is poweredoff.
        ${StartCloudService},

        [Parameter(ParameterSetName='quickCreateParameterSetWithoutStorage')]
        [Parameter(ParameterSetName='quickCreateParameterSetWithStorage')]
        [Microsoft.Azure.PowerShell.Cmdlets.CloudService.Category('Body')]
        [Microsoft.Azure.PowerShell.Cmdlets.CloudService.Runtime.Info(PossibleTypes=([Microsoft.Azure.PowerShell.Cmdlets.CloudService.Models.Api20220904.ICloudServiceTags]))]
        [System.Collections.Hashtable]
        # Resource tags.
        ${Tag},

        [Parameter(ParameterSetName='quickCreateParameterSetWithoutStorage', HelpMessage="Update mode for the cloud service.")]
        [Parameter(ParameterSetName='quickCreateParameterSetWithStorage', HelpMessage="Update mode for the cloud service.")]
        [ArgumentCompleter([Microsoft.Azure.PowerShell.Cmdlets.CloudService.Support.CloudServiceUpgradeMode])]
        [Microsoft.Azure.PowerShell.Cmdlets.CloudService.Category('Body')]
        [Microsoft.Azure.PowerShell.Cmdlets.CloudService.Support.CloudServiceUpgradeMode]
        # Update mode for the cloud service.
        # Role instances are allocated to update domains when the service is deployed.
        # Updates can be initiated manually in each update domain or initiated automatically in all update domains.Possible Values are <br /><br />**Auto**<br /><br />**Manual** <br /><br />**Simultaneous**<br /><br />If not specified, the default value is Auto.
        # If set to Manual, PUT UpdateDomain must be called to apply the update.
        # If set to Auto, the update is automatically applied to each update domain in sequence.
        ${UpgradeMode},

        [Parameter(ParameterSetName='quickCreateParameterSetWithoutStorage', HelpMessage= "Name of Dns to be used for the CloudService resource.")]
        [Parameter(ParameterSetName='quickCreateParameterSetWithStorage', HelpMessage= "Name of Dns to be used for the CloudService resource.")]
        [System.String]
        # Name of Dns to be used for the CloudService resource
        ${DnsName},

        [Parameter(ParameterSetName='quickCreateParameterSetWithoutStorage', HelpMessage= "Name of the KeyVault to be used for the CloudService resource.")]
        [Parameter(ParameterSetName='quickCreateParameterSetWithStorage', HelpMessage= "Name of the KeyVault to be used for the CloudService resource.")]
        [System.String]
        # Name of the KeyVault to be used for the CloudService resource
        ${KeyVaultName}
    )

    process {
        Import-Module Az.Network
        Import-Module Az.KeyVault
        Import-Module Az.Storage

        # extract csdef/cscfg 

        try {
            $getCS = Get-azcloudservice -resourcegroupname $ResourceGroupName -name $name -ErrorAction Stop
        }
        catch {
            # CloudService does not exist in that name/resource group
        }
        finally {
            if ($null -ne $getCS){
                throw "A Cloud Service resource with name: '" +$name + "' already exists in Resource Group: '" + $ResourceGroupName + "'. Please try another name."
            }
        }

        if (-not (Test-Path $ConfigurationFile))  
        {
            throw "Cannot find file: " + $ConfigurationFile 
        }
        if (-not (Test-Path $DefinitionFile))
        {
            throw "Cannot find file: " + $DefinitionFile
        }
        if ($PSBoundParameters.ContainsKey("PackageFile")){
            if (-not (Test-Path $PackageFile))
            {
                throw "Cannot find file: " + $PackageFile
            }
            $extn = [IO.Path]::GetExtension($PackageFile)
            if ($extn -ne ".cspkg" )
            {
                throw "The Definition File must have the file extension '.cspkg'"
            }
        }

        [xml]$csdef = Get-Content -Path $DefinitionFile
        [xml]$cscfg = Get-Content -Path $ConfigurationFile
        $Configuration = Get-Content -Path $ConfigurationFile | Out-String

        # do validation 
        $passMemory = @{}
        validation $cscfg $csdef $PSBoundParameters ([ref]$passMemory)

        # create resources
        If ($passMemory.ipFound -eq $false){
            Write-Host("Creating ReservedIP")
            $null = New-AzPublicIpAddress -ResourceGroupName $ResourceGroupName -Name $passMemory.ipName -location $location -Sku Basic -AllocationMethod Static -WarningAction SilentlyContinue 
        }
        If ($passMemory.vNetFound -eq $False){
            # create subnets first 
            $subnetsList = @()
            $subnetCount = 0
            If ($True -eq $passMemory.CreateInternalLoadBalancer){
                $aSubnet = New-AzVirtualNetworkSubnetConfig -Name $cscfg.ServiceConfiguration.NetworkConfiguration.loadBalancers.Loadbalancer.FrontendIPConfiguration.subnet -AddressPrefix "10.0.0.0/24" -WarningAction SilentlyContinue 
                $subnetsList = $subnetsList + @($aSubnet)
                $subnetCount = $subnetCount + 1
                $passMemory.Add("theSubnet", $aSubnet)
            }

            foreach ($instaceAddress in $cscfg.ServiceConfiguration.NetworkConfiguration.AddressAssignments.InstanceAddress) {
                if ( ($subnetsList.count -eq 0) -or (-not ($subnetsList.name.tolower()).contains($instaceAddress.subnets.subnet.Name.tolower())) ){
                    $addressPrefix = "10.0." + $subnetCount + ".0/24"
                    $aSubnet = New-AzVirtualNetworkSubnetConfig -Name $instaceAddress.subnets.subnet.Name -AddressPrefix $addressPrefix -WarningAction SilentlyContinue 
                    $subnetsList = $subnetsList + @($aSubnet)
                    $subnetCount = $subnetCount + 1
                }
            }

            # vnet
            Write-Host("Creating Virtual Network")
            $null = New-AzVirtualNetwork -name $passMemory.vnetName -resourcegroupname $resourcegroupname -location $location -AddressPrefix 10.0.0.0/16 -Subnet $subnetsList 
        }

        # if -storageaccount is given, upload to packageUrl to blob 
        if ($PSBoundParameters.ContainsKey("StorageAccount")) 
        {
            Write-Host("Uploading the csdef to a blob in the Storage Account.")
            $storageAccountObjs = Get-AzStorageAccount
            foreach ($storageAccountObj in $storageAccountObjs) {
                if ($storageAccountObj.StorageAccountName.tolower() -eq $storageAccount.tolower()){
                    break
                }
            }
            $containerName = "cloudservicecontainer"
            # check if container exists
            try {
                $container = get-azstorageContainer -context $storageAccountObj.context -name $containerName -ErrorAction Stop
            }
            catch {
                # does not exist
                $container = New-AzStorageContainer -Name $containerName -Context $storageAccountObj.Context -Permission Blob
            }
            
            # Upload your Cloud Service package (cspkg) to the storage account.
            $tokenStartTime = Get-Date 
            $tokenEndTime = $tokenStartTime.AddYears(1) 
            $cspkgBlob = Set-AzStorageBlobContent -File $PackageFile -Container $container.name -Blob ($name + ".cspkg") -Context $storageAccountObj.Context 
            $cspkgToken = New-AzStorageBlobSASToken -Container $container.name -Blob $cspkgBlob.Name -Permission rwd -StartTime $tokenStartTime -ExpiryTime $tokenEndTime -Context $storageAccountObj.Context 
            $cspkgUrl = $cspkgBlob.ICloudBlob.Uri.AbsoluteUri + $cspkgToken 
            
            $null = $PSBoundParameters.Remove("StorageAccount")
            $null = $PSBoundParameters.Remove("PackageFile")
            $null = $PSBoundParameters.Add("packageURL", $cspkgURL)
        }

        # network profile
        if ( $null -eq $cscfg.ServiceConfiguration.NetworkConfiguration.AddressAssignments.ReservedIPs.ReservedIP ){
            # Create a public IP address and (optionally) set the DNS label property of the public IP address. If you are using a static IP, it needs to referenced as a Reserved IP in Service Configuration file.
            $publicIpName = $name + "Ip"
            if ($PSBoundParameters.ContainsKey("DnsName")) 
            {
                $publicIp = New-AzPublicIpAddress -Name $publicIPName -ResourceGroupName $ResourceGroupName -Location $Location -AllocationMethod Dynamic -IpAddressVersion IPv4 -DomainNameLabel $DnsName -Sku Basic -WarningAction SilentlyContinue 
                $null = $PSBoundParameters.Remove("DnsName")
            }
            else {
                $publicIp = New-AzPublicIpAddress -Name $publicIpName -ResourceGroupName $ResourceGroupName -Location $Location -AllocationMethod Dynamic -IpAddressVersion IPv4 -Sku Basic -WarningAction SilentlyContinue 
            } 
        }
        else {
            $publicIpName = $cscfg.ServiceConfiguration.NetworkConfiguration.AddressAssignments.ReservedIPs.ReservedIP.Name
        }
        
            # Create Network Profile Object and associate public IP address to the frontend of the platform created load balancer.
        $publicIP = Get-AzPublicIpAddress -ResourceGroupName $ResourceGroupName -Name $publicIpName  
        $feIpConfig = New-AzCloudServiceLoadBalancerFrontendIPConfigurationObject -Name ($name+'LbFe') -PublicIPAddressId $publicIP.Id 
        $loadBalancerConfig = New-AzCloudServiceLoadBalancerConfigurationObject -Name ($name + 'LB') -FrontendIPConfiguration $feIpConfig 
        $networkProfile = @{loadBalancerConfiguration = $loadBalancerConfig}
        
        If ( $null -ne $cscfg.ServiceConfiguration.NetworkConfiguration.loadBalancers.loadBalancer){
            $privateLB = $cscfg.ServiceConfiguration.NetworkConfiguration.loadBalancers.loadBalancer
            $feIpConfig2 = New-AzCloudServiceLoadBalancerFrontendIPConfigurationObject -Name ($privateLB.name + 'Fe') -privateIPAddress $privateLB.FrontendIPConfiguration.staticVirtualNetworkIPAddress -subnetId $passMemory.theSubnet.Id
            $loadBalancerConfig2 = New-AzCloudServiceLoadBalancerConfigurationObject -Name $privateLB.name -FrontendIPConfiguration $feIpConfig2
            $networkProfile = @{loadBalancerConfiguration = @($loadBalancerConfig, $loadBalancerConfig2)}
        }

        $null = $PSBoundParameters.Add("NetworkProfile", $networkProfile)

    
        # OS Profile
        if ($PSBoundParameters.ContainsKey("KeyVaultName")) {
            $keyVault = $passMemory.KeyVault 
            $certSecretList = $passMemory.certSecretList

            $secretGroup = New-AzCloudServiceVaultSecretGroupObject -Id $keyVault.ResourceId -CertificateUrl $certSecretList 
            $osProfile = @{secret = @($secretGroup)}

            $null = $PSBoundParameters.Remove("keyvaultname")
            $null = $PSBoundParameters.Add("OSProfile", $osProfile)
        }

        # Role Profile 
        $roleProfileList = @()

        foreach ($role in $cscfg.ServiceConfiguration.Role) {
            # find in csdef
            $RoleFoundinCsDef = $false
            foreach ($webRole in $csdef.ServiceDefinition.WebRole) {
                if ($role.name -eq $webRole.name){
                    $RoleFoundinCsDef = $true
                    $defRole = $webRole
                    break
                }
            }
            if (-not $RoleFoundinCsDef){
                foreach ($workerRole in $csdef.ServiceDefinition.WorkerRole) {
                    if($role.name -eq $workerRole.name){
                        $RoleFoundinCsDef = $true
                        $defRole = $workerRole
                        break
                    }
                }
            }

            $newRole = New-AzCloudServiceRoleProfilePropertiesObject -Name $defRole.Name -SkuName $defRole.vmsize -SkuTier 'Standard' -SkuCapacity $role.Instances.count 
            $roleProfileList = $roleProfileList + @($newRole)
        }

        $roleProfile = @{role = $roleProfileList} 
        $null = $PSBoundParameters.Add("roleProfile", $RoleProfile)

        
        $null = $PSBoundParameters.Remove("DefinitionFile")
        $null = $PSBoundParameters.Remove("ConfigurationFile")
        $null = $PSBoundParameters.Add("Configuration", $Configuration)

        

        # Perform action
        Write-Host("Creating the Cloud Service resource.")
        Az.CloudService\New-AzCloudService @PSBoundParameters
    }

}

function validation
{
    [Microsoft.Azure.PowerShell.Cmdlets.CloudService.DoNotExportAttribute()]
    param(
        [Parameter()]
        [object]
        ${cscfg},
        [Parameter()]
        [object]
        ${csdef},
        [Parameter()]
        [Hashtable]
        $params,
        [Parameter()]
        [Hashtable]
        [ref]$passMemory
    )

    Write-Host("Checking validations on the .cscfg and .csdef files.")

    # Network configuration missing in configuration
    If ( ($null -eq $cscfg.ServiceConfiguration.NetworkConfiguration) -or (($cscfg.ServiceConfiguration.NetworkConfiguration.VirtualNetworkSite | Measure-Object | Select-Object -expandproperty count) -eq 0) -or (($cscfg.ServiceConfiguration.NetworkConfiguration.AddressAssignments.InstanceAddress.Subnets | Measure-Object | Select-Object -ExpandProperty count) -eq 0) )
    {
        throw "The network configuration is missing from the configuration file. Please add the network configuration to the configuration file."
    }

    # CS definition and configuration match
    if (($cscfg.ServiceConfiguration.Role | Measure-Object | Select-Object -ExpandProperty count) -eq 1){
        $csCfgRoleNames = @($cscfg.ServiceConfiguration.Role.name.tolower())
    }elseif(($cscfg.ServiceConfiguration.Role | Measure-Object | Select-Object -ExpandProperty count) -gt 1){
        $csCfgRoleNames = $cscfg.ServiceConfiguration.Role.name.tolower()
    }

    $csDefRoleNames = @()
    if (($csdef.ServiceDefinition.WebRole | Measure-Object | select-object -expandproperty count) -eq 1){
        $csDefRoleNames = @($csdef.ServiceDefinition.WebRole.name.tolower())
    }elseif (($csdef.ServiceDefinition.WebRole | Measure-Object | select-object -expandproperty count) -gt 1) {
        $csDefRoleNames = $csdef.ServiceDefinition.WebRole.name.tolower()
    }
    if (($csdef.ServiceDefinition.WorkerRole | Measure-Object | select-object -expandproperty count) -eq 1){
        $csDefRoleNames = $csDefRoleNames + @($csdef.ServiceDefinition.WorkerRole.name.tolower())
    }elseif (($csdef.ServiceDefinition.WorkerRole | Measure-Object | select-object -expandproperty count) -gt 1) {
        $csDefRoleNames = $csDefRoleNames + $csdef.ServiceDefinition.WorkerRole.name.tolower()
    }

    foreach ($aRoleName in $csCfgRoleNames){
        if (-not $csDefRoleNames.contains($aRoleName)){
            throw "The CSCFG did not match the CSDEF. More details: No role named '" + $aRoleName + "' found in the service definition file. For more details please refer to : https://aka.ms/cses-cscfg-csdef"
        }
    }
    foreach ($aRoleName in $csDefRoleNames){
        if (-not $csCfgRoleNames.contains($aRoleName)){
            throw "The CSCFG did not match the CSDEF. More details: No role named '" + $aRoleName + "' found in the service configuration file. For more details please refer to : https://aka.ms/cses-cscfg-csdef"
        }
    }

    $certList = @()
    foreach ($role in $cscfg.ServiceConfiguration.Role){
        $defCerts = ($csdef.ServiceDefinition.childnodes | where-object {$_.name.tolower() -eq $role.name.tolower()}).Certificates.Certificate
        If ( 1 -eq $defCerts.count ){
            $defCerts = @($defCerts)
        }
        foreach ($cert in $role.Certificates.Certificate){
            if ( "Microsoft.WindowsAzure.Plugins.RemoteAccess.PasswordEncryption" -ne $cert.Name){
                # CS definition and configuration match
                if ( -not $defCerts.name.tolower().Contains($cert.Name.tolower())){
                    throw "The service definition file does not provide a certificate definition for certificate '" + $cert.name + "' for role '"+ $role.name +"'. For more details please refer to : https://aka.ms/cses-cscfg-csdef"
                }
                if ($certList.Count -eq 0 -or -not $certList.thumbprint.Contains($cert.thumbprint))
                {
                    $certList = $certList + $cert
                }
            }
        }
    }

    # Existing Virtual Network Location Mismatch
    # check if vnet exists
    $vnetNameSplitCount = ($cscfg.ServiceConfiguration.NetworkConfiguration.VirtualNetworkSite.name).split().count
    if (3 -eq $vnetNameSplitCount){
        
        $vnetNameFormat = ($cscfg.ServiceConfiguration.NetworkConfiguration.VirtualNetworkSite.name).split()
        if ("group" -ne $vnetNameFormat[0].tolower()){
            throw "VirtualNetworkSite name should be formated either ""{Name}"" or ""Group {ResourceGroupName} {Name}""."
        }
        
        $passMemory.Add("vnetName", $vnetNameFormat[2])

        # look for the vnet
        try {
            $thevnet = Get-AzVirtualNetwork -ResourceGroupName $vnetNameFormat[1] -Name $vnetNameFormat[2] -ErrorAction Stop
            if ($thevnet.location.replace(" ","").tolower() -eq $Location.replace(" ","").tolower()){
                $vnetFound = $true
            }else {
                $vnetLocationMatch = $false
            }
        }
        catch {
            $vnetFound = $false
        }

    } elseif (1 -eq $vnetNameSplitCount) {
        $passMemory.Add("vnetName", $cscfg.ServiceConfiguration.NetworkConfiguration.VirtualNetworkSite.name)
        try {
            $thevnet = Get-AzVirtualNetwork -name $cscfg.ServiceConfiguration.NetworkConfiguration.VirtualNetworkSite.name -ResourceGroupName $ResourceGroupName -ErrorAction Stop
            if ($thevnet.location.replace(" ","").tolower() -eq $Location.replace(" ","").tolower()){
                $vnetFound = $true
            }
            else {
                $vnetLocationMatch = $false
            }
        }
        catch {
            $vnetFound = $false
        }
    }else {
        throw "VirtualNetworkSite name should be formated either ""{Name}"" or ""Group {ResourceGroupName} {Name}""."
    }

    If($false -eq $vnetLocationMatch){
        throw "The location for the cloud service (" + $location + ") and virtual network ("+ $thevnet.location +") are different. The location of the cloud service needs to match the location of the virtual network. Change the location of the cloud service to match the virtual network or change the resource group of the cloud service to try to resolve this issue."
    }

    $passMemory.Add("vnetFound", $vnetFound)

    If ($vnetFound){
        If (1 -eq $theVNet.subnets.count){
            $vnetSubnets = @($theVnet.Subnets)
        }
        else {
            $vnetSubnets = $theVnet.subnets
        }
    
        # Existing Virtual Network Missing Subnets  
        foreach ($instaceAddress in $cscfg.ServiceConfiguration.NetworkConfiguration.AddressAssignments.InstanceAddress) {
            if (-not ($vnetSubnets.name.tolower()).contains($instaceAddress.subnets.subnet.Name.tolower())){
                throw "Subnet defined in the CSCFG file: '" + $instaceAddress.subnets.subnet.Name + "' could not be found in the Virtual Network: '" + $theVNet.name + "'. Please add the subnet to the virtual network."
            }
        }
    }


    # Internal load balancer private ip contained in subnet 
    If ( $null -ne $cscfg.ServiceConfiguration.NetworkConfiguration.loadBalancers.loadBalancer){
        $InternalLBFEConfig = $cscfg.ServiceConfiguration.NetworkConfiguration.loadBalancers.Loadbalancer.FrontendIPConfiguration 
        If ($vnetFound){
            $theSubnet = $thevnet.Subnets | where-object {$_.Name.tolower() -eq $InternalLBFEConfig.subnet.tolower()}
            If ($null -eq $theSubnet){
                throw "Subnet defined in the CSCFG file: '" + $InternalLBFEConfig.subnet + "' could not be found in the Virtual Network: '" + $theVNet.name + "'. Please add the subnet to the virtual network."
            }
            $passMemory.Add("theSubnet", $theSubnet)
            $addressPrefix = $theSubnet.AddressPrefix
        }
        else{
            $passMemory.Add("CreateInternalLoadBalancer", $true)
            $addressPrefix = "10.0.0.0/24" 
        }

        $maskNumber = $addressPrefix.split("/")[1]

        $subnetAddress = $addressPrefix.split("/")[0]
        $subnetBinary = -join ($subnetAddress -split '\.' | ForEach-Object {
            [System.Convert]::ToString($_,2).PadLeft(8,'0')
        })

        $LBIP = $InternalLBFEConfig.staticVirtualNetworkIPAddress
        $LBIPBinary = -join ($LBIP -split '\.' | ForEach-Object {
            [System.Convert]::ToString($_,2).PadLeft(8,'0')
        })

        If ($subnetBinary.substring(0,$maskNumber)  -ne $LBIPbinary.substring(0,$maskNumber)){
            If ($vnetFound){
                throw "The internal load balancer subnet '" + $InternalLBFEConfig.subnet + "' does not contain the private IP " + $LBIP + ". Update the subnet within the Virtual Network to include the Private IP."
            }else{
                throw "The default internal load balancer subnet which will be created: '"+ $addressPrefix +"' does not contain the private IP " + $LBIP + ". Either update private IP or provided an already created virtual network and subnet."
            }
        }
    }
    
    if ( $null -ne $cscfg.ServiceConfiguration.NetworkConfiguration.AddressAssignments.ReservedIPs.ReservedIP ){
        
        $IpNameSplitCount = ($cscfg.ServiceConfiguration.NetworkConfiguration.AddressAssignments.ReservedIPs.ReservedIP.Name).split().count
        if (3 -eq $IpNameSplitCount){
            
            $IpNameFormat = ($cscfg.ServiceConfiguration.NetworkConfiguration.AddressAssignments.ReservedIPs.ReservedIP.Name).split()
            if ("group" -ne $IpNameFormat[0].tolower()){
                throw "ReservedIP name should be formated either ""{Name}"" or ""Group {ResourceGroupName} {Name}""."
            }
            $passMemory.Add("ipName", $IpNameFormat[2])

            # look for the Ip
            try {
                $theIpObj = Get-AzPublicIpAddress -ResourceGroupName $IpNameFormat[1] -Name $IpNameFormat[2] -ErrorAction Stop
                if ($theIpObj.location.replace(" ","").tolower() -eq $Location.replace(" ","").tolower()){
                    $ipFound = $true
                }else {
                    $ipLocationMatch = $false
                }
            }
            catch {
                $ipFound = $false
            }

        }elseif (1 -eq $IpNameSplitCount) {
            $passMemory.Add("ipName", $cscfg.ServiceConfiguration.NetworkConfiguration.AddressAssignments.ReservedIPs.ReservedIP.Name)
            try {
                $theIpObj = Get-AzPublicIpAddress -name $cscfg.ServiceConfiguration.NetworkConfiguration.AddressAssignments.ReservedIPs.ReservedIP.Name -ResourceGroupName $ResourceGroupName -ErrorAction Stop
                # Existing Reserved (Static) IP Location Mismatch
                if ($theIpObj.Location.replace(" ","").tolower() -eq $location.replace(" ","").tolower()) {
                    $ipFound = $true
                } else {
                    $ipLocationMatch = $false
                }
            }
            catch {
                $ipFound = $false
            }
        } else {
            throw "ReservedIP name should be formated either ""{Name}"" or ""Group {ResourceGroupName} {Name}""."
        }

        If ($false -eq $IpLocationMatch){
            throw "The location for the Cloud Service (" + $location + ") and the Public IP Address (" + $theIPObj.location + ") are different. The location of the Cloud Service needs to match the location of the Public IP Address. Change the location of the Cloud Service to match the Public IP Address or change the resource group of the Cloud Service to try to resolve the issue."
        }
        
        $passMemory.Add("ipFound", $ipFound)

        If ($ipFound){
            
            # Existing Reserved (Static) IP In Use
            if ($null -ne $theIPObj.IPConfiguration){
                throw "The Public IP provided in the CSCFG: '" + $theIPObj.name + "' is currently in use by another resource."
            }

            # Existing Reserved (Static) IP Incorrect Sku
            if ("Basic" -ne $theIPObj.Sku.Name){
                throw "The Public IP provided in the CSCFG: '" + $theIPObj.name + "' must have a 'Basic' SKU."
            }

            # Existing Reserved (Static) IP Address Incorrect Version
            if ("IPv4" -ne $theIPObj.PublicIPAddressVersion){
                throw "The Public IP provided in the CSCFG: '" + $theIPObj.name + "' uses IPv6 and an IPv4 public IP address is needed."
            }

            # Existing Reserved (Static) IP Incorrect Allocation
            if ("Static" -ne $theIPObj.PublicIPAllocationMethod){
                throw "The Public IP provided in the CSCFG: '" + $theIPObj.name + "' uses a dynamic allocation and a static allocation is needed."
            }
        }
    }

    if ($params.ContainsKey("KeyVaultName")) {
        # Keyvault in same location 
        $keyVaultsWithName = Get-AzKeyVault -vaultName $keyvaultname 
        $keyvaultFound = $false
        foreach ($kv in $keyVaultsWithName) {
            if ($kv.location.replace(" ","").tolower() -eq $location.replace(" ","").tolower()) {
                $keyvaultFound = $true
                $theKV = Get-AzKeyVault -vaultName $keyvaultname -resourceGroupName $kv.resourcegroupname
                $passMemory.Add("KeyVault", $theKV)
            }
        }
        If (-not $keyvaultFound){
            throw "No KeyVault named '" + $keyvaultname + "' was found in " + $Location
        }

        # Keyvault has virtual machine deployment permission and user has list and get permissions
        If (-not $theKV.EnabledForDeployment){
            throw "The Key vault is not enabled for deployment. The Key Vault must have 'Azure Virtual Machines for deployment' access enabled. Please run the following cmdlets to enable access: Set-AzKeyVaultAccessPolicy -VaultName " + $keyvaultname + " -ResourceGroupName " +$resourcegroupname +" -EnabledForDeployment"
        }

        try {
            $certsInKV = Get-AzKeyVaultCertificate -VaultName $keyvaultname -ErrorAction Stop
        }
        catch [Microsoft.Azure.KeyVault.Models.KeyVaultErrorException]{
            $KVnoPolicy = $true
        }
        finally {
            If ($KVnoPolicy){
              throw "The certificates must have 'Get' and 'List' permissions enabled on the Key Vault. Please run the following cmdlets to enable access: Set-AzKeyVaultAccessPolicy -VaultName " + $keyvaultname +" -ResourceGroupName " + $theKV.resourcegroupname + " -UserPrincipalName 'user@domain.com' -PermissionsToCertificates create,get,list,delete "  
            }
        }

        # All certificates are found in the keyvault
        $certsObjsFromKeyvault = @()
        $certSecretList = @()
        foreach ($cert in $CertsInKV) {
            $certsObjsFromKeyvault = $certsObjsFromKeyvault + (Get-AzKeyVaultCertificate -VaultName $keyvaultname -name $cert.name)
        }
        foreach ($certFromFiles in $certList){
            $thumbprintFound = $false
            foreach ($certFromKV in $certsObjsFromKeyvault){
                if ($certFromFiles.thumbprint -eq $certFromKV.thumbprint){
                    $thumbprintFound = $true
                    $certSecretList = $certSecretList + $certFromKV.SecretId
                }
            }
            if (-not $thumbprintFound){
                throw "The thumbprints specified in the CSCFG could not be found in the Key Vault. Add the missing certificates in Key Vault: '" + $keyvaultName + "'. Missing thumbprint: '" + $certFromFiles.name + " " + $certFromFiles.thumbprint +"'. To understand more about how to use KeyVault for certificates, please follow the documentation at https://aka.ms/cses-kv"
            }
        }
        $passMemory.Add("certSecretList", $certSecretList)
    }

    if ($params.ContainsKey("StorageAccount")) {
        $storAccs = Get-AzStorageAccount
        if (-not ($storAccs.StorageAccountName.tolower()).contains($storageAccount.tolower())){
            throw "The provided Storage Account: '" + $storageAccount + "' does not exist."
        }
    }
}

# SIG # Begin signature block
# MIInzgYJKoZIhvcNAQcCoIInvzCCJ7sCAQExDzANBglghkgBZQMEAgEFADB5Bgor
# BgEEAYI3AgEEoGswaTA0BgorBgEEAYI3AgEeMCYCAwEAAAQQH8w7YFlLCE63JNLG
# KX7zUQIBAAIBAAIBAAIBAAIBADAxMA0GCWCGSAFlAwQCAQUABCAfPirPvtMF5zi8
# 5oJELwraCEdDm6A2vbFGZgFId1GN06CCDYUwggYDMIID66ADAgECAhMzAAACzfNk
# v/jUTF1RAAAAAALNMA0GCSqGSIb3DQEBCwUAMH4xCzAJBgNVBAYTAlVTMRMwEQYD
# VQQIEwpXYXNoaW5ndG9uMRAwDgYDVQQHEwdSZWRtb25kMR4wHAYDVQQKExVNaWNy
# b3NvZnQgQ29ycG9yYXRpb24xKDAmBgNVBAMTH01pY3Jvc29mdCBDb2RlIFNpZ25p
# bmcgUENBIDIwMTEwHhcNMjIwNTEyMjA0NjAyWhcNMjMwNTExMjA0NjAyWjB0MQsw
# CQYDVQQGEwJVUzETMBEGA1UECBMKV2FzaGluZ3RvbjEQMA4GA1UEBxMHUmVkbW9u
# ZDEeMBwGA1UEChMVTWljcm9zb2Z0IENvcnBvcmF0aW9uMR4wHAYDVQQDExVNaWNy
# b3NvZnQgQ29ycG9yYXRpb24wggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIB
# AQDrIzsY62MmKrzergm7Ucnu+DuSHdgzRZVCIGi9CalFrhwtiK+3FIDzlOYbs/zz
# HwuLC3hir55wVgHoaC4liQwQ60wVyR17EZPa4BQ28C5ARlxqftdp3H8RrXWbVyvQ
# aUnBQVZM73XDyGV1oUPZGHGWtgdqtBUd60VjnFPICSf8pnFiit6hvSxH5IVWI0iO
# nfqdXYoPWUtVUMmVqW1yBX0NtbQlSHIU6hlPvo9/uqKvkjFUFA2LbC9AWQbJmH+1
# uM0l4nDSKfCqccvdI5l3zjEk9yUSUmh1IQhDFn+5SL2JmnCF0jZEZ4f5HE7ykDP+
# oiA3Q+fhKCseg+0aEHi+DRPZAgMBAAGjggGCMIIBfjAfBgNVHSUEGDAWBgorBgEE
# AYI3TAgBBggrBgEFBQcDAzAdBgNVHQ4EFgQU0WymH4CP7s1+yQktEwbcLQuR9Zww
# VAYDVR0RBE0wS6RJMEcxLTArBgNVBAsTJE1pY3Jvc29mdCBJcmVsYW5kIE9wZXJh
# dGlvbnMgTGltaXRlZDEWMBQGA1UEBRMNMjMwMDEyKzQ3MDUzMDAfBgNVHSMEGDAW
# gBRIbmTlUAXTgqoXNzcitW2oynUClTBUBgNVHR8ETTBLMEmgR6BFhkNodHRwOi8v
# d3d3Lm1pY3Jvc29mdC5jb20vcGtpb3BzL2NybC9NaWNDb2RTaWdQQ0EyMDExXzIw
# MTEtMDctMDguY3JsMGEGCCsGAQUFBwEBBFUwUzBRBggrBgEFBQcwAoZFaHR0cDov
# L3d3dy5taWNyb3NvZnQuY29tL3BraW9wcy9jZXJ0cy9NaWNDb2RTaWdQQ0EyMDEx
# XzIwMTEtMDctMDguY3J0MAwGA1UdEwEB/wQCMAAwDQYJKoZIhvcNAQELBQADggIB
# AE7LSuuNObCBWYuttxJAgilXJ92GpyV/fTiyXHZ/9LbzXs/MfKnPwRydlmA2ak0r
# GWLDFh89zAWHFI8t9JLwpd/VRoVE3+WyzTIskdbBnHbf1yjo/+0tpHlnroFJdcDS
# MIsH+T7z3ClY+6WnjSTetpg1Y/pLOLXZpZjYeXQiFwo9G5lzUcSd8YVQNPQAGICl
# 2JRSaCNlzAdIFCF5PNKoXbJtEqDcPZ8oDrM9KdO7TqUE5VqeBe6DggY1sZYnQD+/
# LWlz5D0wCriNgGQ/TWWexMwwnEqlIwfkIcNFxo0QND/6Ya9DTAUykk2SKGSPt0kL
# tHxNEn2GJvcNtfohVY/b0tuyF05eXE3cdtYZbeGoU1xQixPZAlTdtLmeFNly82uB
# VbybAZ4Ut18F//UrugVQ9UUdK1uYmc+2SdRQQCccKwXGOuYgZ1ULW2u5PyfWxzo4
# BR++53OB/tZXQpz4OkgBZeqs9YaYLFfKRlQHVtmQghFHzB5v/WFonxDVlvPxy2go
# a0u9Z+ZlIpvooZRvm6OtXxdAjMBcWBAsnBRr/Oj5s356EDdf2l/sLwLFYE61t+ME
# iNYdy0pXL6gN3DxTVf2qjJxXFkFfjjTisndudHsguEMk8mEtnvwo9fOSKT6oRHhM
# 9sZ4HTg/TTMjUljmN3mBYWAWI5ExdC1inuog0xrKmOWVMIIHejCCBWKgAwIBAgIK
# YQ6Q0gAAAAAAAzANBgkqhkiG9w0BAQsFADCBiDELMAkGA1UEBhMCVVMxEzARBgNV
# BAgTCldhc2hpbmd0b24xEDAOBgNVBAcTB1JlZG1vbmQxHjAcBgNVBAoTFU1pY3Jv
# c29mdCBDb3Jwb3JhdGlvbjEyMDAGA1UEAxMpTWljcm9zb2Z0IFJvb3QgQ2VydGlm
# aWNhdGUgQXV0aG9yaXR5IDIwMTEwHhcNMTEwNzA4MjA1OTA5WhcNMjYwNzA4MjEw
# OTA5WjB+MQswCQYDVQQGEwJVUzETMBEGA1UECBMKV2FzaGluZ3RvbjEQMA4GA1UE
# BxMHUmVkbW9uZDEeMBwGA1UEChMVTWljcm9zb2Z0IENvcnBvcmF0aW9uMSgwJgYD
# VQQDEx9NaWNyb3NvZnQgQ29kZSBTaWduaW5nIFBDQSAyMDExMIICIjANBgkqhkiG
# 9w0BAQEFAAOCAg8AMIICCgKCAgEAq/D6chAcLq3YbqqCEE00uvK2WCGfQhsqa+la
# UKq4BjgaBEm6f8MMHt03a8YS2AvwOMKZBrDIOdUBFDFC04kNeWSHfpRgJGyvnkmc
# 6Whe0t+bU7IKLMOv2akrrnoJr9eWWcpgGgXpZnboMlImEi/nqwhQz7NEt13YxC4D
# dato88tt8zpcoRb0RrrgOGSsbmQ1eKagYw8t00CT+OPeBw3VXHmlSSnnDb6gE3e+
# lD3v++MrWhAfTVYoonpy4BI6t0le2O3tQ5GD2Xuye4Yb2T6xjF3oiU+EGvKhL1nk
# kDstrjNYxbc+/jLTswM9sbKvkjh+0p2ALPVOVpEhNSXDOW5kf1O6nA+tGSOEy/S6
# A4aN91/w0FK/jJSHvMAhdCVfGCi2zCcoOCWYOUo2z3yxkq4cI6epZuxhH2rhKEmd
# X4jiJV3TIUs+UsS1Vz8kA/DRelsv1SPjcF0PUUZ3s/gA4bysAoJf28AVs70b1FVL
# 5zmhD+kjSbwYuER8ReTBw3J64HLnJN+/RpnF78IcV9uDjexNSTCnq47f7Fufr/zd
# sGbiwZeBe+3W7UvnSSmnEyimp31ngOaKYnhfsi+E11ecXL93KCjx7W3DKI8sj0A3
# T8HhhUSJxAlMxdSlQy90lfdu+HggWCwTXWCVmj5PM4TasIgX3p5O9JawvEagbJjS
# 4NaIjAsCAwEAAaOCAe0wggHpMBAGCSsGAQQBgjcVAQQDAgEAMB0GA1UdDgQWBBRI
# bmTlUAXTgqoXNzcitW2oynUClTAZBgkrBgEEAYI3FAIEDB4KAFMAdQBiAEMAQTAL
# BgNVHQ8EBAMCAYYwDwYDVR0TAQH/BAUwAwEB/zAfBgNVHSMEGDAWgBRyLToCMZBD
# uRQFTuHqp8cx0SOJNDBaBgNVHR8EUzBRME+gTaBLhklodHRwOi8vY3JsLm1pY3Jv
# c29mdC5jb20vcGtpL2NybC9wcm9kdWN0cy9NaWNSb29DZXJBdXQyMDExXzIwMTFf
# MDNfMjIuY3JsMF4GCCsGAQUFBwEBBFIwUDBOBggrBgEFBQcwAoZCaHR0cDovL3d3
# dy5taWNyb3NvZnQuY29tL3BraS9jZXJ0cy9NaWNSb29DZXJBdXQyMDExXzIwMTFf
# MDNfMjIuY3J0MIGfBgNVHSAEgZcwgZQwgZEGCSsGAQQBgjcuAzCBgzA/BggrBgEF
# BQcCARYzaHR0cDovL3d3dy5taWNyb3NvZnQuY29tL3BraW9wcy9kb2NzL3ByaW1h
# cnljcHMuaHRtMEAGCCsGAQUFBwICMDQeMiAdAEwAZQBnAGEAbABfAHAAbwBsAGkA
# YwB5AF8AcwB0AGEAdABlAG0AZQBuAHQALiAdMA0GCSqGSIb3DQEBCwUAA4ICAQBn
# 8oalmOBUeRou09h0ZyKbC5YR4WOSmUKWfdJ5DJDBZV8uLD74w3LRbYP+vj/oCso7
# v0epo/Np22O/IjWll11lhJB9i0ZQVdgMknzSGksc8zxCi1LQsP1r4z4HLimb5j0b
# pdS1HXeUOeLpZMlEPXh6I/MTfaaQdION9MsmAkYqwooQu6SpBQyb7Wj6aC6VoCo/
# KmtYSWMfCWluWpiW5IP0wI/zRive/DvQvTXvbiWu5a8n7dDd8w6vmSiXmE0OPQvy
# CInWH8MyGOLwxS3OW560STkKxgrCxq2u5bLZ2xWIUUVYODJxJxp/sfQn+N4sOiBp
# mLJZiWhub6e3dMNABQamASooPoI/E01mC8CzTfXhj38cbxV9Rad25UAqZaPDXVJi
# hsMdYzaXht/a8/jyFqGaJ+HNpZfQ7l1jQeNbB5yHPgZ3BtEGsXUfFL5hYbXw3MYb
# BL7fQccOKO7eZS/sl/ahXJbYANahRr1Z85elCUtIEJmAH9AAKcWxm6U/RXceNcbS
# oqKfenoi+kiVH6v7RyOA9Z74v2u3S5fi63V4GuzqN5l5GEv/1rMjaHXmr/r8i+sL
# gOppO6/8MO0ETI7f33VtY5E90Z1WTk+/gFcioXgRMiF670EKsT/7qMykXcGhiJtX
# cVZOSEXAQsmbdlsKgEhr/Xmfwb1tbWrJUnMTDXpQzTGCGZ8wghmbAgEBMIGVMH4x
# CzAJBgNVBAYTAlVTMRMwEQYDVQQIEwpXYXNoaW5ndG9uMRAwDgYDVQQHEwdSZWRt
# b25kMR4wHAYDVQQKExVNaWNyb3NvZnQgQ29ycG9yYXRpb24xKDAmBgNVBAMTH01p
# Y3Jvc29mdCBDb2RlIFNpZ25pbmcgUENBIDIwMTECEzMAAALN82S/+NRMXVEAAAAA
# As0wDQYJYIZIAWUDBAIBBQCgga4wGQYJKoZIhvcNAQkDMQwGCisGAQQBgjcCAQQw
# HAYKKwYBBAGCNwIBCzEOMAwGCisGAQQBgjcCARUwLwYJKoZIhvcNAQkEMSIEIMJn
# eZTTighYEmPdc/AdBjpSdJMkMwxmf+sb4CD4s09XMEIGCisGAQQBgjcCAQwxNDAy
# oBSAEgBNAGkAYwByAG8AcwBvAGYAdKEagBhodHRwOi8vd3d3Lm1pY3Jvc29mdC5j
# b20wDQYJKoZIhvcNAQEBBQAEggEAyqtkfR3OtBqZep25ifQ+pq6nobrgRLdOgoCJ
# jYp/pGPkh19L9gFDHYA/gqFcjVAAwbcwgG1TXDpGrevadnqP163pZalW31uBXY06
# ahPH4xXaNfLecKmaIGbrQ5c9HRlHe+vrCMmZX4Zo1Wn8HRtyMFrLe2wxmYc5NPJD
# Nyp47WPFmO7qiURDnnixZn7Jfg8awCVBgivJGIQ6B2oTYg7rWT3bC5zXa1S7OCdP
# dTy0jFTGFmsE4KC+KhVsv9kYn+1e81vBHgcuAut4Ykv5m/tOnkMGlqOi438GRYA/
# FrndhurjIWVbm6+zAdTYd2C9Xr4eIZf/M71Om8RUAdQGZAsH36GCFykwghclBgor
# BgEEAYI3AwMBMYIXFTCCFxEGCSqGSIb3DQEHAqCCFwIwghb+AgEDMQ8wDQYJYIZI
# AWUDBAIBBQAwggFZBgsqhkiG9w0BCRABBKCCAUgEggFEMIIBQAIBAQYKKwYBBAGE
# WQoDATAxMA0GCWCGSAFlAwQCAQUABCBQzAsKyFAtOC2XKbXgDkYnoRTGXoxqTrrX
# Sezxfh3HcQIGY/dYye9oGBMyMDIzMDMwNjA2NTMwMi43MDlaMASAAgH0oIHYpIHV
# MIHSMQswCQYDVQQGEwJVUzETMBEGA1UECBMKV2FzaGluZ3RvbjEQMA4GA1UEBxMH
# UmVkbW9uZDEeMBwGA1UEChMVTWljcm9zb2Z0IENvcnBvcmF0aW9uMS0wKwYDVQQL
# EyRNaWNyb3NvZnQgSXJlbGFuZCBPcGVyYXRpb25zIExpbWl0ZWQxJjAkBgNVBAsT
# HVRoYWxlcyBUU1MgRVNOOkQwODItNEJGRC1FRUJBMSUwIwYDVQQDExxNaWNyb3Nv
# ZnQgVGltZS1TdGFtcCBTZXJ2aWNloIIReDCCBycwggUPoAMCAQICEzMAAAG6Hz8Z
# 98F1vXwAAQAAAbowDQYJKoZIhvcNAQELBQAwfDELMAkGA1UEBhMCVVMxEzARBgNV
# BAgTCldhc2hpbmd0b24xEDAOBgNVBAcTB1JlZG1vbmQxHjAcBgNVBAoTFU1pY3Jv
# c29mdCBDb3Jwb3JhdGlvbjEmMCQGA1UEAxMdTWljcm9zb2Z0IFRpbWUtU3RhbXAg
# UENBIDIwMTAwHhcNMjIwOTIwMjAyMjE5WhcNMjMxMjE0MjAyMjE5WjCB0jELMAkG
# A1UEBhMCVVMxEzARBgNVBAgTCldhc2hpbmd0b24xEDAOBgNVBAcTB1JlZG1vbmQx
# HjAcBgNVBAoTFU1pY3Jvc29mdCBDb3Jwb3JhdGlvbjEtMCsGA1UECxMkTWljcm9z
# b2Z0IElyZWxhbmQgT3BlcmF0aW9ucyBMaW1pdGVkMSYwJAYDVQQLEx1UaGFsZXMg
# VFNTIEVTTjpEMDgyLTRCRkQtRUVCQTElMCMGA1UEAxMcTWljcm9zb2Z0IFRpbWUt
# U3RhbXAgU2VydmljZTCCAiIwDQYJKoZIhvcNAQEBBQADggIPADCCAgoCggIBAIhO
# FYMzkjWAE9UVnXF9hRGv0xBRxc+I5Hu3hxVFXyK3u38xusEb0pLkwjgGtDsaLLbr
# lMxqX3tFb/3BgEPEC3L0wX76gD8zHt+wiBV5mq5BWop29qRrgMJKKCPcpQnSjs9B
# /4XMFFvrpdPicZDv43FLgz9fHqMq0LJDw5JAHGDS30TCY9OF43P4d44Z9lE7CaVS
# 2pJMF3L453MXB5yYK/KDbilhERP1jxn2yl+tGCRguIAsMG0oeOhXaw8uSGOhS6AC
# SHb+ebi0038MFHyoTNhKf+SYo4OpSY3xP4+swBBTKDoYP1wH+CfxG6h9fymBJQPQ
# Zaqfl0riiDLjmDunQtH1GD64Air5k9Jdwhq5wLmSWXjyFVL+IDfOpdixJ6f5o+Mh
# E6H4t31w+prygHmd2UHQ657UGx6FNuzwC+SpAHmV76MZYac4uAhTgaP47P2eeS1o
# ckvyhl9ya+9JzPfMkug3xevzFADWiLRMr066EMV7q3JSRAsnCS9GQ08C4FKPbSh8
# OPM33Lng0ffxANnHAAX/DE7cHcx7l9jaV3Acmkj7oqir4Eh2u5YxwiaTE37XaMum
# X2ES3PJ5NBaXq7YdLJwySD+U9pk/tl4dQ1t/Eeo7uDTliOyQkD8I74xpVB0T31/6
# 7KHfkBkFVvy6wye21V+9IC8uSD++RgD3RwtN2kE/AgMBAAGjggFJMIIBRTAdBgNV
# HQ4EFgQUimLm8QMeJa25j9MWeabI2HSvZOUwHwYDVR0jBBgwFoAUn6cVXQBeYl2D
# 9OXSZacbUzUZ6XIwXwYDVR0fBFgwVjBUoFKgUIZOaHR0cDovL3d3dy5taWNyb3Nv
# ZnQuY29tL3BraW9wcy9jcmwvTWljcm9zb2Z0JTIwVGltZS1TdGFtcCUyMFBDQSUy
# MDIwMTAoMSkuY3JsMGwGCCsGAQUFBwEBBGAwXjBcBggrBgEFBQcwAoZQaHR0cDov
# L3d3dy5taWNyb3NvZnQuY29tL3BraW9wcy9jZXJ0cy9NaWNyb3NvZnQlMjBUaW1l
# LVN0YW1wJTIwUENBJTIwMjAxMCgxKS5jcnQwDAYDVR0TAQH/BAIwADAWBgNVHSUB
# Af8EDDAKBggrBgEFBQcDCDAOBgNVHQ8BAf8EBAMCB4AwDQYJKoZIhvcNAQELBQAD
# ggIBAF/I8U6hbZhvDcn96nZ6tkbSEjXPvKZ6wroaXcgstEhpgaeEwleLuPXHLzEW
# tuJuYz4eshmhXqFr49lbAcX5SN5/cEsP0xdFayb7U5P94JZd3HjFvpWRNoNBhF3S
# DM0A38sI2H+hjhB/VfX1XcZiei1ROPAyCHcBgHLyQrEu6mnb3HhbIdr8h0Ta7WFy
# lGhLSFW6wmzKusP6aOlmnGSac5NMfla6lRvTYHd28rbbCgfSm1RhTgoZj+W8DTKt
# iEMwubHJ3mIPKmo8xtJIWXPnXq6XKgldrL5cynLMX/0WX65OuWbHV5GTELdfWvGV
# 3DaZrHPUQ/UP31Keqb2xjVCb30LVwgbjIvYS77N1dARkN8F/9pJ1gO4IvZWMwyMl
# KKFGojO1f1wbjSWcA/57tsc+t2blrMWgSNHgzDr01jbPSupRjy3Ht9ZZs4xN02ei
# X3eG297NrtC6l4c/gzn20eqoqWx/uHWxmTgB0F5osBuTHOe77DyEA0uhArGlgKP9
# 1jghgt/OVHoH65g0QqCtgZ+36mnCEg6IOhFoFrCc0fJFGVmb1+17gEe+HRMM7jBk
# 4O06J+IooFrI3e3PJjPrQano/MyE3h+zAuBWGMDRcUlNKCDU7dGnWvH3XWwLrCCI
# cz+3GwRUMsLsDdPW2OVv7v1eEJiMSIZ2P+M7L20Q8aznU4OAMIIHcTCCBVmgAwIB
# AgITMwAAABXF52ueAptJmQAAAAAAFTANBgkqhkiG9w0BAQsFADCBiDELMAkGA1UE
# BhMCVVMxEzARBgNVBAgTCldhc2hpbmd0b24xEDAOBgNVBAcTB1JlZG1vbmQxHjAc
# BgNVBAoTFU1pY3Jvc29mdCBDb3Jwb3JhdGlvbjEyMDAGA1UEAxMpTWljcm9zb2Z0
# IFJvb3QgQ2VydGlmaWNhdGUgQXV0aG9yaXR5IDIwMTAwHhcNMjEwOTMwMTgyMjI1
# WhcNMzAwOTMwMTgzMjI1WjB8MQswCQYDVQQGEwJVUzETMBEGA1UECBMKV2FzaGlu
# Z3RvbjEQMA4GA1UEBxMHUmVkbW9uZDEeMBwGA1UEChMVTWljcm9zb2Z0IENvcnBv
# cmF0aW9uMSYwJAYDVQQDEx1NaWNyb3NvZnQgVGltZS1TdGFtcCBQQ0EgMjAxMDCC
# AiIwDQYJKoZIhvcNAQEBBQADggIPADCCAgoCggIBAOThpkzntHIhC3miy9ckeb0O
# 1YLT/e6cBwfSqWxOdcjKNVf2AX9sSuDivbk+F2Az/1xPx2b3lVNxWuJ+Slr+uDZn
# hUYjDLWNE893MsAQGOhgfWpSg0S3po5GawcU88V29YZQ3MFEyHFcUTE3oAo4bo3t
# 1w/YJlN8OWECesSq/XJprx2rrPY2vjUmZNqYO7oaezOtgFt+jBAcnVL+tuhiJdxq
# D89d9P6OU8/W7IVWTe/dvI2k45GPsjksUZzpcGkNyjYtcI4xyDUoveO0hyTD4MmP
# frVUj9z6BVWYbWg7mka97aSueik3rMvrg0XnRm7KMtXAhjBcTyziYrLNueKNiOSW
# rAFKu75xqRdbZ2De+JKRHh09/SDPc31BmkZ1zcRfNN0Sidb9pSB9fvzZnkXftnIv
# 231fgLrbqn427DZM9ituqBJR6L8FA6PRc6ZNN3SUHDSCD/AQ8rdHGO2n6Jl8P0zb
# r17C89XYcz1DTsEzOUyOArxCaC4Q6oRRRuLRvWoYWmEBc8pnol7XKHYC4jMYcten
# IPDC+hIK12NvDMk2ZItboKaDIV1fMHSRlJTYuVD5C4lh8zYGNRiER9vcG9H9stQc
# xWv2XFJRXRLbJbqvUAV6bMURHXLvjflSxIUXk8A8FdsaN8cIFRg/eKtFtvUeh17a
# j54WcmnGrnu3tz5q4i6tAgMBAAGjggHdMIIB2TASBgkrBgEEAYI3FQEEBQIDAQAB
# MCMGCSsGAQQBgjcVAgQWBBQqp1L+ZMSavoKRPEY1Kc8Q/y8E7jAdBgNVHQ4EFgQU
# n6cVXQBeYl2D9OXSZacbUzUZ6XIwXAYDVR0gBFUwUzBRBgwrBgEEAYI3TIN9AQEw
# QTA/BggrBgEFBQcCARYzaHR0cDovL3d3dy5taWNyb3NvZnQuY29tL3BraW9wcy9E
# b2NzL1JlcG9zaXRvcnkuaHRtMBMGA1UdJQQMMAoGCCsGAQUFBwMIMBkGCSsGAQQB
# gjcUAgQMHgoAUwB1AGIAQwBBMAsGA1UdDwQEAwIBhjAPBgNVHRMBAf8EBTADAQH/
# MB8GA1UdIwQYMBaAFNX2VsuP6KJcYmjRPZSQW9fOmhjEMFYGA1UdHwRPME0wS6BJ
# oEeGRWh0dHA6Ly9jcmwubWljcm9zb2Z0LmNvbS9wa2kvY3JsL3Byb2R1Y3RzL01p
# Y1Jvb0NlckF1dF8yMDEwLTA2LTIzLmNybDBaBggrBgEFBQcBAQROMEwwSgYIKwYB
# BQUHMAKGPmh0dHA6Ly93d3cubWljcm9zb2Z0LmNvbS9wa2kvY2VydHMvTWljUm9v
# Q2VyQXV0XzIwMTAtMDYtMjMuY3J0MA0GCSqGSIb3DQEBCwUAA4ICAQCdVX38Kq3h
# LB9nATEkW+Geckv8qW/qXBS2Pk5HZHixBpOXPTEztTnXwnE2P9pkbHzQdTltuw8x
# 5MKP+2zRoZQYIu7pZmc6U03dmLq2HnjYNi6cqYJWAAOwBb6J6Gngugnue99qb74p
# y27YP0h1AdkY3m2CDPVtI1TkeFN1JFe53Z/zjj3G82jfZfakVqr3lbYoVSfQJL1A
# oL8ZthISEV09J+BAljis9/kpicO8F7BUhUKz/AyeixmJ5/ALaoHCgRlCGVJ1ijbC
# HcNhcy4sa3tuPywJeBTpkbKpW99Jo3QMvOyRgNI95ko+ZjtPu4b6MhrZlvSP9pEB
# 9s7GdP32THJvEKt1MMU0sHrYUP4KWN1APMdUbZ1jdEgssU5HLcEUBHG/ZPkkvnNt
# yo4JvbMBV0lUZNlz138eW0QBjloZkWsNn6Qo3GcZKCS6OEuabvshVGtqRRFHqfG3
# rsjoiV5PndLQTHa1V1QJsWkBRH58oWFsc/4Ku+xBZj1p/cvBQUl+fpO+y/g75LcV
# v7TOPqUxUYS8vwLBgqJ7Fx0ViY1w/ue10CgaiQuPNtq6TPmb/wrpNPgkNWcr4A24
# 5oyZ1uEi6vAnQj0llOZ0dFtq0Z4+7X6gMTN9vMvpe784cETRkPHIqzqKOghif9lw
# Y1NNje6CbaUFEMFxBmoQtB1VM1izoXBm8qGCAtQwggI9AgEBMIIBAKGB2KSB1TCB
# 0jELMAkGA1UEBhMCVVMxEzARBgNVBAgTCldhc2hpbmd0b24xEDAOBgNVBAcTB1Jl
# ZG1vbmQxHjAcBgNVBAoTFU1pY3Jvc29mdCBDb3Jwb3JhdGlvbjEtMCsGA1UECxMk
# TWljcm9zb2Z0IElyZWxhbmQgT3BlcmF0aW9ucyBMaW1pdGVkMSYwJAYDVQQLEx1U
# aGFsZXMgVFNTIEVTTjpEMDgyLTRCRkQtRUVCQTElMCMGA1UEAxMcTWljcm9zb2Z0
# IFRpbWUtU3RhbXAgU2VydmljZaIjCgEBMAcGBSsOAwIaAxUAdqNHe113gCJ87aZI
# Ga5QBUqIwvKggYMwgYCkfjB8MQswCQYDVQQGEwJVUzETMBEGA1UECBMKV2FzaGlu
# Z3RvbjEQMA4GA1UEBxMHUmVkbW9uZDEeMBwGA1UEChMVTWljcm9zb2Z0IENvcnBv
# cmF0aW9uMSYwJAYDVQQDEx1NaWNyb3NvZnQgVGltZS1TdGFtcCBQQ0EgMjAxMDAN
# BgkqhkiG9w0BAQUFAAIFAOevrqIwIhgPMjAyMzAzMDYwODEzMjJaGA8yMDIzMDMw
# NzA4MTMyMlowdDA6BgorBgEEAYRZCgQBMSwwKjAKAgUA56+uogIBADAHAgEAAgIO
# SzAHAgEAAgIRIDAKAgUA57EAIgIBADA2BgorBgEEAYRZCgQCMSgwJjAMBgorBgEE
# AYRZCgMCoAowCAIBAAIDB6EgoQowCAIBAAIDAYagMA0GCSqGSIb3DQEBBQUAA4GB
# AK1gcVA471xksLTDiZMLvaKjm/xXX7nwj2xWCTgtmgE8HgyFvJU9uJLeATCNKQvh
# GiB/9GQvzGv07xPR18dwlu3ZY1Sl3QVEApeGr9e5RLoexwUj/9TauCkM27WCfhbF
# lXHgXJi/WOTw9GjDDC72vsi0MgKU+/9eh6e3lhwgs28VMYIEDTCCBAkCAQEwgZMw
# fDELMAkGA1UEBhMCVVMxEzARBgNVBAgTCldhc2hpbmd0b24xEDAOBgNVBAcTB1Jl
# ZG1vbmQxHjAcBgNVBAoTFU1pY3Jvc29mdCBDb3Jwb3JhdGlvbjEmMCQGA1UEAxMd
# TWljcm9zb2Z0IFRpbWUtU3RhbXAgUENBIDIwMTACEzMAAAG6Hz8Z98F1vXwAAQAA
# AbowDQYJYIZIAWUDBAIBBQCgggFKMBoGCSqGSIb3DQEJAzENBgsqhkiG9w0BCRAB
# BDAvBgkqhkiG9w0BCQQxIgQgQWyEMN84JcUm+qasDk2uawv1mzoPq0kECkfaoB/1
# HSEwgfoGCyqGSIb3DQEJEAIvMYHqMIHnMIHkMIG9BCApVb08M25w+tYGWsmlGtp1
# gy1nPcqWfqgMF3nlWYVzBTCBmDCBgKR+MHwxCzAJBgNVBAYTAlVTMRMwEQYDVQQI
# EwpXYXNoaW5ndG9uMRAwDgYDVQQHEwdSZWRtb25kMR4wHAYDVQQKExVNaWNyb3Nv
# ZnQgQ29ycG9yYXRpb24xJjAkBgNVBAMTHU1pY3Jvc29mdCBUaW1lLVN0YW1wIFBD
# QSAyMDEwAhMzAAABuh8/GffBdb18AAEAAAG6MCIEIPibFiTzOiiacCdmF9ddb1UV
# 5A1yGeQufT8irspHcQAbMA0GCSqGSIb3DQEBCwUABIICAC3RJK6GZxx37QF1U4l5
# 4WWJWeQn855NanRbySzcxtVTxcmMq3K+mAjilYhKp15F/QIFE2VoWN5nJJVlgdkh
# 39hyMN4sGYkv4lfLEPHhbU4q3jL3Fpyk+8nnVPrwC4YfDtps+etpfC7kjbKo4bN9
# CLyk6UT14vE1FsJ61NKyyLlup/L0fqVl/YkOHLFLNIiMqjhnS5/2KpTsyWrx0fwM
# yRLZ/qi/w32VgfAebKypLSyXjCfSPo8PgojzLuT+tS7D/Sfd8GbrHrvPUS5VXSuR
# q/dLbDAeim5v20hOlJe2XjryAjPCZWQeB1V/IoNp9MM+YFtSWX5ivyDvEGI9ucMy
# 1luDNfP4xG8craUdekpUx0OUiB4Jy0duZ6RJUZWOu3x4LX6OR0CtoejzpnTDkEpS
# LKnCukceqYd+V8wf55dih/DKyPChVUmi7fLVl+YGy7mnjgbY02B8xTgIYv2Yc9XT
# VYoX3A7cjlBMUhNf70mmyP5wsGtusKSlGDGfZMGLnmVt+biRfHrgLOp3dy2fzGtN
# aOQ5Gx7rnUfpLCy3GIZCEsYZq102cz73eCLCJ6zhyHoqoZBk40KKrYFtqMlcWIXp
# ILhMNcND7rJRFWLjgrisjtIzalM8g2Fwk78tC9JWYvye5eVBXn/6YArTlhoo/ams
# GhGsUnZh4MvCSRAosNtqvWqg
# SIG # End signature block
