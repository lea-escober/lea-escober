<#
.SYNOPSIS
    This PowerShell script ensures that Windows 11 must be configured to enable Remote host allows delegation of non-exportable credentials.

.NOTES
    Author          : Lea Angeline C. Escober
    LinkedIn        : linkedin.com/in/lea-escober/
    GitHub          : github.com/lea-escober
    Date Created    : 2026-07-01
    Last Modified   : 2026-07-01
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN11-CC-000068
    Documentation   : https://stigaview.com/products/win11/v2r7/WN11-CC-000068/
.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\STIG-ID-WN11-CC-000068.ps1 
#>

# Registry path
$RegistryPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CredentialsDelegation"

# Create the registry key if it doesn't exist
if (-not (Test-Path $RegistryPath)) {
    New-Item -Path $RegistryPath -Force | Out-Null
}

# Allow delegation of non-exportable credentials
New-ItemProperty `
    -Path $RegistryPath `
    -Name "AllowProtectedCreds" `
    -Value 1 `
    -PropertyType DWord `
    -Force | Out-Null

Write-Host "Remote host support for delegation of non-exportable credentials has been enabled successfully."

# To Verify
Get-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CredentialsDelegation" |
    Select-Object AllowProtectedCreds
