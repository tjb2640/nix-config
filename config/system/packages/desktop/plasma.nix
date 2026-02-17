{ pkgs, ... }:

# Enables KDE Plasma 6 as the desktop environment
# https://wiki.nixos.org/wiki/KDE

{

  nixpkgs.overlays = [
    # My panel and colour scheme
    (final: prev: rec {
      plasma-theme-claremont = final.callPackage ../../../overlays/system/plasma-theme-claremont/desktoptheme/default.nix {};
    })
    # Window decorations (aurorae)
    (final: prev: rec {
      aurorae-theme-claremont = final.callPackage ../../../overlays/system/plasma-theme-claremont/aurorae/default.nix {};
    })
  ];

  # Using SDDM and Plasma 6
  services.desktopManager.plasma6.enable = true;
  services.displayManager.sddm = {
    enable = true;
    settings.General.DisplayServer = "wayland";
    wayland.enable = true;
  };

  users.users.ty.packages = with pkgs; [
    aurorae-theme-claremont
    kdePackages.kate
    kdePackages.kcalc
    kdePackages.kdenlive
    kdePackages.kmail
    kdePackages.kmail-account-wizard
    kdePackages.powerdevil
    kdePackages.qtstyleplugin-kvantum
    ocs-url # for installing plasma extensions from firefox
    plasma-theme-claremont
    tela-icon-theme
  ];

  # needs dbus
  programs.partition-manager.enable = true;

}
