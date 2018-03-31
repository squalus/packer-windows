move /Y C:\Users\vagrant\VBoxGuestAdditions.iso C:\Windows\Temp
cmd /c ""C:\Program Files\7-Zip\7z.exe" x C:\Windows\Temp\VBoxGuestAdditions.iso -oC:\Windows\Temp\virtualbox"
cmd /c for %%i in (C:\Windows\Temp\virtualbox\cert\vbox*.cer) do C:\Windows\Temp\virtualbox\cert\VBoxCertUtil add-trusted-publisher %%i --root %%i
cmd /c C:\Windows\Temp\virtualbox\VBoxWindowsAdditions.exe /S
