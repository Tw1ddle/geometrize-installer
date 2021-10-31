[![Geometrize Installer Logo](https://github.com/Tw1ddle/geometrize-installer/blob/master/screenshots/geometrize_installer_logo.png?raw=true "Geometrize installer logo")](https://www.geometrize.co.uk/)

[![License](https://img.shields.io/badge/License-GPL%20v3-blue.svg?style=flat-square)](https://github.com/Tw1ddle/geometrize-installer/blob/master/LICENSE)

Development installers for [Geometrize](https://www.geometrize.co.uk/), an app for geometrizing images into geometric primitives.

[![Geometrized Borrowdale](https://github.com/Tw1ddle/geometrize-installer/blob/master/screenshots/borrowdale.png?raw=true "Geometrized Borrowdale in Autumn, 350 rotated ellipses")](https://www.geometrize.co.uk/)

## Development Builds

These continuous integration snapshots are not official releases, and represent the latest untested, unstable code. Please consider getting a [stable release](https://www.geometrize.co.uk/) instead. Do not expect compatibility or consistency of features in or between these snapshots.

| Windows       | Status  | Bucket | Latest Build
| ------------- | ------- | ------ | ------------
| mingw x86     | [![Geometrize Windows mingw Installer Build Status](https://ci.appveyor.com/api/projects/status/lxexrj30ndqlruhd?svg=true)](https://ci.appveyor.com/project/Tw1ddle/geometrize-installer) | [S3 Bucket](https://s3.amazonaws.com/geometrize-installer-bucket/index.html?breadcrumb=windows%2Fmingw53_32%2F) | [Latest](https://s3.amazonaws.com/geometrize-installer-bucket/index.html?breadcrumb=windows%2Fmingw53_32%2F&dl_latest=true)
| msvc 2015 x86 | [![Geometrize Windows MSVC2015 x86 Installer Build Status](https://ci.appveyor.com/api/projects/status/lxexrj30ndqlruhd?svg=true)](https://ci.appveyor.com/project/Tw1ddle/geometrize-installer) | [S3 Bucket](https://s3.amazonaws.com/geometrize-installer-bucket/index.html?breadcrumb=windows%2Fmsvc2015%2F) | [Latest](https://s3.amazonaws.com/geometrize-installer-bucket/index.html?breadcrumb=windows%2Fmsvc2015%2F&dl_latest=true)
| msvc 2015 x64 | [![Geometrize Windows MSVC2015 x64 Installer Build Status](https://ci.appveyor.com/api/projects/status/lxexrj30ndqlruhd?svg=true)](https://ci.appveyor.com/project/Tw1ddle/geometrize-installer) | [S3 Bucket](https://s3.amazonaws.com/geometrize-installer-bucket/index.html?breadcrumb=windows%2Fmsvc2015_64%2F) | [Latest](https://s3.amazonaws.com/geometrize-installer-bucket/index.html?breadcrumb=windows%2Fmsvc2015_64%2F&dl_latest=true)

| Mac OSX       | Status  | Bucket | Latest Build
| ------------- | ------- | ------ | ------------
| clang x64     | [![Geometrize OSX Installer Build Status](https://img.shields.io/travis/Tw1ddle/geometrize-installer.svg?style=flat-square)](https://travis-ci.org/Tw1ddle/geometrize-installer) | [S3 Bucket](https://s3.amazonaws.com/geometrize-installer-bucket/index.html?breadcrumb=osx%2F) | [Latest](https://s3.amazonaws.com/geometrize-installer-bucket/index.html?breadcrumb=osx%2F&dl_latest=true)

| Linux         | Status  | Bucket | Latest Build
| ------------- | ------- | ------ | ------------
| g++ x64       | [![Geometrize Linux Installer Build Status](https://img.shields.io/travis/Tw1ddle/geometrize-installer.svg?style=flat-square)](https://travis-ci.org/Tw1ddle/geometrize-installer) | [S3 Bucket](https://s3.amazonaws.com/geometrize-installer-bucket/index.html?breadcrumb=linux%2F) | [Latest](https://s3.amazonaws.com/geometrize-installer-bucket/index.html?breadcrumb=linux%2F&dl_latest=true)

## Building

To build an installer locally:

 * Follow the setup steps in the main Geometrize [README.md](https://github.com/Tw1ddle/geometrize/blob/master/README.md).
 * Checkout this repository and all submodules and open [installer.pro](https://github.com/Tw1ddle/geometrize-installer/blob/master/installer.pro) within Qt Creator.
 * On *Windows* - download and install the Qt Installer Framework (IFW), then set IFW_LOCATION in [installer.pro](https://github.com/Tw1ddle/geometrize-installer/blob/master/installer.pro).

## Notes
 * Got an idea or suggestion? Open an issue on GitHub, or send Sam a message on [Twitter](https://twitter.com/Sam_Twidale).