<#
.SYNOPSIS
    This PowerShell script ensures that the PowerShell script block logging must be enabled on Windows 11.

.NOTES
    Author          : Lea Angeline C. Escober
    LinkedIn        : linkedin.com/in/lea-escober/
    GitHub          : github.com/lea-escober
    Date Created    : 2026-07-01
    Last Modified   : 2026-07-01
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN11-CC-000326 
    Documentation   : https://stigaview.com/products/win11/v2r3/WN11-CC-000326/

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\STIG-ID-WN11-CC-000326.ps1 
#>

# Registry path
$RegistryPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\PowerShell\ScriptBlockLogging"

# Create the registry key if it doesn't exist
if (-not (Test-Path $RegistryPath)) {
    New-Item -Path $RegistryPath -Force | Out-Null
}

# Enable PowerShell Script Block Logging
New-ItemProperty `
    -Path $RegistryPath `
    -Name "EnableScriptBlockLogging" `
    -Value 1 `
    -PropertyType DWord `
    -Force | Out-Null

Write-Host "PowerShell Script Block Logging has been enabled."
