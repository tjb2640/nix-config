# user: ty, system: nix13
{ ... }:

{

  imports = [
    ../../../config/home/base/desktop.nix
    ../../../config/home/extras/niri.nix
  ];

  # Niri config is device-specific. Home manager when?
  home.file.".config/niri/config.kdl".source = ./files/.config/niri/config.kdl;

  programs.zsh.shellAliases = {
    rbs = "sudo echo 'Rebuilding flake nix13' && yes | sudo nixos-rebuild switch --flake /home/ty/.dotfiles/#nix13";
  };
  
}
