<#
.SYNOPSIS
    This PowerShell script ensures that Remote Desktop Services must be configured with the client connection encryption set to the required level.

.NOTES
    Author          : Lea Angeline C. Escober
    LinkedIn        : linkedin.com/in/lea-escober/
    GitHub          : github.com/lea-escober
    Date Created    : 2026-07-02
    Last Modified   : 2026-07-02
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN11-CC-000290
    Documentation   : https://stigaview.com/products/win11/v2r7/WN11-CC-000290/

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\STIG-ID-WN11-CC-000290.ps1 
#>

____

$RegistryPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services"

if (-not (Test-Path $RegistryPath)) {
    New-Item -Path $RegistryPath -Force | Out-Null
}

# Set Remote Desktop client connection encryption level to High
# 3 = High Level
New-ItemProperty `
    -Path $RegistryPath `
    -Name "MinEncryptionLevel" `
    -Value 3 `
    -PropertyType DWord `
    -Force | Out-Null

Write-Host "Remote Desktop encryption level has been set to High."


# To verify
Get-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services" |
    Select-Object MinEncryptionLevel
