{ config, pkgs, inputs, lib, ... }:

# home-manager config for desktop machines. Mostly graphical applications

{
  
  imports = [
    ../../extras/zenbrowser.nix
  ];

  # link a face icon for desktop environments
  home.file.".face.icon".source = ../../../../resource/images/avatar.png;

  # adjust some environment variables
  # QT_QPA_PLATFORMTHEME as a stopgap to enable dark mode via qt6ct
  home.sessionVariables = {
    EDITOR = "hx";
    QT_QPA_PLATFORMTHEME = "qt6ct";
  };
}
