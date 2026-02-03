$ErrorActionPreference="SilentlyContinue"
Set-StrictMode -Version Latest

function UTS { (Get-Date).ToUniversalTime().ToString("yyyyMMddTHHmmssZ") }

$Targets = @(
  "C:\Program Files\Git\mingw64\bin\git.exe",
  "C:\Program Files\Git\mingw64\libexec\git-core\git-remote-https.exe"
)

function Get-Info([string]$p){
  if(-not (Test-Path $p)){ return [pscustomobject]@{ Path=$p; Exists=$false } }
  $sig = Get-AuthenticodeSignature $p
  $hash = (Get-FileHash -Algorithm SHA256 -Path $p).Hash
  [pscustomobject]@{
    Path=$p
    Exists=$true
    SigStatus=("$($sig.Status)")
    Thumbprint=("$($sig.SignerCertificate.Thumbprint)")
    Subject=("$($sig.SignerCertificate.Subject)")
    NotAfter=("$($sig.SignerCertificate.NotAfter)")
    Sha256=$hash
  }
}

$now = UTS
$info = $Targets | ForEach-Object { Get-Info $_ }

$basePath = Join-Path $env:USERPROFILE "Documents\OE_Tools\OE_GitIntegrityWatch.baseline.json"
$logPath  = Join-Path $env:USERPROFILE "Documents\OE_Tools\OE_ALERTS.log"

if(-not (Test-Path $basePath)){
  $info | ConvertTo-Json -Depth 6 | Set-Content -Encoding UTF8 -Path $basePath
  Add-Content -Encoding UTF8 -Path $logPath -Value "$now BASELINE_CREATED git-integrity-watch"
  exit 0
}

$base = Get-Content -Raw $basePath | ConvertFrom-Json
$changes = @()

for($i=0; $i -lt @($info).Count; $i++){
  $a = @($info)[$i]
  $b = @($base)[$i]
  if($a.Path -ne $b.Path){ $changes += "PATH_MISMATCH idx=$i $($a.Path) != $($b.Path)"; continue }
  foreach($k in "Exists","SigStatus","Thumbprint","Sha256"){
    if(("$($a.$k)") -ne ("$($b.$k)")){ $changes += "CHG $k $($a.Path) $($b.$k) -> $($a.$k)" }
  }
}

if($changes.Count -gt 0){
  Add-Content -Encoding UTF8 -Path $logPath -Value "$now ALERT git-integrity-watch :: $($changes -join ' | ')"
  exit 2
}

exit 0
