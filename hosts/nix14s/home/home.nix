# user: ty, system: nix14s
{ ... }:

{

  imports = [
    ../../../config/home/base/desktop.nix
    ../../../config/home/extras/niri.nix
  ];

  # Niri config is device-specific. Home manager when?
  home.file.".config/niri/config.kdl".source = ./files/.config/niri/config.kdl;

  programs.zsh.shellAliases = {
    rbs = "sudo echo 'Rebuilding flake nix14s' && yes | sudo nixos-rebuild switch --flake /home/ty/.dotfiles/#nix14s";
  };
  
}
