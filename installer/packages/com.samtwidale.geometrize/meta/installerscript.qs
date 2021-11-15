function Component()
{
    installer.installationFinished.connect(this, Component.prototype.installationFinishedPageIsShown);
    installer.finishButtonClicked.connect(this, Component.prototype.installationFinished);

    gui.pageWidgetByObjectName("LicenseAgreementPage").entered.connect(changeLicenseLabels);
}

changeLicenseLabels = function()
{
    page = gui.pageWidgetByObjectName("LicenseAgreementPage");
    page.AcceptLicenseLabel.setText("I accept the license.");
    //page.RejectLicenseLabel.setText("I do not accept the license."); // Seems to be no longer shown since newer IFW 3.x?
    page.AcceptLicenseCheckBox.setChecked(true)
}

Component.prototype.createOperations = function()
{
    try {
        // Call the base create operations function
        component.createOperations();

        if (installer.value("os") == "win") { 
            try {
                var userProfile = installer.environmentVariable("USERPROFILE");
                installer.setValue("UserProfile", userProfile);
                component.addOperation("CreateShortcut", "@TargetDir@\\Geometrize.exe", "@UserProfile@\\Desktop\\Geometrize.lnk");
                component.addOperation("CreateShortcut", "@TargetDir@\\Geometrize.exe", "@StartMenuDir@\\Geometrize.lnk", "workingDirectory=@TargetDir@");
                component.addOperation("CreateShortcut", "@TargetDir@\\Licenses\\LICENSE", "@StartMenuDir@\\LICENSE.lnk", "workingDirectory=@TargetDir@\\Licenses");
            } catch (e) {
                // Key doesn't exist
            }
        }
    } catch (e) {
        print(e);
    }
}

Component.prototype.installationFinishedPageIsShown = function()
{
    try {
        if (installer.isInstaller() && installer.status == QInstaller.Success) {
            installer.addWizardPageItem(component, "LaunchAppCheckBoxForm", QInstaller.InstallationFinished);
        }
    } catch(e) {
        print(e);
    }
}

Component.prototype.installationFinished = function()
{
    try {
        var targetDir = installer.value("TargetDir");
        if (installer.isInstaller() && installer.status == QInstaller.Success) {
            var isLaunchCheckboxChecked = component.userInterface("LaunchAppCheckBoxForm").launchAppCheckBox.checked;
            
            if(isLaunchCheckboxChecked) {
                installer.executeDetached(targetDir + "/Geometrize.exe");
            }
        }
    } catch(e) {
         print(e);
    }
}