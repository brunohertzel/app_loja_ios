@echo off
setlocal
cd /d "%~dp0"
call tooling\build_android_release.cmd %*
if errorlevel 1 exit /b 1
exit /b 0
