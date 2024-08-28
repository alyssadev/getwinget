# #>
# The following PowerShell code verifies that WinGet is installed. Check https://gwg.aly.pet for more info
# irm gwg.aly.pet | iex

$adm = 'S-1-5-32-544'
$cur = [Security.Principal.WindowsIdentity]::GetCurrent()
if (-NOT ([bool]($cur.Groups -match $adm))) {
  if ($cur.UserClaims | ? { $_.Value -eq $adm}) {
    Write-Warning "Run Powershell as Administrator, or elevate with 'sudo pwsh' (https://github.com/lukesampson/psutils) and then run this command again"
    return
  } else {
    Write-Error "Run Powershell as Administrator"
    return
  }
}
Install-PackageProvider -Name NuGet -Force -ErrorAction SilentlyContinue | Out-Null
Install-Module -Name Microsoft.WinGet.Client -Force -Repository PSGallery | Out-Null
Repair-WinGetPackageManager <#
