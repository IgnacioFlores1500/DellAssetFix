@echo off
echo Make sure to run as Adminstrator!
rem This is the home where the script is
set scriptLocationPath=%~dp0 
setlocal EnableDelayedExpansion
::echo %scriptLocationPath%
SET assetText=99999
SET biosText=AAAAA

:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
rem Find the Dell Asset Tag and set it to assetText
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
cd C:\Program Files (x86)\Dell\Command Configure\X86_64
FOR /F "tokens=*" %%i IN ('cctk.exe --asset') do  set assetText=%%i
echo %assetText%
::pause


:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
rem Move back to script location and start Bios Serial Tag Getting
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
cd %scriptLocationPath%
FOR /F "usebackq tokens=*" %%i IN ('wmic bios get serialnumber /FORMAT:texttablewsys') do (
  set "tempString=%%i"
  echo %tempString%
  echo !tempString!
  echo %%i
  )
echo test
echo %biosText%

pause



::'""$computerBIOS = get-wmiobject Win32_BIOS""$SerialNumber = $computerBIOS.SerialNumber""write-host $SerialNumber""'








