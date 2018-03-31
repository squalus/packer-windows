net stop wuauserv
rmdir /S /Q C:\Windows\SoftwareDistribution\Download
mkdir C:\Windows\SoftwareDistribution\Download
cmd /c C:\ultradefrag\udefrag.exe --optimize --repeat C:
cmd /c C:\sdelete\sdelete64.exe -q -z C:
