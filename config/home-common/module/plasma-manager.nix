{ config, pkgs, libs, ... }:

# Configure plasma-manager to declare the plasma 6 install

{
  programs.plasma = {
    enable = true;
    overrideConfig = true;

    session = {
      general = {
        askForConfirmationOnLogout = false;
      };
      sessionRestore = {
        restoreOpenApplicationsOnLogin = "startWithEmptySession";
      };
    };

    workspace = {
      lookAndFeel = "org.kde.breezedark.desktop";
    };
  };
}