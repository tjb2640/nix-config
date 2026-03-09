{ config, lib, pkgs, inputs, ... }:

# home-manager config for desktop machines. Mostly graphical applications

{
  
  imports = [ ./base.nix ];

  # link a face icon for desktop environments
  home.file.".face.icon".source = ../../../resource/images/avatar.png;

  # adjust some environment variables
  # QT_QPA_PLATFORMTHEME as a stopgap to enable dark mode via qt6ct
  home.sessionVariables = {
    QT_QPA_PLATFORMTHEME = "qt6ct";
  };

  programs.alacritty = {
    enable = true;
    settings = {
      # custom theme
      colors = {
        primary = {
          background = "#231111";
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
      window = {
        opacity = 0.9;
      };
    };
  };

  programs.librewolf = {
    enable = true;
    languagePacks = [ "en-CA" "en-GB" "en-US" ];
    policies = {
      ExtensionSettings = {
        "uBlock0@raymondhill.net" = {
          default_area = "menupanel";
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
          installation_mode = "force_installed";
          private_browsing = true;
        };
        "sponsorBlocker@ajay.app" = {
          default_area = "menupanel";
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/sponsorblock/latest.xpi";
          installation_mode = "force_installed";
          private_browsing = true;
        };
      };
    };
    profiles = {
      Home = {
        id = 0;
        isDefault = true;
        name = "Home";
        search = {
          default = "ddg";
          privateDefault = "ddg";
        };
        settings = {
          "browser.bookmarks.showMobileBookmarks" = false;
          "browser.search.isUS" = false;
          "browser.search.region" = "CA";
          "browser.startup.homepage" = "file:///home/ty/.dotfiles/resource/pages/browserstart/index.html";
          "browser.searchplugins.defaultLocale" = "en-CA";
          "general.useragent.locale" = "en-CA";
          "media.eme.enabled" = true; # DRM
        };
      };
    };
    settings = {
      "privacy.resistFingerprinting" = false;
      "webgl.disabled" = false;
    };
  };

  # https://discourse.nixos.org/t/home-manager-and-the-mimeapps-list-file-on-plasma-kde-desktops/37694/7
  xdg.mimeApps.enable = lib.mkDefault true;

  programs.newsboat = {
    enable = true;
    autoFetchArticles.enable = true;
    autoVacuum.enable = true;
    urls = [
      {
        tags = [ "cbc" "ca" ];
        url = "https://www.cbc.ca/webfeed/rss/rss-canada";
      }
      {
        tags = [ "cbc" "ca" "world" ];
        url = "https://www.cbc.ca/webfeed/rss/rss-world";
      }
      {
        tags = [ "cbc" "ca" "toronto" ];
        url = "https://www.cbc.ca/webfeed/rss/rss-canada-toronto";
      }
    ];
  };
  
}
