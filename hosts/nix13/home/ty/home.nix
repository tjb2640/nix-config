# user: ty, system: nix13
{ config, inputs, pkgs, ... }:

{

  imports = [
    ../../../../config/home/users/ty/base.nix
    ../../../../config/home/users/ty/desktop.nix

    # Uncomment these if using Plasma:
#    ../../../../config/home/users/ty/plasma-manager.nix
#    ./plasma-specific.nix
    # Uncomment this if using niri:
    ../../../../config/home/users/ty/noctalia.nix
  ];

  # Device-specific things go here!
  # Some device-specific plasma-manager values are in ./plasma-specific.nix

  # When using niri, load this device-specific config
  home.file.".config/niri/config.kdl".source = ./files/.config/niri/config.kdl;

  programs.zsh.shellAliases = {
    rebuildswitch = "sudo nixos-rebuild switch --flake /home/ty/.dotfiles/#nix13";
  };
  
}
