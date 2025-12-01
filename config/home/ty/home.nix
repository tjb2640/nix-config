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
      # custom theme
      colors = {
        primary = {
          background = "#322222";
          foreground = "#d6beb9";
        };
        normal = {
          black = "#6b6b6b";
          red = "#a23e2a";
          green = "#90b542";
          yellow = "#c5a62f";
          blue = "#427cb5";
          magenta = "#8f3da0";
          cyan = "#48c5c4";
          white = "#e1cfcb";
        };
        bright = {
          black = "#8e8e8e";
          red = "#b04b37";
          green = "#b2ce79";
          yellow = "#dbc367";
          blue = "#86add2";
          magenta = "#bc76cd";
          cyan = "#77dddd";
          white = "#ece1df";
        };
      };
      font.size = 11;
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
        "separator"
        "colors"
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
      gomusic = "cd ~/Music/Library";
      gonix = "cd ~/.dotfiles";
      gs = "git status";
    };
  };

  home.stateVersion = "25.05";
  
}
