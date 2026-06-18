@echo off
setlocal
set "JAVA_HOME=C:\Program Files\Java\jdk-25.0.2"
set "PATH=%JAVA_HOME%\bin;D:\flutter_windows_3.41.1-stable\flutter\bin;%PATH%"
cd /d %~dp0
echo JAVA_HOME=%JAVA_HOME%
flutter build apk --release
if %ERRORLEVEL% EQU 0 (
  echo.
  echo APK ready: build\app\outputs\flutter-apk\app-release.apk
)
endlocal
