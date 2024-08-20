$ErrorActionPreference = "Stop"

$mitamae_version = "1.14.1"
$mitamae_windows_sha256 = "e6ff000fcd56d01b4e6367200b23429f4972c917f086a960b8babebec4568e4d"

$mitamae_cache = "mitamae-${mitamae_version}"
if (-not (Test-Path "bin\$mitamae_cache")) {
  $mitamae_bin = "mitamae-x86_64-windows"
  $mitamae_sha256 = $mitamae_windows_sha256

  $webClient = New-Object System.Net.WebClient
  $url = "https://github.com/itamae-kitchen/mitamae/releases/download/v${mitamae_version}/${mitamae_bin}.zip" 
  Write-Output "url to download: $url"
  $webClient.DownloadFile($url, "bin\$mitamae_bin.zip")
  

  $sha256 = Get-FileHash -Algorithm SHA256 -Path "bin\$mitamae_bin.zip" | Select-Object -ExpandProperty Hash
  if ($mitamae_sha256 -ne $sha256) {
    Write-Output "checksum verification failed!`nexpected: $mitamae_sha256`n  actual: $sha256"
    Exit
  }
  Expand-Archive -Path "bin\$mitamae_bin.zip" -DestinationPath "bin"

  Remove-Item "bin\$mitamae_bin.zip"
  Move-Item "$mitamae_bin" "bin\$mitamae_cache.exe"
}

New-Item -ItemType SymbolicLink -Target "bin\$mitamae_cache.exe" -Path "bin\mitamae.exe"
