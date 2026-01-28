# user: ty, system: nix14s
{ config, pkgs, ... }:

{

  imports = [
    ../../../../config/home/users/ty/base/desktop.nix
    ../../../../config/home/users/ty/packages/plasma-manager.nix
  ];

  programs.zsh.shellAliases = {
    rebuildswitch = "sudo nixos-rebuild switch --flake /home/ty/.dotfiles/#nix14s";
  };
  
}
