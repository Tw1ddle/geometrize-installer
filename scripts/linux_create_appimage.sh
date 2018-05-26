#!/bin/bash

echo Will create AppImage

# Download linuxdeployqt
wget -c "https://github.com/probonopd/linuxdeployqt/releases/download/continuous/linuxdeployqt-continuous-x86_64.AppImage" -O linuxdeployqt
chmod a+x linuxdeployqt

unset QTDIR; unset QT_PLUGIN_PATH; unset LD_LIBRARY_PATH

# Create the AppImage
cp Geometrize appdir/geometrize
./linuxdeployqt appdir/geometrize -bundle-non-qt-libs -verbose=2

# Also ship the libstdc++ library with the AppImage
# Assumes we're building this with gcc-8 and with a particular version of libstdc++
cp /usr/lib/x86_64-linux-gnu/libstdc++.so.6.0.25 appdir/lib/libstdc++.so.6

./linuxdeployqt appdir/geometrize -appimage

# Move it ready for CI deployment stage to pick it up
mv Geometrize-x86_64.AppImage Geometrize.AppImage