


#########################################################################################
#Powershell all hosts user profile for HTL Windows Servers and Clients
#########################################################################################
############################
#########################################################################################
#This profile will be automatically deployed to the Homeone Domain via Group Policy.
# - It will be included in the GPO that applied to Homeone Administrators...
#
# While it is similar in basic structure to the allhosts profile I use on isolated clinet 
#systems, it has been modified to include functions that are more useful in a domain
#environment.   Any function meant to automate Homoeone administration or maintenance will
# not be present in this profile but be placed, instead, in a subprofile that contains
#classes specifically for that purpose.
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




"Powershell Host Initialization is complete.  If the Homone Test Lab Subprofile is to be executed, it will happen now."
####
#Code to govern and execute the loading of the HTL Subprofile & Module
####

"Welcome to Powershell Version $PSVersion"

