@echo off
set "JAVA_HOME=C:\Program Files\Java\jdk-25.0.2"
set "PATH=D:\flutter_windows_3.41.1-stable\flutter\bin;%PATH%"
cd /d %~dp0
flutter build apk --release
echo APK: build\app\outputs\flutter-apk\app-release.apk
