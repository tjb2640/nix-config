# user: ty, system: nix13
{ config, inputs, pkgs, ... }:

{

  imports = [
    ../../../../config/home/users/ty/base.nix
    ../../../../config/home/users/ty/desktop.nix

    # Uncomment these if using Plasma:
#    ../../../../config/home/users/ty/plasma-manager.nix
#    ./plasma-specific.nix
    # Uncomment these if using niri:
    ../../../../config/home/users/ty/noctalia.nix
    ../../../../config/home/users/ty/udiskie.nix
  ];

  # Device-specific things go here!
  # Some device-specific plasma-manager values are in ./plasma-specific.nix

  # When using niri, load this device-specific config and start script
  home.file.".config/niri/config.kdl".source = ./files/.config/niri/config.kdl;
  home.file."niri.sh".source = ./files/niri.sh;

  programs.zsh.shellAliases = {
    rebuildswitch = "sudo nixos-rebuild switch --flake /home/ty/.dotfiles/#nix13";
  };
  
}
