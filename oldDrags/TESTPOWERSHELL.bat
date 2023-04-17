@echo off
setlocal EnableDelayedExpansion
set remotePC=IT-IFLORES-PC
set filethingy=Get-WmiObject -class Win32_OperatingSystem -computername !remotePC!
set remoteDesc="TST"

::powershell "$RemotePC = Read-Host -Prompt 'Input the remote computer name e.g. PC0123'"

::powershell "$RemoteDescription = Read-Host -Prompt 'Input the new description for the remote computer'"
::powershell "$PC = Get-WmiObject -class Win32_OperatingSystem -computername !remotePC!"
powershell $PC = !filethingy!
powershell $PC.Description = Read-Host 
powershell $PC.Put()

pause