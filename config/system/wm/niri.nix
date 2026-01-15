{ config, pkgs, inputs, lib, ... }:

# Enable niri (scrolling window manager)

{

  programs.niri.enable = true;

  # https://github.com/YaLTeR/niri/wiki/Important-Software
  environment.systemPackages = with pkgs; [
    # alacritty already enabled & tweaked in system/base/base.nix
    fuzzel
    gnome-keyring
    kdePackages.polkit-kde-agent-1
    mako
    xdg-desktop-portal-gnome
    xdg-desktop-portal-gtk
    xwayland-satellite
  ];

}
