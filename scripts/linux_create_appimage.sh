#!/bin/bash

echo Will create AppImage

# Download linuxdeployqt
wget -c "https://github.com/probonopd/linuxdeployqt/releases/download/continuous/linuxdeployqt-continuous-x86_64.AppImage" -O linuxdeployqt
chmod a+x linuxdeployqt

unset QTDIR; unset QT_PLUGIN_PATH; unset LD_LIBRARY_PATH

yes | cp Geometrize appdir/geometrize

# Run linuxdeployqt
./linuxdeployqt appdir/geometrize -bundle-non-qt-libs -verbose=2

# Workaround so the AppImage runs on systems that ship old gcc (and so older libstdc++/libgcc)
# like Ubuntu 14.04 (see https://github.com/Tw1ddle/geometrize/issues/5)
mkdir -p appdir/optional/
mkdir -p appdir/optional/libstdc++/
cp /lib/x86_64-linux-gnu/libstdc++.so.6 ./appdir/optional/libstdc++/
mkdir -p appdir/optional/libgcc_s/
cp /lib/x86_64-linux-gnu/libgcc_s.so.1 ./appdir/optional/libgcc_s/
wget -c "https://github.com/darealshinji/AppImageKit-checkrt/releases/download/continuous/exec-x86_64.so" -O ./appdir/optional/exec.so

pushd appdir
rm AppRun
wget -c "https://github.com/darealshinji/AppImageKit-checkrt/releases/download/continuous/AppRun-patched-x86_64" -O AppRun
chmod a+x AppRun
popd

# Create the AppImage itself
./linuxdeployqt --appimage-extract
export PATH=$(readlink -f ./squashfs-root/usr/bin):$PATH
NAME=$(grep '^Name=.*' appdir/geometrize.desktop | cut -d "=" -f 2 | sed -e 's|\ |_|g')
./squashfs-root/usr/bin/appimagetool -g ./appdir/ Geometrize-x86_64.AppImage

ls -a

# Move it ready for CI deployment stage to pick it up
mv Geometrize-x86_64.AppImage Geometrize.AppImage