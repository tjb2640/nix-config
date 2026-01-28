# user: ty, system: nix13
{ config, inputs, pkgs, ... }:

{

  imports = [
    ../../../../config/home/users/ty/base/desktop.nix
    ../../../../config/home/users/ty/packages/desktop/niri.nix
    # Plasma: Some device-specific plasma-manager values are in ./plasma-specific.nix
  ];

  # Niri config is device-specific. Home manager when?
  home.file.".config/niri/config.kdl".source = ./files/.config/niri/config.kdl;

  programs.zsh.shellAliases = {
    rebuildswitch = "sudo nixos-rebuild switch --flake /home/ty/.dotfiles/#nix13";
  };
  
}
