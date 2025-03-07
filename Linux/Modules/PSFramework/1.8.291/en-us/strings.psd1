﻿@{
	'Add-PSFLoggingProviderRunspace.Instance.NotFound' = 'Unable to find logging provider instance {1} of provider {0}'
	'Assembly.Callback.Failed' = 'Error when executing callback {0}'
	'Assembly.ComputerManagement.SessionContainer.NoCimSessionKey' = 'Session Container for "{0}" does not contain a CimSession connection.'
	'Assembly.ComputerManagement.SessionContainer.NoPSSessionKey' = 'Session Container for "{0}" does not contain a PSSession connection.'
	'Assembly.ConfigurationHost.ConfigNotFound' = 'The configuration item {0} could not be found in the configuration system'
	'Assembly.Filter.Condition.NotInSet' = 'The condition {0} cannot be found in the provided condition set {1}. Conditions included in that set: {2}'
	'Assembly.Filter.ConditionSet.Required' = 'No Condition Set provided! Either permanently assign a set to the expression or specify it as a parameter!'
	'Assembly.Filter.Expression.SyntaxError' = 'Error parsing expression! {0}'
	'Assembly.Filter.InvalidName' = 'Invalid filter name: {0}. Make sure the name specified only consists of numbers, letters and underscores (and equals neither 0 or 1)!'
	'Assembly.Filter.NoCondition' = 'Cannot evaluate a filter expression without any conditions!'
	'Assembly.Size.ComparisonError' = 'Cannot compare a {0} to a {1}'
	'Assembly.UtilityHost.AliasNotFound' = 'Failed to find alias: {0}'
	'Assembly.UtilityHost.AliasProtected' = 'The alias "{0}" is protected and cannot be removed!'
	'Assembly.UtilityHost.AliasReadOnly' = 'The alias "{0}" is read only! To remove it, also specify the "-Force" parameter.'
	'Assembly.UtilityHost.PrivateFieldNotFound' = 'Could not find a private field named "{0}"'
	'Assembly.UtilityHost.PrivateMethodNotFound' = 'Could not find a private method named "{0}"'
	'Assembly.UtilityHost.PrivatePropertyNotFound' = 'Could not find a private property named "{0}"'
	'Assembly.Validation.Generic.ArgumentIsEmpty' = 'Could not validate input, no data was provided!'
	'Assembly.Validation.LanguageMode.BadMode' = 'The specified script is in language mode {1} when only {0} is allowed.'
	'Assembly.Validation.LanguageMode.NotAScriptBlock' = 'The specified input was not detected as a scriptblock: {0}. Can only validate scriptblocks!'
	'Assembly.Validation.PSVersion.TooLow' = 'This parameter requires at least PowerShell version {0} (current version detected: {1})'
	'Assembly.Validation.ScriptBlock.IsNull' = 'No validation scriptblock found!'
	'Assembly.Validation.UntrustedData' = 'This data has been flagged as untrustworthy: {0}!'
	'Clear-PSFResultCache.Clear' = 'Clearing the result cache'
	'Configuration.Remove-PSFConfig.DeleteFailed' = 'Failed to remove configuration setting: {0} | Can be deleted: {1} | Enforced by policy {2}'
	'Configuration.Remove-PSFConfig.DeleteSuccessful' = 'Successfully remove configuration setting: {0}'
	'Configuration.Remove-PSFConfig.InvalidConfiguration' = 'The configuration setting "{0}" could not be found!'
	'Configuration.Remove-PSFConfig.ShouldRemove' = 'Removing configuration item from memory'
	'Configuration.Schema.Default.ImportFailed' = 'Failed to import {0}'
	'Configuration.Schema.Default.SetFailed' = 'Failed to set ''{0}'''
	'Configuration.Schema.MetaJson.ExecuteInclude.Error' = 'Error loading include configuration file: {0}'
	'Configuration.Schema.MetaJson.InvalidJson' = 'Failed to access json content from: {0}'
	'Configuration.Schema.MetaJson.InvalidPsd1' = 'Error reading file {0} - ensure it is a valid psd1'
	'Configuration.Schema.MetaJson.ProcessFile' = 'Reading Node: {0}'
	'Configuration.Schema.MetaJson.ProcessResource' = 'Processing resource: {0}'
	'Configuration.Schema.MetaJson.ResolveFile' = 'Cannot resolve path: {0}'
	'Configuration.Schema.MetaJson.UnknownVersion' = 'Unknown version "{1}" in: {0}'
	'Configuration.Schema.MetaJson.WebError' = 'Error downloading / loading configuration from {0}'
	'Configuration_ValidateLanguage' = '{0} is not recognized as a legal language code, such as "en-US" or "de-DE"'
	'ConvertFrom-PSFClixml.BadInput' = 'Unsupported input! Provide either a string or byte-array that previously were serialized from objects in powershell'
	'ConvertTo-PSFClixml.Conversion.Error' = 'Error converting input to Clixml'
	'Disable-PSFTaskEngineTask.Disabling' = 'Disabling task engine task: {0}'
	'Enable-PSFTaskEngineTask.Enable' = 'Enabling task engine task: {0}'
	'Export-PSFClixml.Exporting' = 'Writing data to ''{0}'''
	'Export-PSFClixml.Exporting.Failed' = 'Failed to export object'
	'Export-PSFConfig.ToRegistry' = 'Cannot export modulecache to registry! Please pick a file scope for your export destination'
	'Export-PSFConfig.Write.Error' = 'Failed to export to file'
	'FlowControl.Invoke-PSFProtectedCommand.Confirmed' = 'Execution Confirmed: {0}'
	'FlowControl.Invoke-PSFProtectedCommand.Denied' = 'Execution Denied: {0}'
	'FlowControl.Invoke-PSFProtectedCommand.ErrorEvent' = 'Executing error event for "{0}" against {1}'
	'FlowControl.Invoke-PSFProtectedCommand.ErrorEvent.Failed' = 'Error executing error event for "{0}" against {1}: {2}'
	'FlowControl.Invoke-PSFProtectedCommand.ErrorEvent.Success' = 'Successfully executed error event for "{0}" against {1}'
	'FlowControl.Invoke-PSFProtectedCommand.Failed' = 'Failed to: {0}'
	'FlowControl.Invoke-PSFProtectedCommand.Retry' = 'Failed {0} / {1} attempts, trying again: {2}'
	'FlowControl.Invoke-PSFProtectedCommand.Success' = 'Execution Successful: {0}'
	'Get-PSFConfigValue.NoValue' = 'No Configuration Value available for {0}'
	'Import-PSFClixml.Conversion.Failed' = 'Failed to convert input object'
	'Import-PSFClixml.Path.NotFile' = '{0} is not a file'
	'Import-PSFClixml.Path.Resolution' = 'Failed to resolve path: {0}'
	'Import-PSFClixml.Processing' = 'Processing {0}'
	'Import-PSFLoggingProvider.Datum.Error' = 'Error processing logging provider entry'
	'Import-PSFLoggingProvider.Import.Error' = 'Error loading json data from {0}'
	'Import-PSFPowerShellDataFile.Error.NoHashtable' = 'File contains no hashtable: {0}'
	'Import-PSFPowerShellDataFile.Error.Syntax' = 'File has an invalid PowerShell syntax: {0}'
	'Import-PSFPowerShellDataFile.Error.Unsafe' = 'File is not safe to execute: {0}'
	'Install-PSFLoggingProvider.Installation.Error' = 'Failed to install provider ''{0}'''
	'Install-PSFLoggingProvider.Provider.NotFound' = 'Provider {0} not found!'
	'New-PSFSessionContainer.UnknownSessionType' = 'Unknown type of session: {0} | From {1}'
	'New-PSFSupportPackage.Assemblies' = 'Collecting list of loaded assemblies (Name, Version, and Location)'
	'New-PSFSupportPackage.ConsoleBuffer' = 'Trying to collect copy of console buffer (what you can see on your console)'
	'New-PSFSupportPackage.CPU' = 'Collecting CPU information ({0})'
	'New-PSFSupportPackage.DbaTools.Errors' = 'Collecting dbatools logged errors (Get-DbatoolsLog -Errors)'
	'New-PSFSupportPackage.DbaTools.Messages' = 'Collecting dbatools logged messages (Get-DbatoolsLog)'
	'New-PSFSupportPackage.Export.Failed' = 'Failed to export dump to file!'
	'New-PSFSupportPackage.Header' = 'Gathering information...
Will write the final output to: {0}
{1}
Be aware that this package contains a lot of information including your input history in the console.
Please make sure no sensitive data (such as passwords) can be caught this way.

Ideally start a new console, perform the minimal steps required to reproduce the issue, then run this command.
This will make it easier for us to troubleshoot and you won''t be sending us the keys to your castle.'
	'New-PSFSupportPackage.History' = 'Collecting Input history (Get-History)'
	'New-PSFSupportPackage.Messages' = 'Collecting PSFramework logged messages (Get-PSFMessage)'
	'New-PSFSupportPackage.Modules' = 'Collecting list of loaded modules (Get-Module)'
	'New-PSFSupportPackage.MsgErrors' = 'Collecting PSFramework logged errors (Get-PSFMessage -Errors)'
	'New-PSFSupportPackage.OperatingSystem' = 'Collecting Operating System information (Win32_OperatingSystem)'
	'New-PSFSupportPackage.PSErrors' = 'Adding content of $Error'
	'New-PSFSupportPackage.PSVersion' = 'Collecting PowerShell & .NET Version ($PSVersionTable)'
	'New-PSFSupportPackage.RAM' = 'Collecting Ram information ({0})'
	'New-PSFSupportPackage.Snapins' = 'Collecting list of loaded snapins (Get-PSSnapin)'
	'New-PSFSupportPackage.Variables' = 'Adding variables specified for export: {0}'
	'New-PSFSupportPackage.ZipCompression.Failed' = 'Failed to pack dump-file into a zip archive. Please do so manually before submitting the results as the unpacked xml file will be rather large.'
	'Read-PsfConfigEnvironment.BadData' = 'Cannot import setting from registry: {0} - Error parsing: {1}'
	'Register-PSFConfig.NoRegistry' = 'Cannot register configurations on non-windows machines to registry. Please specify a file-based scope'
	'Register-PSFConfig.Registering' = 'Registering {0} for {1}'
	'Register-PSFConfig.Registering.Failed' = 'Failed to export {0}, to scope {1}'
	'Register-PSFConfig.Type.NotSupported' = 'Invalid Input, cannot export {0}, type not supported'
	'Register-PSFLoggingProvider.Installation.Failed' = 'Failed to install logging provider ''{0}'''
	'Register-PSFLoggingProvider.NotInstalled.Termination' = 'Failed to enable logging provider {0} on registration! It was not recognized as installed. Consider running ''Install-PSFLoggingProvider'' to properly install the prerequisites.'
	'Register-PSFLoggingProvider.RegistrationEvent.Failed' = 'Failed to register logging provider ''{0}'' - Registration event failed.'
	'Register-PSFMessageColorTransform.Level.Invalid' = 'Invalid level for a message color rule: {0}! The levels "Warning" and "Error" cannot be selected as warning messages cannot be colored.'
	'Register-PSFParameterClassMapping.NotImplemented' = 'Support for the {0} parameter class has not yet been added!'
	'Register-PSFParameterClassMapping.Registration.Error' = 'Failed to update property mapping for {0} : {1}. This is likely happening on some Linux distributions due to an underlying .NET issue and means the parameter class cannot be used.'
	'Register-PSFRunspace.Runspace.Creating' = 'Registering runspace: <c=''em''>{0}</c>'
	'Register-PSFRunspace.Runspace.Updating' = 'Updating runspace: <c=''em''>{0}</c>'
	'Reset-PSFConfig.Resetting' = 'Reset to default value'
	'Reset-PSFConfig.Resetting.Failed' = 'Failed to reset the configuration item.'
	'Resolve-PSFItem.BadPath' = 'Path could not be resolved: {0}'
	'Resolve-PSFItem.BadPaths' = 'Paths could not be resolved: {0}'
	'Resolve-PSFItem.Path.Found' = 'Found {1} items under {0}'
	'Resolve-PSFItem.Path.Summary' = 'Searched {0} paths, finding {1} items. {2} paths could not be resolved.'
	'Resolve-PSFPath.Path.ExistsNot' = 'Failed to resolve path'
	'Resolve-PSFPath.Path.MultipleItems' = 'Could not resolve to only a single path!'
	'Resolve-PSFPath.Path.MultipleParents' = 'Could not resolve to only a single parent path!'
	'Resolve-PSFPath.Path.ParentExistsNot' = 'Failed to resolve path'
	'Resolve-PSFPath.Path.WrongProvider' = 'Resolved provider is {0} when it should be {1}'
	'Set-PSFLoggingProvider.Provider.NotFound' = 'Provider {0} not found!'
	'Set-PSFLoggingProvider.Provider.NotInstalled' = 'Provider {0} not installed! Run "Install-PSFLoggingProvider" first'
	'Set-PSFLoggingProvider.Provider.V1NoInstance' = 'The Provider {0} is a first generation logging provider and does not support instances!'
	'Set-PSFLoggingProvider.Wait.Timeout' = 'Timeout waiting for {0} > {1} to be created. Logs may not be written as expected!'
	'Set-PSFTeppResult.UpdateValue' = 'Setting the cache'
	'Start-PSFRunspace.Starting' = 'Starting runspace: <c=''em''>{0}</c>'
	'Start-PSFRunspace.Starting.Failed' = 'Failed to start runspace: <c=''em''>{0}</c>'
	'Start-PSFRunspace.UnknownRunspace' = 'Failed to start runspace: <c=''em''>{0}</c> | No runspace registered under this name!'
	'Stop-PSFRunspace.Stopping' = 'Stopping runspace: <c=''em''>{0}</c>'
	'Stop-PSFRunspace.Stopping.Failed' = 'Failed to stop runspace: <c=''em''>{0}</c>'
	'Stop-PSFRunspace.UnknownRunspace' = 'Failed to stop runspace: <c=''em''>{0}</c> | No runspace registered under this name!'
	'Test-PSFFilter.Condition.NotInSet' = 'Condition not included: {0}'
	'Unregister-PSFConfig.NoRegistry' = 'Cannot unregister configurations from registry on non-windows machines.'
	'Validate.Filter.ConditionName' = 'Invalid filter name: {0}. Make sure the name specified only consists of numbers, letters and underscores (and equals neither 0 or 1)!'
	'Validate.FSPath' = 'The specified input is not an existing filesystem path: {0}'
	'Validate.FSPath.File' = 'The specified input is not a path to an existing file: {0}'
	'Validate.FSPath.FileOrParent' = 'The specified input is not a path to an existing file, nor does its parent folder exist: {0}'
	'Validate.FSPath.Folder' = 'The specified input is not a path to an existing folder: {0}'
	'Validate.Path' = 'The specified input is not an existing path: {0}'
	'Validate.Path.Container' = 'The specified input is not an existing container path (e.g: Folder): {0}'
	'Validate.Path.Leaf' = 'The specified input is not an existing leaf path (e.g: File): {0}'
	'Validate.SafeName' = 'Illegal name! This parameter only allows letters, numbers, dots, dashes and underscores. Value provided: "{0}"'
	'Validate.TimeSpan.Positive' = 'The specified input is not a timespan with a value greater than 0: {0}'
	'Validate.Uri.Absolute' = 'The specified input is not an absolute uri: {0}'
	'Validate.Uri.Absolute.File' = 'The specified input is not an absolute uri pointing at a file: {0}'
	'Validate.Uri.Absolute.Https' = 'The specified input is not an absolute uri pointing at a weblink (https://...): {0}'
}