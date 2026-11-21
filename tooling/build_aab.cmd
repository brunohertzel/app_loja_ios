@echo off
powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%~dp0build_aab.ps1" %*
exit /b %errorlevel%
