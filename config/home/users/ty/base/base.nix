{ config, pkgs, inputs, lib, ... }:

# Common home-manager values across client and server machines for my user
# Imported by /hosts/<...>/home/ty/home.nix 

{

  home.username = "ty";
  home.file.".config/macchina/themes/Rbsys.toml".source = ../files/.config/macchina/themes/Rbsys.toml;
  home.file.".config/macchina/macchina.toml".source = ../files/.config/macchina/macchina.toml;
  home.homeDirectory = "/home/ty";
  home.packages = with pkgs; [
    macchina
    mullvad # command line tools for mullvad vpn
  ];
  home.sessionVariables = {
    EDITOR = "hx";
  };

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
    settings = {
      user.email = "95368581+tjb2640@users.noreply.github.com";
      user.name = "tjb2640";
    };
  };

  programs.fastfetch = {
    enable = true;
    settings = {
      modules = [
        "title"
        "separator"
        "os"
        "de"
        "wm"
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

  # Helix editor (hx)
  programs.helix = {
    enable = true;
    settings = {
      editor = {
        cursor-shape = {
          normal = "block";
          insert = "bar";
          select = "underline";
        };
      };
      theme = "autumn_night_transparent";
    };
    languages.language = [{
      auto-format = false;
      formatter.command = lib.getExe pkgs.nixfmt;
      name = "nix";
    }];
    themes = {
      autumn_night_transparent = {
        "inherits" = "autumn_night";
        "ui.background" = { };
      };
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
      pride_month_disable = false;
    };
  };

  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      add_newline = false;
      character = {
        success_symbol = "[➜](bold green)";
        error_symbol = "[❌](bold red)";
      };
      directory = {
        read_only = " -w";
        read_only_style = "italic red";
        style = "italic yellow";
        truncation_length = 10;
      };
      format = ''

        [┌](yellow)$time[ $directory](yellow)
        [└](green)$username$hostname[](green)$status $character
      '';
      hostname = {
        disabled = false;
        format = "[ @ $ssh_symbol$hostname ]($style)";
        ssh_only = false;
        style = "fg:#000000 bg:green";
      };
      scan_timeout = 10;
      status = {
        disabled = false;
        format = "[ $int $common_meaning$signal_name]($style)";
        style = "italic red";
      };
      time = {
        disabled = false;
        format = "[ • $time ]($style)";
        style = "fg:#000000 bg:yellow";
        use_12hr = true;
      };
      username = {
        format = "[ • $user]($style)";
        disabled = false;
        show_always = true;
        style_root = "fg:#000000 bg:green";
        style_user = "fg:#000000 bg:green";
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

  home.stateVersion = "25.11";
  
}
