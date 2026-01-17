# user: ty, system: nix13
{ config, inputs, pkgs, ... }:

{

  imports = [
    ../../../../config/home/users/ty/base.nix
    ../../../../config/home/users/ty/desktop.nix

    # Uncomment these if using Plasma:
#    ../../../../config/home/users/ty/plasma-manager.nix
#    ./plasma-specific.nix
  ];

  # Device-specific things go here!
  # Some device-specific plasma-manager values are in ./plasma-specific.nix

  programs.zsh.shellAliases = {
    rebuildswitch = "sudo nixos-rebuild switch --flake /home/ty/.dotfiles/#nix13";
  };
  
}
