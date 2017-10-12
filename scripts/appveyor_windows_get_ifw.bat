setlocal

@echo Making temporary tools directory
mkdir ifw

@echo Download Qt Installer Framework for Windows
curl -L -O https://download.qt.io/official_releases/qt-installer-framework/3.0.1/QtInstallerFramework-win-x86.exe

@echo Unpack the installer framework
7z x QtInstallerFramework-win-x86.exe -oifw -aoa