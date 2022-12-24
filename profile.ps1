

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


##############################
#                            #
# Host Initialization Code   #
##############################




}

$TimeToExecute = Measure-Command -Expression $ThisProfile

"Profile Execution is Complete.   It took $TimeToExecute.Seconds seconds to finish executing your profile..."
"Welcome to Powershell Version $PSVersion"

