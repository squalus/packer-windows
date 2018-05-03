$ErrorActionPreference = "Stop"
$version = "1805"
$sha256 = "898c1ca0015183fe2ba7d55cacf0a1dea35e873bf3f8090f362a6288c6ef08d7"

$filename = "7z$version-x64.msi"
$downloadFolder = "$home\Downloads"
$zipInstallerFile = "$downloadFolder\$filename"
$url = "https://www.7-zip.org/a/$filename"

Write-Host "Downloading $url"
Invoke-WebRequest -Uri $url -OutFile $zipInstallerFile

Write-Host "Checking hash"
$hash = Get-FileHash $zipInstallerFile -Algorithm SHA256
if ($hash.Hash -eq $sha256) {
    Write-Host "Hash matches"
} else {
    Write-Host "Hash mismatch"
    [Environment]::Exit(1)
}

Write-Host "Installing $zipInstallerFile"
msiexec /i $zipInstallerFile /passive
