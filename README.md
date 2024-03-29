[![Geometrize Installer Logo](https://github.com/Tw1ddle/geometrize-installer/blob/master/screenshots/geometrize_installer_logo.png?raw=true "Geometrize installer logo")](https://www.geometrize.co.uk/)

[![License](https://img.shields.io/badge/License-GPL%20v3-blue.svg?style=flat-square)](https://github.com/Tw1ddle/geometrize-installer/blob/master/LICENSE)
[![Build Status Badge](https://ci.appveyor.com/api/projects/status/github/Tw1ddle/geometrize-installer)](https://ci.appveyor.com/project/Tw1ddle/geometrize-installer)

Development installers for [Geometrize](https://www.geometrize.co.uk/), an app for geometrizing images into geometric primitives.

[![Geometrized Borrowdale](https://github.com/Tw1ddle/geometrize-installer/blob/master/screenshots/borrowdale.png?raw=true "Geometrized Borrowdale in Autumn, 350 rotated ellipses")](https://www.geometrize.co.uk/)

## Building

To build an installer locally:

 * Follow the setup steps in the main Geometrize [README.md](https://github.com/Tw1ddle/geometrize/blob/master/README.md) until you can build and run the program.
 * Checkout this installer repository and all submodules and open [installer.pro](https://github.com/Tw1ddle/geometrize-installer/blob/master/installer.pro) within Qt Creator.
 * *On Windows* - download and install the Qt Installer Framework (IFW), then set IFW_LOCATION in [installer.pro](https://github.com/Tw1ddle/geometrize-installer/blob/master/installer.pro) and run it. The installer will be output to the build folder and is named *geometrize_installer.exe*.

## Notes
 * Got an idea or suggestion? Open an issue on GitHub, or send Sam a message on [Twitter](https://twitter.com/Sam_Twidale).
