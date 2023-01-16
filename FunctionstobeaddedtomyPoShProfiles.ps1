

<#
	.SYNOPSIS
		Converts a string to it's base64encoded counterpart.
	
	.DESCRIPTION
		This function converts an input string to a base64encoded string.
	
	.PARAMETER InputString
		This is a [string] that will be base64 encoded by this function. 
	
	.EXAMPLE
		PS C:\> ConvertTo-Base64EncodedString -InputString 'This string will be encoded.'
	
	.NOTES
		Additional information about the function.
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
		
		Write-Verbose -Message "Converting $InputString to a [Byte] array."
		$ByteArray = [System.Text.Encoding]::Unicode.GetBytes($InputString)
		
		Write-Verbose -Message "Base64 Encoding the [Byte] array created from the input [string]."
		$EncodedOutputString = [Convert]::ToBase64String($ByteArray)
		
		
		Write-Output $EncodedOutputString
		
		
	}
	End
	{
		Write-Verbose -Message "Ending $($MyInvocation.MyCommand)"
	}
} #ConvertTo-Base64EncodedString






