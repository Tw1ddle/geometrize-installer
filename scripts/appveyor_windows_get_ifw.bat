setlocal

@echo Making temporary tools directory
mkdir ifw

@echo Download Qt Installer Framework for Windows
curl -L -O https://download.qt.io/official_releases/qt-installer-framework/4.1.1/QtInstallerFramework-windows-x86-4.1.1.exe

@echo Unpack the installer framework
7z x QtInstallerFramework-windows-x86-4.1.1.exe -oifw -aoa