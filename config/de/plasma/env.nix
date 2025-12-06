{ config, pkgs, inputs, lib, ... }:

# Enables KDE Plasma 6 as the desktop environment
# https://wiki.nixos.org/wiki/KDE

{

  nixpkgs.overlays = [
    # My panel and colour scheme
    (final: prev: rec {
      plasma-theme-claremont = final.callPackage ../../../overlays/system/plasmatheme/claremont/default.nix {};
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
    plasma-theme-claremont
    kdePackages.kate
    kdePackages.kcalc
    kdePackages.kdenlive
    kdePackages.kmail
    kdePackages.ksudoku
    kdePackages.powerdevil
    kdePackages.qtstyleplugin-kvantum
    kdePackages.tokodon # mastodon client
    ocs-url # for installing plasma extensions from firefox
  ];

  # needs dbus
  programs.partition-manager.enable = true;

}
