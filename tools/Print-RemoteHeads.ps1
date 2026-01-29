param([string]$Remote='origin')
$ErrorActionPreference='Stop'
$heads = git ls-remote --heads $Remote 2>$null
if (-not $heads) { Write-Host ("(no heads found for remote '{0}')" -f $Remote); exit 0 }
$heads