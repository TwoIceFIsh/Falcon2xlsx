@echo off

:: Check if the script is running as administrator
net session >nul 2>&1
if %errorLevel% == 0 (
    echo Running as administrator
) else (
    echo Requesting administrative privileges...
    goto UACPrompt
)

:: Set script directory
set SCRIPT_DIR=%~dp0

:: Copy csconverter.exe and favicon.ico to C:\
copy "%SCRIPT_DIR%falcon2xlsx.exe" C:\
copy "%SCRIPT_DIR%favicon.ico" C:\

:: Add registry key with icon
reg add HKCU\SOFTWARE\Classes\*\shell\falcon2xlsx /ve /t REG_SZ /d "falcon2xlsx" /f
reg add HKCU\SOFTWARE\Classes\*\shell\falcon2xlsx /v Icon /t REG_SZ /d "C:\favicon.ico" /f
reg add HKCU\SOFTWARE\Classes\*\shell\falcon2xlsx\command /ve /t REG_EXPAND_SZ /d "\"C:\falcon2xlsx.exe\" \"%%1\"" /f
reg add HKCU\SOFTWARE\Classes\Directory\shell\falcon2xlsx /ve /t REG_SZ /d "falcon2xlsx" /f
reg add HKCU\SOFTWARE\Classes\Directory\shell\falcon2xlsx /v Icon /t REG_SZ /d "C:\favicon.ico" /f
reg add HKCU\SOFTWARE\Classes\Directory\shell\falcon2xlsx\command /ve /t REG_EXPAND_SZ /d "\"C:\falcon2xlsx.exe\" \"%%1\"" /f

echo Successfully installed falcon2xlsx
pause
exit

:UACPrompt
echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
echo UAC.ShellExecute "%~s0", "", "", "runas", 1 >> "%temp%\getadmin.vbs"
"%temp%\getadmin.vbs"
exit
