# Windows defender off
Set-MpPreference -DisableRealtimeMonitoring $true
Set-MpPreference -SubmitSamplesConsent 2
Set-MpPreference -MAPSReporting 0

# Windows update off
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" -Name "NoAutoUpdate" -value 1

# Indexing off
function Disable-Indexing {
    Param($Drive)
    $obj = Get-WmiObject -Class Win32_Volume -Filter "DriveLetter='$Drive'"
    $indexing = $obj.IndexingEnabled
    if("$indexing" -eq $True){
        write-host "Disabling indexing of drive $Drive"
        $obj | Set-WmiInstance -Arguments @{IndexingEnabled=$False} | Out-Null
    }
}

Disable-Indexing "C:"

Start-Process "powercfg.exe" -NoNewWindow -Wait -ArgumentList "-change","-monitor-timeout-ac","0"
Start-Process "powercfg.exe" -NoNewWindow -Wait -ArgumentList "-change","-monitor-timeout-dc","0"
Start-Process "powercfg.exe" -NoNewWindow -Wait -ArgumentList "-change","-disk-timeout-ac","0"
Start-Process "powercfg.exe" -NoNewWindow -Wait -ArgumentList "-change","-disk-timeout-dc","0"
Start-Process "powercfg.exe" -NoNewWindow -Wait -ArgumentList "-change","-standby-timeout-ac","0"
Start-Process "powercfg.exe" -NoNewWindow -Wait -ArgumentList "-change","-standby-timeout-dc","0"
Start-Process "powercfg.exe" -NoNewWindow -Wait -ArgumentList "-change","-hibernate-timeout-ac","0"
Start-Process "powercfg.exe" -NoNewWindow -Wait -ArgumentList "-change","-hibernate-timeout-dc","0"
