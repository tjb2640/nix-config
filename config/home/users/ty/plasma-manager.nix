{ config, pkgs, libs, ... }:

# Configure plasma-manager to declare the plasma 6 install

{
  # link an icon
  home.file.".face.icon".source = ../../../../resource/images/avatar.png;

  programs.plasma = {
    enable = true;
    overrideConfig = true;

    fonts = {
      fixedWidth = {
        family = "Hack";
        pointSize = 10;
      };
      general = {
        family = "New York Small";
        pointSize = 11;
      };
      menu = {
        family = "New York Small";
        pointSize = 12;
      };
      small = {
        family = "New York Small";
        pointSize = 10;
      };
      toolbar = {
        family = "New York Small";
        pointSize = 12;
      };
      windowTitle = {
        family = "New York Small";
        pointSize = 12;
      };
    };

    # Configure some input devices I use across multiple Plasma machines
    # `cat /proc/bus/input/devices` to find this info
    input.mice = [
      # Kensington Expert Mouse (big trackball thing)
      {
        # note: feels better to adjust acceleration rather than speed with this one
        enable = true;
        name = "Kensington Expert Mouse";
        productId = "1020";
        vendorId = "0111";
        acceleration = -0.5;
      }
      # USB trackpoint keyboard (rectangle, micro-usb, newer)
      {
        enable = true;
        name = "Lenovo ThinkPad Compact USB Keyboard with TrackPoint";
        productId = "6047";
        vendorId = "17ef";
        acceleration = -0.2;
      }
    ];

    kscreenlocker = {
      appearance = {
        wallpaper = /home/ty/.dotfiles/resource/wallpapers/36claremont.jpg;
      };
    };

    kwin = {
      effects = {
        wobblyWindows.enable = true;
      };
      # Adjust position of title bar buttons
      titlebarButtons = {
        left = [
          "close"
          "minimize"
          "maximize"
        ];
        right = [];
      };
    };
  
    # My panel setup
    # Useful: https://develop.kde.org/docs/plasma/scripting/keys/
    panels = [
      {
        alignment = "center";
        floating = false;
        height = 36;
        hiding = "none";
        lengthMode = "fill";
        location = "top";
        opacity = "translucent";
        widgets = [
          {
            config = {
              Appearance = {
                icon = "/home/ty/.dotfiles/resource/images/nixos_256.png";
              };
            };
            name = "org.kde.plasma.kickoff";
          }
          # App title
          {
            applicationTitleBar = {
              behavior = {
                activeTaskSource = "activeTask";
              };
              layout = {
                elements = [ "windowTitle" ];
                horizontalAlignment = "left";
                showDisabledElements = "deactivated";
                verticalAlignment = "center";
              };
              overrideForMaximized.enable = false;
              windowTitle = {
                font = {
                  size = 12;
                  bold = false;
                };
                hideEmptyTitle = true;
                source = "appName";
              };
            };
          }
          # Global menu
          "org.kde.plasma.appmenu"
          "org.kde.plasma.panelspacer"
          # System tray
          # ls /run/current-system/sw/share/plasma/plasmoids/
          # ls /etc/profiles/per-user/ty/share/plasma/plasmoids/
          {
            systemTray = {
              items = {
                shown = [
                  "org.kde.plasma.pager"
                  "org.kde.plasma.weather"
                  "org.kde.plasma.networkmanagement"
                  "org.kde.plasma.volume"
                  "org.kde.plasma.battery"
                ];
                hidden = [
                  "org.kde.plasma.bluetooth"
                  "org.kde.plasma.clipboard"
                ];
              };
            };
          }
          # Clock
          {
            digitalClock = {
              date.enable = false;
              font.family = "New York Small";
              font.size = 8;
            };
          }
        ];
      }
      {
        alignment = "left";  # bottom dock: "center"; vert left: "left"
        floating = false;  # bottom dock: true; vert left: false
        height = 42; # bottom dock: 36; vert left: 42
        hiding = "none";
        lengthMode = "fill"; # bottom dock: "fit"; vert left: "fill"
        location = "left";  # bottom dock: "bottom"; vert left: "left"
        opacity = "translucent";
        widgets = [
          # "dock"
          {
            config = {
              General = {
                # system: ls -l /run/current-system/sw/share/applications
                # home-manager: ls -l /etc/profiles/per-user/ty/share/applications
                launchers = [
                  "applications:systemsettings.desktop"
                  "applications:Alacritty.desktop"
                  "applications:org.kde.dolphin.desktop"
                  "applications:codium.desktop"
                  "applications:mullvad-vpn.desktop"
                  "applications:firefox.desktop"
                  "applications:zen-beta.desktop"
                  "applications:org.strawberrymusicplayer.strawberry.desktop"
                  "applications:org.kde.kmail2.desktop"
                  "applications:org.telegram.desktop.desktop"
                  "applications:vesktop.desktop"
                  "applications:writer.desktop"
                  "applications:org.inkscape.Inkscape.desktop"
                  "applications:steam.desktop"
                ];
                wheelEnabled = false;
              };
            };
            name = "org.kde.plasma.icontasks";
          }
        ];
      }
    ];

    session = {
      general = {
        askForConfirmationOnLogout = false;
      };
      sessionRestore = {
        restoreOpenApplicationsOnLogin = "startWithEmptySession";
      };
    };

    workspace = {
      # plasma-apply-colorscheme --list-schemes
      colorScheme = "ClaremontDark";
      iconTheme = "Tela";
      # plasma-apply-desktoptheme --list-themes
      lookAndFeel = "ClaremontDark";
      wallpaper = /home/ty/.dotfiles/resource/wallpapers/36claremont.jpg;
      # Need to imperatively set these then inspect ~/.config/kwinrc to get their values:
      windowDecorations = {
        library="org.kde.kwin.aurorae";
        theme="__aurorae__svg__ClaremontDark";
      };
    };
  };

}
