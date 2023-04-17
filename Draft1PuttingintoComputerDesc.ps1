$RemotePC = Read-Host -Prompt 'Input the remote computer name e.g. PC0123'
$RemoteDescription = Read-Host -Prompt 'Input the new description for the remote computer'

$PC = Get-WmiObject -class Win32_OperatingSystem -computername $RemotePC
$PC.Description = $RemoteDescription

$PC.Put()