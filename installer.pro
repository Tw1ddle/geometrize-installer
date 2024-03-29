# This is the project file for the Geometrize desktop app installers.

# Ensure objects and mocs do not go in the destdir build folder
# This avoids the need to filter these out when packaging the installer later
OBJECTS_DIR = object_files # Intermediate object files directory
MOC_DIR = moc_files # Intermediate moc files directory
RCC_DIR = rcc_files # Intermediate rcc files directory
UI_DIR = ui_files # Intermediate ui files directory

# Perform the regular Geometrize build
include(geometrize/geometrize.pro)

# Create the Geometrize installer for Windows desktop
win32 {
    # Set this to your local Qt installer framework installation /bin directory
    IFW_LOCATION = $(QTDIR)/../../QtIFW-4.1.1/bin/

    CONFIG(debug, debug|release) {
        DEPLOY_TARGET_DIR = $$shell_path($${OUT_PWD}/debug)
    } else {
        DEPLOY_TARGET_DIR = $$shell_path($${OUT_PWD}/release)
    }

    INSTALLER_PACKAGE_DATA_DIR = $$shell_quote($$shell_path($${_PRO_FILE_PWD_}/installer/packages/com.samtwidale.geometrize/data))

    # Clean (delete and recreate) the installer package data folder
    exists($${INSTALLER_PACKAGE_DATA_DIR}) {
        CLEAN_PACKAGE_DATA_DIR = $${QMAKE_DEL_TREE} $${INSTALLER_PACKAGE_DATA_DIR} && $${QMAKE_MKDIR} $${INSTALLER_PACKAGE_DATA_DIR}
        QMAKE_POST_LINK = $${CLEAN_PACKAGE_DATA_DIR}
    } else {
        CLEAN_PACKAGE_DATA_DIR = $${QMAKE_MKDIR} $${INSTALLER_PACKAGE_DATA_DIR}
        QMAKE_POST_LINK = $${CLEAN_PACKAGE_DATA_DIR}
    }

    exists($${IFW_LOCATION}) {

    } else {
        IFW_LOCATION = $${PWD}/scripts/ifw/bin/
        exists($${IFW_LOCATION}) {
            message("Found a downloaded Qt installer framework, will assume this is AppVeyor CI...")
        } else {
            error("Could not locate the Qt installer framework, is it installed? If running locally, set your installer framework install location above")
        }
    }

    DEPLOY_EXECUTABLE_PATH = $$shell_quote($$shell_path($(QTDIR)/bin/windeployqt.exe))
    TARGET_CUSTOM_EXT = .exe
    DEPLOY_TARGET = $$shell_quote($$shell_path($${DEPLOY_TARGET_DIR}/$${TARGET}$${TARGET_CUSTOM_EXT}))
    QMAKE_POST_LINK += && $${DEPLOY_EXECUTABLE_PATH} $${DEPLOY_TARGET}

    # Copy the Geometrize resources to the installer package data folder
    COPY_TO_INSTALLER_PACKAGE = $${QMAKE_COPY_DIR} $$shell_quote($$shell_path($${DEPLOY_TARGET_DIR})) $${INSTALLER_PACKAGE_DATA_DIR}
    QMAKE_POST_LINK += && $${COPY_TO_INSTALLER_PACKAGE}

    BINARYCREATOR_NAME = binarycreator.exe
    INSTALLER_NAME = geometrize_installer.exe

    BINARYCREATOR_PATH = $$shell_quote($$shell_path($${IFW_LOCATION}$${BINARYCREATOR_NAME}))
    PACKAGES_DIR_PATH = $$shell_quote($$shell_path($${_PRO_FILE_PWD_}/installer/packages))
    INSTALLER_CONFIG_PATH = $$shell_quote($$shell_path($${_PRO_FILE_PWD_}/installer/config/config.xml))
    INSTALLER_GENERATION_COMMAND = $${BINARYCREATOR_PATH} --offline-only --packages $${PACKAGES_DIR_PATH} --config $${INSTALLER_CONFIG_PATH} --verbose $${INSTALLER_NAME}
    QMAKE_POST_LINK += && $${INSTALLER_GENERATION_COMMAND}
}

# Run macdeployqt to build a .dmg for Mac OSX
macx {
    DEPLOY_EXECUTABLE_PATH = macdeployqt
    TARGET_CUSTOM_EXT = .app
    DEPLOY_TARGET_DIR = $$shell_path($${OUT_PWD})
    DEPLOY_TARGET = $$shell_quote($$shell_path($${DEPLOY_TARGET_DIR}/$${TARGET}$${TARGET_CUSTOM_EXT}))
    DEPLOY_OPTIONS = -dmg
    QMAKE_POST_LINK = $${DEPLOY_EXECUTABLE_PATH} $${DEPLOY_TARGET} $${DEPLOY_OPTIONS}
}

# Hand off control to a script that fetches and runs Linuxdeployqt, creating an appimage in the "appimage" subfolder for Linux
linux {
    APPIMAGE_SCRIPT = $$shell_quote($$shell_path($${_PRO_FILE_PWD_}/scripts/linux_create_appimage.sh))
    QMAKE_POST_LINK = chmod u+x $${APPIMAGE_SCRIPT} && $${APPIMAGE_SCRIPT}
}
