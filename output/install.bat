@echo off

set SCRIPT_DIR=%~dp0

rem Copy csconverter.exe and favicon.ico to C:\
copy "%SCRIPT_DIR%csconverter.exe" C:\
copy "%SCRIPT_DIR%favicon.ico" C:\

rem Add registry key with icon
reg add HKCU\SOFTWARE\Classes\*\shell\CrowdStrikeConverter /ve /t REG_SZ /d "CrowdStrike Converter" /f
reg add HKCU\SOFTWARE\Classes\*\shell\CrowdStrikeConverter /v Icon /t REG_SZ /d "C:\favicon.ico" /f
reg add HKCU\SOFTWARE\Classes\*\shell\CrowdStrikeConverter\command /ve /t REG_EXPAND_SZ /d "\"C:\csconverter.exe\" \"%%1\"" /f
reg add HKCU\SOFTWARE\Classes\Directory\shell\CrowdStrikeConverter /ve /t REG_SZ /d "CrowdStrike Converter" /f
reg add HKCU\SOFTWARE\Classes\Directory\shell\CrowdStrikeConverter /v Icon /t REG_SZ /d "C:\favicon.ico" /f
reg add HKCU\SOFTWARE\Classes\Directory\shell\CrowdStrikeConverter\command /ve /t REG_EXPAND_SZ /d "\"C:\csconverter.exe\" \"%%1\"" /f

echo Successfully installed CrowdStrike Converter
pause
