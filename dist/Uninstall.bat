@echo off

:: Check if the script is running as administrator
net session >nul 2>&1
if %errorLevel% == 0 (
echo Running as administrator
) else (
echo Requesting administrative privileges...
goto UACPrompt
)

:: Delete falcon2xlsx.exe and favicon.ico from C:
del C:\falcon2xlsx.exe
del C:\favicon.ico

:: Remove registry keys
reg delete HKCU\SOFTWARE\Classes*\shell\falcon2xlsx /f
reg delete HKCU\SOFTWARE\Classes\Directory\shell\falcon2xlsx /f

echo Successfully uninstalled falcon2xlsx
pause
exit

:UACPrompt
echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
echo UAC.ShellExecute "%~s0", "", "", "runas", 1 >> "%temp%\getadmin.vbs"
"%temp%\getadmin.vbs"
exit