

$ThisProfile = {
#########################################################################################
#Powershell all hosts user profile ----- Created 12-5-2022
#########################################################################################
############################
#########################################################################################
#*Storage Location Typically C:\Users\username\Documents\WindowsPowershell\profile.ps1
# or
#*PWSH Storage Location = C:\Users\username\Documents\Powershell\profile.ps1
# This is my personal PS profile that I use on all hosts.  This profile was originally 
# designed to be my profile on my perosnal desktop, notebook, or other  
# isolated host or system.
##########################################################################################
#
# Variable Declaration Section   (Contains Variable and Aliases)
##########################################################################################
$UsernameATUserDomain = "$ENV:Username@$ENV:USERDOMAIN"
$Shellhasadmin = [bool](([System.Security.Principal.WindowsIdentity]::GetCurrent()).groups -match "S-1-5-32-544")
$PSVersion = "$($PSVersionTable.PSVersion.Major)" + "." + "$($PSVersionTable.PSVersion.Minor)"


### Alias to make opening a file inside nodepad++ from powershell easy :)
New-Alias -name "np" -value "C:\Program Files (x86)\Notepad++\notepad++.exe" -Description "Notepad++ Normal Install Alias"


###############################
#                             #
# Function Declaration Section#
###############################
	
	
<#
	.SYNOPSIS
		Converts a string to it's base64encoded counterpart.
	
	.DESCRIPTION
		This function converts an input string to a base64encoded string.
	
	.PARAMETER InputString
		This is a [string] that will be base64 encoded by this function. 
	
	.EXAMPLE
		PS C:\> ConvertTo-Base64EncodedString -InputString 'This string will be encoded.'
		VABoAGkAcwAgAHMAdAByAGkAbgBnACAAdwBpAGwAbAAgAGIAZQAgAGUAbgBjAG8AZABlAGQALgA=
	
	.NOTES
		1-15-2023 todo:  Add ability for function to accept an array of strings as input.
#>
	function ConvertTo-Base64EncodedString
	{
		[CmdletBinding()]
		[OutputType([String])]
		param
		(
			[Parameter(Mandatory = $true,
					   ValueFromPipeline = $true,
					   ValueFromPipelineByPropertyName = $true,
					   Position = 0)]
			[AllowEmptyString()]
			[ValidateNotNull()]
			[String]$InputString
		)
		
		Begin
		{
			Write-Verbose -Message "Starting $($MyInvocation.MyCommand)"
		}
		Process
		{
			
			Write-Verbose -Message "Converting the [string] `"$InputString`" to a [byte] array."
			$ByteArray = [System.Text.Encoding]::Unicode.GetBytes($InputString)
			
			Write-Verbose -Message "Base64 encoding the [byte] array created from the input [string]."
			$EncodedOutputString = [Convert]::ToBase64String($ByteArray)
			
			
			Write-Output $EncodedOutputString
			
			
		}
		End
		{
			Write-Verbose -Message "Ending $($MyInvocation.MyCommand)"
		}
	} #ConvertTo-Base64EncodedString
	
	
	
	
<#
	.SYNOPSIS
		Converts a base64 encoded string to its cleartext counterpart.
	
	.DESCRIPTION
		This function decodes a previously base64 encoded [string] back to cleartext.
	
	.PARAMETER EncodedString
		This should be a base64 encoded [string].
	
	.EXAMPLE
		$EncodedString = ConvertTo-Base64EncodedString -InputString "This is a string."
		$EncodedString
		VABoAGkAcwAgAGkAcwAgAGEAIABzAHQAcgBpAG4AZwAuAA==
		
		PS C:\> ConvertFrom-Base64EncodedString -EncodedString $EncodedString
		"This is a string."
	
	.NOTES
		1-15-2023 todo:  Add ability for function to accept an array of strings as input.
#>
	function ConvertFrom-Base64EncodedString
	{
		[CmdletBinding(ConfirmImpact = 'None',
					   PositionalBinding = $true)]
		[OutputType([string])]
		param
		(
			[Parameter(Mandatory = $true,
					   ValueFromPipeline = $true,
					   ValueFromPipelineByPropertyName = $true,
					   Position = 0,
					   HelpMessage = 'a base64 encoded [string] to be decoded')]
			[AllowEmptyString()]
			[ValidateNotNull()]
			[string]$EncodedString
		)
		
		Begin
		{
			Write-Verbose -Message "Starting $($MyInvocation.MyCommand)"
		}
		Process
		{
			Write-Verbose -Message 'Decoding the input string and storing it in a [byte] array.'
			$Bytes = [System.Convert]::FromBase64String($EncodedString)
			
			Write-Verbose -Message 'Converting the decoded [byte] array into Unicode cleartext.'
			$DecodedString = [System.Text.Encoding]::Unicode.GetString($Bytes)
			
			Write-Output $DecodedString
		}
		End
		{
			Write-Verbose -Message "Ending $($MyInvocation.MyCommand)"
		}
	} #ConvertFrom-Base64EncodedString
	
	


##############################
#                            #
# Host Initialization Code   #
##############################




} #end $ThisProfile

$TimeToExecute = Measure-Command -Expression $ThisProfile

"Profile Execution is Complete.   It took $TimeToExecute.Seconds seconds to finish executing this profile..."
"Welcome to Powershell Version $PSVersion"

