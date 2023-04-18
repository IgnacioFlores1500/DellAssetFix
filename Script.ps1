(Get-Content 'input.txt') -join '  |  ' | Set-Content 'output.txt'

$var = Get-Content .\output.txt -Raw

$value = @{Description = $var}
Set-CimInstance -Query 'Select * From Win32_OperatingSystem' -Property $value

# https://www.nextofwindows.com/how-to-change-operating-system-description-on-local-and-remote-computers
