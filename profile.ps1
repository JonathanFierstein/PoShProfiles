

$ThisProfile = {
	#########################################################################################
	#Powershell all hosts user profile ----- Created 12-5-2022
	#########################################################################################
	#
	#########################################################################################
	#Profile & Repository History
	#8/22/2024 - Modification history can now be found in the History.md document located
	#within the root directory of the PoshProfile repository.
	##########################################################################################
		
		
		
		
	##########################################################################################
	# {Code Section} - Variable Declaration Section   (Contains Variable and Aliases)
	##########################################################################################
	$UsernameATUserDomain = "$ENV:Username@$ENV:USERDOMAIN"
	$Shellhasadmin = [bool](([System.Security.Principal.WindowsIdentity]::GetCurrent()).groups -match "S-1-5-32-544")
	$PSVersion = "$($PSVersionTable.PSVersion.Major)" + "." + "$($PSVersionTable.PSVersion.Minor)"


	### Alias to make opening a file inside nodepad++ from powershell easy :)
	New-Alias -name "np" -value "C:\Program Files (x86)\Notepad++\notepad++.exe" -Description "Notepad++ Alias"
	

	
	##########################################################################################
	# {Code Section} - Function Declaration Section
	##########################################################################################
	
	

	function Get-SHA512FileHash
	{
		<#
		.SYNOPSIS
			Calculates a SHA512 File Hash for a file.
		
		.DESCRIPTION
			The Get-SHA512FileHash will calculate and output a SHA512 file hash for a single file.  It also has an option to save the hash as "filename.SHA512",
			for later reference.  Obviously this is only useful for files whose content shoul stay exactly the same.
		
		.PARAMETER Path
			The path to the file the hash should be calculated from.
		
		.PARAMETER SaveHash
			This switch will cause the computed file hash to be saved as "filename.SHA512" in the same directory as the file the hash was calculated from.
		
		.EXAMPLE
			PS C:\> Get-SHA512FileHash -Path 'C:\ISOs\Windows11Pro.ISO'
			
			This will return the SHA512 file hash for Windows11Pro.ISO as a string.
		
		.OUTPUTS
			string
		
		.NOTES
			Additional information about the function.
		#>	
		[CmdletBinding(DefaultParameterSetName = 'Simple',
					   ConfirmImpact = 'Low',
					   PositionalBinding = $true)]
		[OutputType([System.String], ParameterSetName = 'Simple')]
		[OutputType([System.String], ParameterSetName = 'Complex')]
		[OutputType([System.String])]
		param
		(
			[Parameter(ParameterSetName = 'Simple',
					   Mandatory = $true,
					   ValueFromPipeline = $true,
					   ValueFromPipelineByPropertyName = $true,
					   Position = 0)]
			[Parameter(ParameterSetName = 'Complex',
					   Mandatory = $true,
					   ValueFromPipeline = $true,
					   ValueFromPipelineByPropertyName = $true,
					   Position = 0)]
			[ValidateNotNullOrEmpty()]
			[string]$Path,
			[Parameter(ParameterSetName = 'Complex',
					   Mandatory = $false,
					   Position = 1)]
			[switch]$SaveHash
		)
		
		Begin
		{
			
		}
		Process
		{
			switch ($PsCmdlet.ParameterSetName)
			{
				'Simple' {
					$Hash = Get-FileHash -Path $Path -Algorithm SHA512
					return $Hash.hash
				}
				'Complex' {
					$File = Get-ChildItem -Path $Path
					$FileLocation = $Path | Split-Path
					$Hash = Get-FileHash -Path $Path -Algorithm SHA512
					$HashFileName = "$($File.basename).SHA512"
					Set-Content -Value $Hash.hash -Path "$FileLocation\$HashFileName"
					return $Hash.hash
				}
			}
			
		}
		End
		{
			
		}
	} #Get-SHA512FileHash
	
	
	function ConvertTo-Base64EncodedString
	{
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
	
	
	
	

	function ConvertFrom-Base64EncodedString
	{
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
	

	function gcext
	{
		<#
		.SYNOPSIS
			Sorts the files in a directory by extension and counts the total files of each type.
		
		.DESCRIPTION
			This functions enumerates a directory and sorts the files by extension and then displays the total number of files for each extension type found in the directory as a table.
		
		.PARAMETER Path
			The path to the directory where the files should be catagorized and counted.
		
		.EXAMPLE
			PS C:\> gcext -Path C:\FSO\
		
			This command would 
		.NOTES
			Additional information about the function.
		#>		
		[CmdletBinding(ConfirmImpact = 'None')]
		[OutputType([System.Object])]
		param
		(
			[Parameter(ValueFromPipeline = $true,
					   Position = 0)]
			[ValidateNotNullOrEmpty()]
			[system.string]$Path = .
		)
		
		Begin
		{
			
		}
		Process
		{
			Get-ChildItem -Path $Path |
			Where-Object { !$_.PSisContainer } |
			Group-Object -Property Extension |
			Sort-Object -Property Extension, Count -Descending |
			Format-Table -Property Count, Name, Group
		}
		End
		{
			
		}
	}
	
	
	
	
	
	
	
	
	### Git Functions Below This Line
	
	function gs
	{
		git status
	}
	
	function gaa
	{
		git add *
	}
	
	function gc
	{
		git commit
	}
	
	
	function gcm
	{
		param
		(
			[Parameter(ParameterSetName = 'message',
					   Mandatory = $true,
					   ValueFromPipeline = $false,
					   ValueFromPipelineByPropertyName = $false,
					   Position = 0)]
			[ValidateNotNullOrEmpty()]
			[ValidateScript({ $_.length -ile 70 })]
			[string]$Message
		)
		
		git commit -m "$Message"
	}
	
	
	##############################
	#                            #
	# Host Initialization Code   #
	##############################
	Invoke-Expression (& { (zoxide init powershell | Out-String) })
	Set-Alias -Name z -Value __zoxide_z -Option AllScope -Scope Global -Force
	Set-Alias -Name zi -Value __zoxide_zi -Option AllScope -Scope Global -Force
	
	oh-my-posh init pwsh --config 'https://raw.githubusercontent.com/JonathanFierstein/themes/clean-detailed.omp.json' |
	Invoke-Expression


} #end $ThisProfile

$TimeToExecute = Measure-Command -Expression $ThisProfile
Write-Host "Welcome to Powershell Version $PSVersion"
Write-Host "It took $TimeToExecute.Seconds seconds to execute your PowerShell profile..."


