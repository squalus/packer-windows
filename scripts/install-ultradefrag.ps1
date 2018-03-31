$ErrorActionPreference = "Stop"

$version = "7.0.2"
$sha256 = "a5d45f9b60f737fe20b4843685b11c190ccd94a091588f8ca38877ad264c1622"

$AllProtocols = [System.Net.SecurityProtocolType]'Ssl3,Tls,Tls11,Tls12'
[System.Net.ServicePointManager]::SecurityProtocol = $AllProtocols

$filename = "ultradefrag-portable-$version.bin.amd64.zip"
$url = "https://downloads.sourceforge.net/project/ultradefrag/stable-release/$version/$filename"

$downloadFolder = "$home\Downloads"

$zipFile = "$downloadFolder\$filename"

Write-Output "Downloading $url -> $zipFile"
Invoke-WebRequest -Uri $url -OutFile $zipFile -UserAgent [Microsoft.PowerShell.Commands.PSUserAgent]::InternetExplorer

Write-Output "Checking hash"
$hash = Get-FileHash $zipFile -Algorithm SHA256
Write-Output $hash
if ($hash.Hash -eq $sha256) {
    Write-Output "Hash matches"
} else {
    Write-Output "Hash mismatch"
    [Environment]::Exit(1)
}

Write-Output "Unzipping $filename"
$sevenzFile = "C:\Program Files\7-zip\7z.exe"
$outDir = "C:\ultradefrag"
Remove-Item $outDir -Recurse -ErrorAction Ignore
Start-Process $sevenzFile -NoNewWindow -Wait -ArgumentList "x","$zipFile","-o$outDir","-y"

$folderName = "ultradefrag-portable-$version.amd64"
$innerDir = "$outDir\$folderName"

$dirs = dir $innerDir
foreach ($item in $dirs) {
    $p = Join-Path $innerDir $item
	Move -Path $p -Destination $outDir
}

Remove-Item $innerDir
Remove-Item $zipFile
