# Run the regular Geometrize build
include(geometrize/geometrize.pro)

# Gather dependencies for deploying Geometrize in an installer
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
    error(Failed to identify a deployment command, is this platform supported?)
}

CONFIG(debug, debug|release) {
    DEPLOY_TARGET = $$shell_quote($$shell_path($${OUT_PWD}/debug/$${TARGET}$${TARGET_CUSTOM_EXT})) # debug
} else {
    DEPLOY_TARGET = $$shell_quote($$shell_path($${OUT_PWD}/release/$${TARGET}$${TARGET_CUSTOM_EXT})) # release
}

QMAKE_POST_LINK = $${DEPLOY_COMMAND} $${DEPLOY_TARGET}
