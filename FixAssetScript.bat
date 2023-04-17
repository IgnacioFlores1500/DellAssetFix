@echo off
echo Make sure to run as Adminstrator!
set scriptLocationPath=%~dp0
set debugLogMode=true
setlocal EnableDelayedExpansion
set buildFinaloutput

:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
rem Find the Dell and Serial Tag from the BIOS
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
cd C:\Program Files (x86)\Dell\Command Configure\X86_64
cctk.exe --asset > asset.txt
move .\asset.txt %scriptLocationPath%
echo AssetFile has been moved
echo Finding Serial Tag...
cd %scriptLocationPath%



:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
rem Find Serial Tag and convert the txt file to UTF8
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
wmic bios get serialnumber > serialNumber.txt
powershell -Command "Get-Content serialNumber.txt -Encoding Unicode | Out-File -Encoding UTF8 serialNumber2.txt"



:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
rem Set AssetFile, SerialTagFile, and outputFile
rem NOTE: serialNumber2 is the UTF8 encoded
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
set "assetFile=asset.txt"
set "serialFile=serialNumber2.txt"
set "FinalResultFile=output.txt"

:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
rem Check all the files
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
if not exist "%assetFile%" (
  echo The asset file does not exist.
  exit /b 1
)

if not exist "%serialFile%" (
  echo The serial file does not exist.
  exit /b 1
)

if not exist "%FinalResultFile%" (
  echo The output file does not exist.
  exit /b 1
)


:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
rem Output the Asset to the output.txt
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
(for /f "usebackq delims=" %%a in ("%assetFile%") do (
  set "string=%%a"
  set "string=!string:~-5!"
  ::echo !string!
  set "buildFinaloutput=!string!"
  echo !string!
 
)) > %FinalResultFile%


:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
rem Make a clean Serial Tag that removes the serialTextFrom the cmd
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
(for /f "usebackq skip=1 delims=" %%a in ("%serialFile%") do echo %%a) > cleanSerial.txt
echo Made a cleanSerial.txt
set "cleanSerial=cleanSerial.txt"



:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
rem append the Serial Number to the output.txt
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
FOR /F "tokens=*" %%i IN (%cleanSerial%) DO (
	REM set "string=%%i"
	REM set "string=!string:~-7!"
	REM echo !string!
	echo %%i
	
) >> %FinalResultFile%








:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
rem This cleans up the txt files. Note: If you enable debugging, this allows you to see the txt files made to give you the output
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

if %debugLogMode%=="true" (
	call :cleanup
) else ( 
	call :end
)

echo "TEST"

:cleanup
del asset.txt
del cleanSerial.txt
del serialNumber.txt
del serialNumber2.txt
EXIT /B 0

:end
EXIT /B 