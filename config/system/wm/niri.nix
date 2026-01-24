{ config, pkgs, inputs, lib, ... }:

# Enable niri (scrolling wayland compositor)
# Note that my config is system-specific.
# Example config can be found for my main machine: hosts/nix13/home/ty/files/.config/niri/config.kdl
# The file is copied (not symlinked) in in hosts/nix13/home/ty/home.nix
# On top of this I run noctalia-shell, configured in home/users/ty/noctalia.nix

{

  programs.niri.enable = true;

  # https://github.com/YaLTeR/niri/wiki/Important-Software
  # https://docs.noctalia.dev/getting-started/nixos/
  environment.systemPackages = with pkgs; [
    # alacritty already enabled & tweaked in system/base/base.nix
    brightnessctl
    fuzzel
    gnome-keyring
    inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
    kdePackages.polkit-kde-agent-1
    mako
    nemo-with-extensions
    xdg-desktop-portal-gnome
    xdg-desktop-portal-gtk
    xwayland-satellite
  ];

  # Enable some system-level things that noctalia-shell needs
  services.power-profiles-daemon.enable = true;
  services.udisks2.enable = true;
  services.upower.enable = true;

}
