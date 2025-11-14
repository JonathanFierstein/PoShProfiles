$AllUserAllHostProfilePath = "C:\Windows\System32\WindowsPowerShell\v1.0\profile.ps1"
$AllUserISEProfilePath = "C:\Windows\System32\WindowsPowerShell\v1.0\Microsoft.PowerShellISE_profile.ps1"
$AllUserPosh7HostProfilePath = "C:\Program Files\PowerShell\7\Microsoft.PowerShell_profile.ps1"
$AllUserWinPoshHostProfilePath = "C:\Windows\System32\WindowsPowerShell\v1.0\Microsoft.PowerShell_profile.ps1"
$CurrentUserAllHostProfilePath = "C:\Users\Night\OneDrive\Documents\WindowsPowerShell\profile.ps1"
$CurrentUserISEHostProfilePath = "C:\Users\Night\OneDrive\Documents\WindowsPowerShell\Microsoft.PowerShellISE_profile.ps1"
$CurrentUserPosh7HostProfilePath = "C:\Users\Night\OneDrive\Documents\PowerShell\Microsoft.PowerShell_profile.ps1"
$CurrentUserWinPoshProfilePath = "C:\Users\Night\OneDrive\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1"


#All of the above profiles should be copied to the Profile Repo.   Changes to the profiles should only
#be made on the primary workstation.  Once any changes complete their tests successfully, then this 
#command can be used to update the Profiles REPO with the new changes.