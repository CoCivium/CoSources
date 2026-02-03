$ErrorActionPreference="SilentlyContinue"
function HasMB {
  @(Get-CimInstance -Namespace root/SecurityCenter2 -ClassName AntiVirusProduct -ErrorAction SilentlyContinue |
    Where-Object { $_.displayName -match "Malwarebytes" }).Count -gt 0
}
if(HasMB){ exit 0 }

try { Restart-Service -Name MBAMService -Force } catch {}
$wscExe = "C:\Program Files\Malwarebytes\Anti-Malware\MBAMWsc.exe"
if(Test-Path $wscExe){
  try { Start-Process -FilePath $wscExe -WindowStyle Hidden } catch {}
}
exit 0
