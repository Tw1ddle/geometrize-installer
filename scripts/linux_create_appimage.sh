#!/bin/bash

echo Will create AppImage

# Download linuxdeployqt
wget -c "https://github.com/probonopd/linuxdeployqt/releases/download/continuous/linuxdeployqt-continuous-x86_64.AppImage" -O linuxdeployqt
chmod a+x linuxdeployqt

unset QTDIR; unset QT_PLUGIN_PATH; unset LD_LIBRARY_PATH

# Create the AppImage
yes | cp Geometrize appimage/geometrize
./linuxdeployqt appimage/geometrize -bundle-non-qt-libs -verbose=2
./linuxdeployqt appimage/geometrize -appimage

# Move it ready for CI deployment stage to pick it up
mv Geometrize-x86_64.AppImage Geometrize.AppImage

# Make it executable
chmod +x Geometrize.AppImage