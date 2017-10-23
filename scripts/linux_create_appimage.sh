#!/bin/bash

echo Will create AppImage

# Download linuxdeployqt
wget -c "https://github.com/probonopd/linuxdeployqt/releases/download/continuous/linuxdeployqt-continuous-x86_64.AppImage" -O linuxdeployqt
chmod a+x linuxdeployqt

unset QTDIR; unset QT_PLUGIN_PATH; unset LD_LIBRARY_PATH

# TODO copy svg plugin dll?

# Create the AppImage
mkdir -p appimage
yes | cp Geometrize appimage/geometrize
./linuxdeployqt appimage/geometrize -bundle-non-qt-libs -verbose=2
./linuxdeployqt appimage/geometrize -appimage

mv appimage/Application-x86_64.AppImage appimage/Geometrize.AppImage