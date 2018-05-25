#!/bin/bash

echo Will create AppImage

# Download linuxdeployqt
wget -c "https://github.com/probonopd/linuxdeployqt/releases/download/continuous/linuxdeployqt-continuous-x86_64.AppImage" -O linuxdeployqt
chmod a+x linuxdeployqt

unset QTDIR; unset QT_PLUGIN_PATH; unset LD_LIBRARY_PATH

yes | cp Geometrize appimage/geometrize

# Run linuxdeployqt
./linuxdeployqt appimage/geometrize -bundle-non-qt-libs -verbose=2

# Workaround so the AppImage runs on systems that ship old libstdc++ like Ubuntu 14.04 (https://github.com/Tw1ddle/geometrize/issues/5)
mkdir -p appimage/usr/optional/
wget -c "https://github.com/darealshinji/AppImageKit-checkrt/releases/download/continuous/exec-x86_64.so" -O ./appimage/usr/optional/exec.so
mkdir -p appimage/usr/optional/libstdc++/
cp /usr/lib/x86_64-linux-gnu/libstdc++.so.6 ./appimage/usr/optional/libstdc++/
pushd appimage
rm AppRun
wget -c "https://github.com/darealshinji/AppImageKit-checkrt/releases/download/continuous/AppRun-patched-x86_64" -O AppRun
chmod a+x AppRun
popd

# Create the AppImage itself
./linuxdeployqt --appimage-extract
./squashfs-root/usr/bin/appimagetool -g ./appimage/ Geometrize-x86_64.AppImage

# Move it ready for CI deployment stage to pick it up
mv Geometrize-x86_64.AppImage Geometrize.AppImage

# Make it executable
chmod +x Geometrize.AppImage