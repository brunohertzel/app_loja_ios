@echo off
setlocal
cd /d "%~dp0.."
powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%~dp0compile_android.ps1" -Artifact apk %*
exit /b %errorlevel%
