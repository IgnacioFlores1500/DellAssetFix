@echo off
echo Make sure to run as Adminstrator!
set scriptLocationPath=%~dp0
set debugLogMode=false
setlocal EnableDelayedExpansion

:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
rem Find the Dell and Serial Tag from the BIOS
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

cd %scriptLocationPath%

:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
rem Get SerialNumber and AssetTag from bios
rem https://stackoverflow.com/questions/18115603/i-need-a-windows-command-line-script-that-takes-an-output-edits-it-and-creates
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

for /f "delims=" %%a in ('wmic SYSTEMENCLOSURE get SerialNumber') do for /f %%b in ("%%a") do set "SerialNumber=%%b"
FOR /F "TOKENS=1,* DELIMS==" %%v IN ('WMIC SYSTEMENCLOSURE GET SMBiosAssetTag /FORMAT:VALUE') DO IF /I "%%v" == "SMBIOSAssetTag" SET SMBIOSAssetTag=%%w
::FOR /F "TOKENS=1,* DELIMS==" %%v IN ('WMIC SYSTEMENCLOSURE GET SerialNumber /FORMAT:VALUE') DO IF /I "%%v" == "SerialNumber" SET SerialNumber=%%w	

:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
rem Output the proper format in an output.txt 
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
set "spaces= | " 
(
	echo %SMBIOSAssetTag%
	echo  !spaces! 
	echo %SerialNumber%
	echo  !spaces!
	echo %date%
	echo  !spaces! 
	echo %time%
) >> output.txt

:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
rem powershell to start the script
rem https://stackoverflow.com/questions/19335004/how-to-run-a-powershell-script-from-a-batch-file
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
PowerShell -NoProfile -ExecutionPolicy Bypass -Command "& {Start-Process PowerShell -ArgumentList '-NoProfile -ExecutionPolicy Bypass -File "".\Script.ps1""' -Verb RunAs}"

TIMEOUT /T 5

:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
rem deleted output.txt
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

if %debugLogMode%=="true" (
	call :cleanup
	call :end
) else ( 
	call :end
)

echo "TEST"

:cleanup
del output.txt
EXIT /B 0

:end
EXIT /B 