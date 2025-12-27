# user: ty, system: nix14s
{ config, pkgs, ... }:

{

  imports = [
    ../../../config/home/users/ty/base.nix
    ../../../config/home/users/ty/desktop.nix
    ../../../config/home/users/ty/plasma-manager.nix
  ];

  programs.zsh.shellAliases = {
    rebuildswitch = "sudo nixos-rebuild switch --flake /home/ty/.dotfiles/#nix14s";
  };
  
}
