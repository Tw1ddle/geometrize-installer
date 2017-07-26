# Run the regular Geometrize build
include(geometrize/geometrize.pro)

# Gather dependencies for deploying Geometrize
win32 {
    DEPLOY_COMMAND = windeployqt
}
macx {
    DEPLOY_COMMAND = macdeployqt
}
linux {
    DEPLOY_COMMAND = linuxdeployqt # TODO see: https://github.com/probonopd/linuxdeployqt
}

isEmpty(TARGET_EXT) {
    win32 {
        TARGET_CUSTOM_EXT = .exe
    }
    macx {
        TARGET_CUSTOM_EXT = .app
    }
} else {
    TARGET_CUSTOM_EXT = $${TARGET_EXT}
}

isEmpty(DEPLOY_COMMAND){
    error(Failed to identify a deployment command - is this platform supported?)
}

CONFIG(debug, debug|release) {
    DEPLOY_TARGET = $$shell_quote($$shell_path($${OUT_PWD}/debug/$${TARGET}$${TARGET_CUSTOM_EXT}))
} else {
    DEPLOY_TARGET = $$shell_quote($$shell_path($${OUT_PWD}/release/$${TARGET}$${TARGET_CUSTOM_EXT}))
}

# Create the Geometrize installer package
win32 {
    IFW_LOCATION = $$(QTDIR)/../../../QtIFW2.0.5/bin/
    BINARYCREATOR_NAME = binarycreator.exe
    INSTALLERBASE_NAME = installerbase.exe
}
macx {
    IFW_LOCATION = $$(QTDIR)/../../../QtIFW2.0.5/bin/ # TODO
    BINARYCREATOR_NAME = binarycreator
    INSTALLERBASE_NAME = installerbase
}
linux {
    IFW_LOCATION = $$(QTDIR)/../../../QtIFW2.0.5/bin/ # TODO
    BINARYCREATOR_NAME = binarycreator
    INSTALLERBASE_NAME = installerbase
}

isEmpty(IFW_LOCATION) {
    error(Failed to identity the installer binary creator command - is this platform supported?)
}

INSTALLER_NAME = geometrize_installer.exe
INSTALLER_GENERATION_COMMAND = $$shell_quote($$shell_path($${IFW_LOCATION}$${BINARYCREATOR_NAME})) --offline-only --template $$shell_quote($$shell_path($${IFW_LOCATION}$${INSTALLERBASE_NAME})) --packages $$shell_quote($$shell_path($${_PRO_FILE_PWD_}/installer/packages)) --config $$shell_quote($$shell_path($${_PRO_FILE_PWD_}/installer/config/config.xml)) --verbose $${INSTALLER_NAME}

# Execute the deploy, installer binary generation commands (& is to concatenate the commands)
QMAKE_POST_LINK = $${DEPLOY_COMMAND} $${DEPLOY_TARGET} &
QMAKE_POST_LINK += $${INSTALLER_GENERATION_COMMAND}
