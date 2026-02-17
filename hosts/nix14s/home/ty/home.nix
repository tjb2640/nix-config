# user: ty, system: nix14s
{ ... }:

{

  imports = [
    ../../../../config/home/users/ty/base/desktop.nix
    ../../../../config/home/users/ty/packages/plasma-manager.nix
  ];

  programs.zsh.shellAliases = {
    rbs = "sudo nixos-rebuild switch --flake /home/ty/.dotfiles/#nix14s";
  };
  
}
