@echo off
::SETLOCAL ENABLEDELAYEDEXPANSION

set scriptLocationPath=%~dp0
set txt=C:\Users\iflores9\Desktop\KaceAssetfix\serialNumber.txt
set serialFile=123
echo %scriptLocationPath%
echo %txt%
for /F "tokens=*" %%a in (%txt%) do (
	echo %%a
	
)
echo %txt%
pause