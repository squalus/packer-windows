$ErrorActionPreference = "Stop"

$filename = "SDelete.zip"
$url = "https://download.sysinternals.com/files/SDelete.zip"
$sha256 = "e78fe7d61b760118529858351c20e2814d5ca8a0c16e7c65fd180fd12f431824"

$downloadFolder = "$home\Downloads"

$zipFile = "$downloadFolder\$filename"

Write-Output "Downloading $url -> $zipFile"
Invoke-WebRequest -Uri $url -OutFile $zipFile

Write-Output "Checking hash"
$hash = Get-FileHash $zipFile -Algorithm SHA256
if ($hash.Hash -eq $sha256) {
    Write-Output "Hash matches"
} else {
    Write-Output "Hash mismatch"
    [Environment]::Exit(1)
}

Write-Output "Unzipping $filename"
$sevenzFile = "C:\Program Files\7-zip\7z.exe"
$outDir = "C:\sdelete"
Remove-Item $outDir -Recurse -ErrorAction Ignore
Start-Process $sevenzFile -NoNewWindow -Wait -ArgumentList "x","$zipFile","-o$outDir","-y"

Remove-Item $zipFile

Start-Process "$env:SystemRoot\System32\reg.exe" -NoNewWindow -Wait -ArgumentList "ADD","HKCU\Software\Sysinternals\SDelete","/v","EulaAccepted","/t","REG_DWORD","/d","1","/f"
