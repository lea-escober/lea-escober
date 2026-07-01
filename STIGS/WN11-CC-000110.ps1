<#
.SYNOPSIS
    This PowerShell script ensures that Printing over HTTP must be prevented.

.NOTES
    Author          : Lea Angeline C. Escober
    LinkedIn        : linkedin.com/in/lea-escober/
    GitHub          : github.com/lea-escober
    Date Created    : 2026-07-01
    Last Modified   : 2026-07-01
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN11-CC-000110
    Documentation   : https://stigaview.com/products/win11/v2r2/WN11-CC-000110/

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\STIG-ID-WN11-CC-000110.ps1 
#>

# Registry path
$RegistryPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\Printers"

# Create the registry key if it doesn't exist
if (-not (Test-Path $RegistryPath)) {
    New-Item -Path $RegistryPath -Force | Out-Null
}

# Disable printing over HTTP
New-ItemProperty `
    -Path $RegistryPath `
    -Name "DisableHTTPPrinting" `
    -Value 1 `
    -PropertyType DWord `
    -Force | Out-Null

Write-Host "Printing over HTTP has been disabled successfully."

# To verify
Get-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\Printers" |
    Select-Object DisableHTTPPrinting
