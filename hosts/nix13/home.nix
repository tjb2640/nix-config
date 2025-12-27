# user: ty, system: nix13
{ config, inputs, pkgs, ... }:

{

  imports = [
    ../../config/home/ty/base.nix
    ../../config/home/ty/desktop.nix
    ../../config/home/ty/plasma-manager.nix
  ];

  # Device-specific things go here!

  # `cat /proc/bus/input/devices` to find this info
  programs.plasma.input.touchpads = [
    # builtin touchpad
    {
      enable = false;
      name = "ELAN0678:00 04F3:3195 Touchpad";
      productId = "3195";
      vendorId = "04f3";
    }
  ];

  # you can't guess how long it took me to figure out i had to escape the path character
  programs.plasma.input.mice = [
    # builtin trackpoint
    {
      enable = true;
      name = "TPPS\\/2 Elan TrackPoint";
      productId = "000a";
      vendorId = "0002";
      acceleration = -0.6;
    }
  ];

  programs.zsh.shellAliases = {
    rebuildswitch = "sudo nixos-rebuild switch --flake /home/ty/.dotfiles/#nix13";
  };
  
}
