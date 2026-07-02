<#
.SYNOPSIS
    This PowerShell script ensures that Windows 11 must be configured to enable Remote host allows delegation of non-exportable credentials.

.NOTES
    Author          : Lea Angeline C. Escober
    LinkedIn        : linkedin.com/in/lea-escober/
    GitHub          : github.com/lea-escober
    Date Created    : 2026-07-02
    Last Modified   : 2026-07-02
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN11-CC-000070
    Documentation   : https://stigaview.com/products/win11/v2r7/WN11-CC-000070/
.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\STIG-ID-WN11-CC-000070.ps1 
#>

____

# Configure Virtualization-Based Security (VBS)
$RegistryPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DeviceGuard"

# Create registry path if missing
if (-not (Test-Path $RegistryPath)) {
    New-Item -Path $RegistryPath -Force | Out-Null
}

# Enable VBS
New-ItemProperty `
    -Path $RegistryPath `
    -Name "EnableVirtualizationBasedSecurity" `
    -Value 1 `
    -PropertyType DWord `
    -Force | Out-Null

# Require platform security features
# 1 = Secure Boot only
# 3 = Secure Boot and DMA Protection
New-ItemProperty `
    -Path $RegistryPath `
    -Name "RequirePlatformSecurityFeatures" `
    -Value 1 `
    -PropertyType DWord `
    -Force | Out-Null

Write-Host "Virtualization-Based Security has been configured with Secure Boot requirement."
Write-Host "Restart the computer for the setting to fully apply."
