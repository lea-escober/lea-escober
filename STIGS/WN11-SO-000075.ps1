<#
.SYNOPSIS
    This PowerShell script ensures that the required legal notice is configured to display before console logon.

.NOTES
    Author          : Lea Angeline C. Escober
    LinkedIn        : linkedin.com/in/lea-escober/
    GitHub          : github.com/lea-escober
    Date Created    : 2026-07-02
    Last Modified   : 2026-07-02
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN11-SO-000075
    Documentation   : https://stigaview.com/products/win11/v2r7/WN11-SO-000075/
.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\STIG-ID-WN11-SO-000075.ps1 
#>

$RegistryPath = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System"

$LegalNoticeText = @"
You are accessing a U.S. Government (USG) Information System (IS) that is provided for USG-authorized use only.

By using this IS (which includes any device attached to this IS), you consent to the following conditions:

-The USG routinely intercepts and monitors communications on this IS for purposes including, but not limited to, penetration testing, COMSEC monitoring, network operations and defense, personnel misconduct (PM), law enforcement (LE), and counterintelligence (CI) investigations.

-At any time, the USG may inspect and seize data stored on this IS.

-Communications using, or data stored on, this IS are not private, are subject to routine monitoring, interception, and search, and may be disclosed or used for any USG-authorized purpose.

-This IS includes security measures (e.g., authentication and access controls) to protect USG interests--not for your personal benefit or privacy.

-Notwithstanding the above, using this IS does not constitute consent to PM, LE or CI investigative searching or monitoring of the content of privileged communications, or work product, related to personal representation or services by attorneys, psychotherapists, or clergy, and their assistants. Such communications and work product are private and confidential. See User Agreement for details.
"@

# Create registry path if missing
if (-not (Test-Path $RegistryPath)) {
    New-Item -Path $RegistryPath -Force | Out-Null
}

# Configure legal notice text
New-ItemProperty `
    -Path $RegistryPath `
    -Name "LegalNoticeText" `
    -Value $LegalNoticeText `
    -PropertyType String `
    -Force | Out-Null

Write-Host "LegalNoticeText has been configured successfully."


# To Verify
Get-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" |
    Select-Object LegalNoticeText
