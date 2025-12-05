# user: ty, system: nix14s
{ config, pkgs, ... }:

{

  imports = [
    ../../config/home/ty/home.nix
    ../../config/home/ty/plasma-manager.nix
  ];

  programs.zsh.shellAliases = {
    rebuildswitch = "sudo nixos-rebuild switch --flake /home/ty/.dotfiles/#nix14s";
  };
  
}
