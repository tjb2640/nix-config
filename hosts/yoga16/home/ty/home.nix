# user: ty, system: yoga16
{ ... }:

{

  imports = [
    ../../../../config/home/users/ty/base/desktop.nix
    ../../../../config/home/users/ty/packages/desktop/niri.nix
  ];

  # Niri config is device-specific. Home manager when?
  home.file.".config/niri/config.kdl".source = ./files/.config/niri/config.kdl;

  programs.zsh.shellAliases = {
    rbs = "sudo echo 'Rebuilding flake yoga16' && yes | sudo nixos-rebuild switch --flake /home/ty/.dotfiles/#yoga16";
  };
  
}
