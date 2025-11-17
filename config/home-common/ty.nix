{ config, pkgs, inputs, lib, ... }:

# Common home-manager values across client and server machines for my user
# Imported by /hosts/<...>/home.nix 

{

  home.username = "ty";
  home.homeDirectory = "/home/ty";
  home.packages = with pkgs; [
    eza # flashy modern ls alternative
    htop
    lm_sensors # provides `sensors`
    mullvad # command line tools
    p7zip
    unzip
    usbutils # provides `lsusb`
    xz
    zip
  ];

  # Hi, be sure to change this as well... lol
  programs.git = {
    enable = true;
    userName = "tjb2640";
    userEmail = "95368581+tjb2640@users.noreply.github.com";
  };

  programs.fastfetch = {
    enable = true;
    settings = {
      modules = [
        "title"
        "separator"
        "os"
        "de"
        "separator"
        "host"
        "cpu"
        "gpu"
        "memory"
        "display"
        "disk"
        "separator"
        "shell"
      ];
    };
  };

  # This appears to be the minimum possible config for hyfetch settings
  programs.hyfetch = {
    enable = true;
    settings = {
      backend = "fastfetch";
      color_align = {
        mode = "horizontal";
      };
      light_dark = "dark";
      lightness = 0.25;
      mode = "rgb";
      preset = "nonbinary";
    };
  };

  programs.zsh = {
    enable = true;
    shellAliases = {
      ls = "eza"; # edgy idea
      ll = "eza -l";
      gonix = "cd ~/.dotfiles";
      gs = "git status";
    };
  };

  home.stateVersion = "25.05";
  
}
