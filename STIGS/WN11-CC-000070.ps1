<#
.SYNOPSIS
    This PowerShell script ensures that Virtualization-based Security must be enabled on Windows 11 
    with the platform security level configured to Secure Boot or Secure Boot with DMA Protection.
    
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

# Enable required Windows features for VBS
Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V-Hypervisor -All -NoRestart
Enable-WindowsOptionalFeature -Online -FeatureName IsolatedUserMode -All -NoRestart
Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V-All -All -NoRestart

# Configure VBS policy
$RegistryPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DeviceGuard"

if (-not (Test-Path $RegistryPath)) {
    New-Item -Path $RegistryPath -Force | Out-Null
}

New-ItemProperty -Path $RegistryPath -Name "EnableVirtualizationBasedSecurity" -Value 1 -PropertyType DWord -Force | Out-Null

# 1 = Secure Boot only
# 3 = Secure Boot + DMA Protection
New-ItemProperty -Path $RegistryPath -Name "RequirePlatformSecurityFeatures" -Value 1 -PropertyType DWord -Force | Out-Null

# Optional but commonly required for Credential Guard
New-ItemProperty -Path $RegistryPath -Name "LsaCfgFlags" -Value 1 -PropertyType DWord -Force | Out-Null

# Make sure hypervisor launches at boot
bcdedit /set hypervisorlaunchtype auto

Write-Host "VBS configuration applied. Reboot the computer, then run the verification command."


# Verify after Reboot
Get-CimInstance -ClassName Win32_DeviceGuard -Namespace root\Microsoft\Windows\DeviceGuard |
    Select-Object RequiredSecurityProperties, VirtualizationBasedSecurityStatus
