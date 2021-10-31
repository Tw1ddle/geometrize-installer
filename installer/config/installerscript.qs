function Controller() {
    if (installer.isInstaller()) {
        installer.setDefaultPageVisible(QInstaller.StartMenuSelection, false);
		installer.setDefaultPageVisible(QInstaller.ComponentSelection, false);
    }
}

Controller.prototype.WelcomePageCallback = function() {
    gui.clickButton(buttons.NextButton);
}

Controller.prototype.ComponentSelectionPageCallback = function() {
    var widget = gui.currentPageWidget();
    widget.selectAll();
}

Controller.prototype.StartMenuDirectoryPageCallback = function() {
    gui.clickButton(buttons.NextButton);
}