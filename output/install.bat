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
copy "%SCRIPT_DIR%csconverter.exe" C:\
copy "%SCRIPT_DIR%favicon.ico" C:\

:: Add registry key with icon
reg add HKCU\SOFTWARE\Classes\*\shell\CrowdStrikeConverter /ve /t REG_SZ /d "CrowdStrike Converter" /f
reg add HKCU\SOFTWARE\Classes\*\shell\CrowdStrikeConverter /v Icon /t REG_SZ /d "C:\favicon.ico" /f
reg add HKCU\SOFTWARE\Classes\*\shell\CrowdStrikeConverter\command /ve /t REG_EXPAND_SZ /d "\"C:\csconverter.exe\" \"%%1\"" /f
reg add HKCU\SOFTWARE\Classes\Directory\shell\CrowdStrikeConverter /ve /t REG_SZ /d "CrowdStrike Converter" /f
reg add HKCU\SOFTWARE\Classes\Directory\shell\CrowdStrikeConverter /v Icon /t REG_SZ /d "C:\favicon.ico" /f
reg add HKCU\SOFTWARE\Classes\Directory\shell\CrowdStrikeConverter\command /ve /t REG_EXPAND_SZ /d "\"C:\csconverter.exe\" \"%%1\"" /f

echo Successfully installed CrowdStrike Converter
pause
exit

:UACPrompt
echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
echo UAC.ShellExecute "%~s0", "", "", "runas", 1 >> "%temp%\getadmin.vbs"
"%temp%\getadmin.vbs"
exit
