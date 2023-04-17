@echo off
echo Make sure to run as Adminstrator!
set scriptLocationPath=%~dp0
setlocal EnableDelayedExpansion

set buildFinaloutput


::echo %scriptLocationPath%
cd C:\Program Files (x86)\Dell\Command Configure\X86_64
cctk.exe --asset > asset.txt
move .\asset.txt %scriptLocationPath%
echo AssetFile has been moved
::echo Sleeping for 3 seconds...
echo Finding Serial Tag...
::TIMEOUT /T 1
cd %scriptLocationPath%
wmic bios get serialnumber > serialNumber.txt
powershell -Command "Get-Content serialNumber.txt -Encoding Unicode | Out-File -Encoding UTF8 serialNumber2.txt"
::SET new vars
set "assetFile=asset.txt"
set "serialFile=serialNumber2.txt"
set "FinalResult=output.txt"
::type NUL > cleanSerialNumber.txt
::set "cleanoutputFile=cleanSerialNumber.txt"

::echo. 2>cleanSerialNumber.txt

if not exist "%assetFile%" (
  echo The input file does not exist.
  exit /b 1
)

(for /f "usebackq delims=" %%a in ("%assetFile%") do (
  set "string=%%a"
  set "string=!string:~-5!"
  ::echo !string!
  set "buildFinaloutput=!string!"
  echo !string!
 
)) > %FinalResult%

::echo %buildFinaloutput% >> %FinalResult% ## 70210 ouputs assettag

if not exist "%serialFile%" (
  echo The serialNumber file does not exist.
  pause
  exit /b 1
)

REM if not exist "%cleanoutputFile%" (
  REM echo The cleanSerialNumber file does not exist.
  REM pause
  REM exit /b 1
REM )
::echo BLING
::echo TES2T >> %FinalResult%
::echo %cd%



REM for /f "usebackq delims=" %%a in ("%serialFile%") do (
    REM set "line=%%a"
    REM rem remove trailing spaces from the line
    REM for /l %%i in (1,1,100) do if "!line:~-1!"==" " set "line=!line:~0,-1!"
    REM echo !line!
REM ) > %cleanoutputFile%

(for /f "usebackq skip=1 delims=" %%a in ("%serialFile%") do echo %%a) > cleanSerial.txt
pause


FOR /F "tokens=*" %%i IN (%serialFile%) DO (
	set "string=%%i"
	set "string=!string:~-7!"
	echo !string!
	
) >> %FinalResult%



REM (for /f "delims=" %%a in ('type "%FinalResult%"') do (
    REM set "line=%%a"
    REM set "line=!line: =!"
    REM echo !line!
REM )) > "%FinalResult%"