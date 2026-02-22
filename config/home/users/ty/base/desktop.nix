{ pkgs, inputs, ... }:

# home-manager config for desktop machines. Mostly graphical applications

{
  
  imports = [
    ./base.nix
    inputs.zen-browser.homeModules.beta
  ];

  # link a face icon for desktop environments
  home.file.".face.icon".source = ../../../../../resource/images/avatar.png;

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

  # cmus - terminal music player
  programs.cmus = {
    enable = true;
    theme = "jellybeans";
  };
  
  # Zen browser - my chosen Firefox replacement
  programs.zen-browser = {
    enable = true;
    policies = {
      AutofillAddressEnabled = false;
      AutofillCreditCardEnabled = false;
      DisableAppUpdate = true;
      DisableFeedbackCommands = true;
      DisableFirefoxStudies = true;
      DisablePocket = true;
      DisableTelemetry = true;
      DontCheckDefaultBrowser = true;
      NoDefaultBookmarks = true;
      OfferToSaveLogins = false;
      EnableTrackingProtection = {
        Value = true;
        Locked = true;
        Cryptomining = true;
        Fingerprinting = true;
      };
    };
    # suppresses message about migrating ~/.zen to ~/.config/zen
    suppressXdgMigrationWarning = true;
  };

  programs.zen-browser.profiles.default = let
    containers = {
      Life = {
        color = "green";
        icon = "tree";
        id = 2;
      };
    };
    spaces = {
      "Main" = {
        id = "572910e1-4468-4832-a869-0b3a93e2f165";
        container = containers.Life.id;
        icon = "🍁";
        position = 1000;
        theme = {
          type = "gradient";
          colors = [
            {
              red = 28;
              green = 18;
              blue = 18;
              algorithm = "floating";
              type = "explicit-lightness";
            }
          ];
          opacity = 0.8;
          texture = 0.5;
        };
      };
      "Dev Stuff" = {
        id = "672910e1-4468-4832-a869-0b3a93e2f165";
        container = containers.Life.id;
        icon = "❄️";
        position = 1001;
        theme = {
          type = "gradient";
          colors = [
            {
              red = 28;
              green = 18;
              blue = 18;
              algorithm = "floating";
              type = "explicit-lightness";
            }
          ];
          opacity = 0.8;
          texture = 0.5;
        };
      };
    };
    pins = {
      "[ start ]" = {
        id = "9d8a8f91-7e29-4688-ae2e-da4e49d4a179";
        container = containers.Life.id;
        url = "file:///home/ty/.dotfiles/resource/pages/browserstart/index.html";
        isEssential = true;
        position = 101;
      };
      "Migadu Webmail" = {
        id = "8af62707-0722-4049-9801-bedced343333";
        container = containers.Life.id;
        url = "https://webmail.migadu.com/#/mailbox/INBOX";
        isEssential = true;
        position = 102;
      };
      "Proton Mail" = {
        id = "fb316d70-2b5e-4c46-bf42-f4e82d635153";
        container = containers.Life.id;
        url = "https://mail.proton.me/u/0/inbox";
        isEssential = true;
        position = 103;
      };
      "YouTube" = {
        id = "9e8a8f91-7e29-4688-ae2e-da4e49d4a179";
        container = containers.Life.id;
        url = "https://youtube.com";
        isEssential = true;
        position = 201;
      };
      "The Star" = {
        id = "8bf62707-0722-4049-9801-bedced343333";
        container = containers.Life.id;
        url = "https://www.thestar.com";
        isEssential = true;
        position = 202;
      };
      "NeoCities" = {
        id = "fc316d70-2b5e-4c46-bf42-f4e82d635153";
        container = containers.Life.id;
        url = "https://neocities.org/";
        isEssential = true;
        position = 203;
      };
    };
  in {
    containersForce = true;
    pinsForce = true;
    spacesForce = true;
    inherit containers pins spaces;
  };
}
