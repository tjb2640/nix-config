{ config, pkgs, inputs, lib, ... }:

# Enables KDE Plasma 6 as the desktop environment
# https://wiki.nixos.org/wiki/KDE

{

  # Using SDDM and Plasma 6
  services.desktopManager.plasma6.enable = true;
  services.displayManager.sddm = {
    enable = true;
    settings.General.DisplayServer = "wayland";
    wayland.enable = true;
  };

  users.users.ty.packages = with pkgs; [
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
