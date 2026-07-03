<#
.SYNOPSIS
    This PowerShell script ensures that The system must be configured to meet the minimum session security requirement for NTLM SSP based servers.

.NOTES
    Author          : Lea Angeline C. Escober
    LinkedIn        : linkedin.com/in/lea-escober/
    GitHub          : github.com/lea-escober
    Date Created    : 2026-07-02
    Last Modified   : 2026-07-02
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN11-CC-000220
    Documentation   : https://stigaview.com/products/win11/v2r7/WN11-SO-000220/

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\STIG-ID-WN11-CC-000220.ps1 
#>

____

# Registry path
$RegistryPath = "HKLM:\SYSTEM\CurrentControlSet\Control\Lsa\MSV1_0"

# Create the registry key if it doesn't exist
if (-not (Test-Path $RegistryPath)) {
    New-Item -Path $RegistryPath -Force | Out-Null
}

# Configure minimum session security for NTLM SSP-based servers
# 0x20080000 (537395200)
# - Require NTLMv2 session security
# - Require 128-bit encryption
New-ItemProperty `
    -Path $RegistryPath `
    -Name "NTLMMinServerSec" `
    -Value 537395200 `
    -PropertyType DWord `
    -Force | Out-Null

Write-Host "Minimum session security for NTLM SSP-based servers has been configured successfully."


# To verify
Get-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Lsa\MSV1_0" |
    Select-Object NTLMMinServerSec
