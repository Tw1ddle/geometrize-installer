#!/bin/bash

# Download linuxdeployqt
wget -c "https://github.com/probonopd/linuxdeployqt/releases/download/continuous/linuxdeployqt-continuous-x86_64.AppImage" -O linuxdeployqt
chmod a+x linuxdeployqt

unset QTDIR; unset QT_PLUGIN_PATH; unset LD_LIBRARY_PATH

# TODO copy svg plugin dll?

# Create the AppImage
mkdir bundle
cp build-geometrize-GCC-Release/Geometrize bundle/geometrize
./linuxdeployqt bundle/geometrize -bundle-non-qt-libs -verbose=2
./linuxdeployqt bundle/geometrize -appimage