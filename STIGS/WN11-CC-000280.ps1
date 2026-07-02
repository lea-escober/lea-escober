<#
.SYNOPSIS
    This PowerShell script ensures that Remote Desktop Services must always prompt a client for passwords upon connection.

.NOTES
    Author          : Lea Angeline C. Escober
    LinkedIn        : linkedin.com/in/lea-escober/
    GitHub          : github.com/lea-escober
    Date Created    : 2026-07-02
    Last Modified   : 2026-07-02
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN11-CC-000280
    Documentation   : https://stigaview.com/products/win11/v2r7/WN11-CC-000280/
.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\STIG-ID-WN11-CC-000280.ps1 
#>

____

# Registry path
$RegistryPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services"

# Create the registry key if it doesn't exist
if (-not (Test-Path $RegistryPath)) {
    New-Item -Path $RegistryPath -Force | Out-Null
}

# Always prompt for password upon Remote Desktop connection
New-ItemProperty `
    -Path $RegistryPath `
    -Name "fPromptForPassword" `
    -Value 1 `
    -PropertyType DWord `
    -Force | Out-Null

Write-Host "The 'Always prompt for password upon connection' policy has been enabled successfully."



# To verify
Get-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services" |
    Select-Object fPromptForPassword
