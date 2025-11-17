# user: ty, system: nix13
{ config, pkgs, ... }:

{

  imports = [
    ../../config/home-common/ty.nix
  ];

  programs.zsh.shellAliases = {
    rebuildswitch = "sudo nixos-rebuild switch --flake /home/ty/.dotfiles/#nix13";
  };
  
}
