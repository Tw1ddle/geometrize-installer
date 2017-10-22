#!/bin/bash

set -x

# Download linuxdeployqt
wget https://github.com/probonopd/linuxdeployqt/releases/download/1/linuxdeployqt-1-x86_64.AppImage -O linuxdeployqt
chmod +x linuxdeployqt

# Work around https://github.com/probonopd/linuxdeployqt/issues/28
sudo ln -s /usr/lib/x86_64-linux-gnu/qt5/plugins /usr/lib/plugins

# Create the AppImage
mkdir bundle
cp geometrize bundle/geometrize
./linuxdeployqt bundle/geometrize -appimage -bundle-non-qt-libs -verbose=2