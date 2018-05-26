#!/bin/bash

echo Will create AppImage

# Download the AppImage runtime
wget -c "https://github.com/AppImage/AppImageKit/releases/download/continuous/runtime-x86_64" -O runtime
chmod a+x runtime

# Download linuxdeployqt
wget -c "https://github.com/probonopd/linuxdeployqt/releases/download/continuous/linuxdeployqt-continuous-x86_64.AppImage" -O linuxdeployqt
chmod a+x linuxdeployqt

unset QTDIR; unset QT_PLUGIN_PATH; unset LD_LIBRARY_PATH

# Run linuxdeployqt on the built executable
cp Geometrize appdir/geometrize
./linuxdeployqt appdir/geometrize -bundle-non-qt-libs -verbose=2

# Also ship the libstdc++ library with the AppImage
# Assumes we're building this with gcc-8 and with a particular version of libstdc++
ls -a /usr/lib/x86_64-linux-gnu/

mkdir -p appdir/usr/optional/
mkdir -p appdir/usr/optional/libstdc++/

cp /usr/lib/x86_64-linux-gnu/libgcc_s.so.1 ./appdir/usr/optional/libgcc_s/
cp /usr/lib/x86_64-linux-gnu/libstdc++.so.6.0.25 ./appdir/usr/optional/libstdc++/libstdc++.so.6
wget -c "https://github.com/darealshinji/AppImageKit-checkrt/releases/download/continuous/exec-x86_64.so" -O ./appdir/usr/optional/exec.so

# Get a patched-up version of AppRun that ensures that the latest libstdc++ library is used
# This should cover edge-cases like when the system libstdc++ is newer than the bundled one
pushd appdir
rm AppRun
wget -c "https://github.com/darealshinji/AppImageKit-checkrt/releases/download/continuous/AppRun-patched-x86_64" -O AppRun
chmod a+x AppRun
popd

# Create the AppImage
mksquashfs appdir geometrizesquashed -root-owned -noappend
cat runtime >> Geometrize.AppImage
cat geometrizesquashed >> Geometrize.AppImage