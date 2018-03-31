$ErrorActionPreference = "Stop"
$version = "1801"
$sha256 = "b23f97c230a921f834550d2bf467d313952861f641f49ca93ccddd9d2e0300e2"

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
