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

  programs.alacritty = {
    enable = true;
    settings = {
      # solarized dark
      colors = {
        primary = {
          background = "#002b36";
          foreground = "#839496";
        };
        normal = {
          black = "#073642";
          red = "#dc322f";
          green = "#859900";
          yellow = "#b58900";
          blue = "#268bd2";
          magenta = "#d33682";
          cyan = "#2aa198";
          white = "#eee8d5";
        };
        bright = {
          black = "#002b36";
          red = "#cb4b16";
          green = "#586e75";
          yellow = "#657b83";
          blue = "#839496";
          magenta = "#6c71c4";
          cyan = "#93a1a1";
          white = "#fdf6e3";
        };
      };
      font.size = 9;
      terminal.shell.program = "zsh";
    };
  };

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

  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      add_newline = false;
      format = lib.concatStrings [
        "$line_break"
        "$package"
        "$line_break"
        "$character"
      ];
      scan_timeout = 10;
      character = {
        success_symbol = "➜";
        error_symbol = "➜";
      };
    };
  };

  programs.plasma = {
    kwin = {
      # Adjust position of title bar buttons
      titlebarButtons = {
        left = [
          "close"
          "minimize"
          "maximize"
        ];
        right = [
          "shade"
        ];
      };
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
