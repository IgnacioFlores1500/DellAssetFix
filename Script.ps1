$var = Get-Content .\output.txt -Raw

$value = @{Description = $var}
Set-CimInstance -Query 'Select * From Win32_OperatingSystem' -Property $value