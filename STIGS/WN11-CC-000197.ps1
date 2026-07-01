<#
.SYNOPSIS
    This PowerShell script ensures that Microsoft consumer experiences must be turned off.

.NOTES
    Author          : Lea Angeline C. Escober
    LinkedIn        : linkedin.com/in/lea-escober/
    GitHub          : github.com/lea-escober
    Date Created    : 2026-07-01
    Last Modified   : 2026-07-01
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN11-CC-000197
    Documentation   : https://stigaview.com/products/win11/v1r5/WN11-CC-000197/

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\STIG-ID-WN11-CC-000197.ps1 
#>

# Registry path
$RegistryPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CloudContent"

# Create the registry key if it doesn't exist
if (-not (Test-Path $RegistryPath)) {
    New-Item -Path $RegistryPath -Force | Out-Null
}

# Turn off Microsoft consumer experiences
New-ItemProperty `
    -Path $RegistryPath `
    -Name "DisableWindowsConsumerFeatures" `
    -Value 1 `
    -PropertyType DWord `
    -Force | Out-Null

Write-Host "Microsoft Consumer Experiences have been disabled successfully."

#To Verify
Get-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CloudContent" |
    Select-Object DisableWindowsConsumerFeatures
