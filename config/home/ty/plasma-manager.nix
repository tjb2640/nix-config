{ config, pkgs, libs, ... }:

# Configure plasma-manager to declare the plasma 6 install

{
  # link an icon
  home.file.".face.icon".source = ../../../resource/images/avatar.png;

  programs.plasma = {
    enable = true;
    overrideConfig = true;

    fonts = {
      fixedWidth = {
        family = "Hack";
        pointSize = 10;
      };
      general = {
        family = "Hack";
        pointSize = 10;
      };
      menu = {
        family = "Hack";
        pointSize = 10;
      };
      small = {
        family = "Hack";
        pointSize = 8;
      };
      toolbar = {
        family = "Hack";
        pointSize = 10;
      };
      windowTitle = {
        family = "Hack";
        pointSize = 11;
        style = "oblique";
        weight = 1000;
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
        acceleration = -0.1;
      }
    ];

    kscreenlocker = {
      appearance = {
        wallpaper = /home/ty/.dotfiles/resource/wallpapers/36claremont.jpg;
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
                hideEmptyTitle = true;
                source = "appName";
              };
            };
          }
          # Global menu
          "org.kde.plasma.appmenu"
          "org.kde.plasma.panelspacer"
          # System tray
          # ** Declarative shown/hidden are broken 29 Nov 2025: https://github.com/nix-community/plasma-manager/issues/535
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
            };
          }
        ];
      }
      {
        alignment = "center";
        floating = true;
        height = 36;
        hiding = "none";
        lengthMode = "fit";
        location = "bottom";
        opacity = "translucent";
        widgets = [
          # "dock"
          {
            config = {
              General = {
                # system: ls -l /run/current-system/sw/share/applications
                # home-manager: ls -l /etc/profiles/per-user/ty/share/applications
                launchers = [
                  "applications:nixos-manual.desktop"
                  "applications:systemsettings.desktop"
                  "applications:Alacritty.desktop"
                  "applications:org.kde.dolphin.desktop"
                  "applications:codium.desktop"
                  "applications:mullvad-vpn.desktop"
                  "applications:firefox.desktop"
                  "applications:media-downloader.desktop"
                  "applications:org.kde.kmail2.desktop"
                  "applications:org.telegram.desktop.desktop"
                  "applications:signal.desktop"
                  "applications:vesktop.desktop"
                  "applications:writer.desktop"
                  "applications:org.inkscape.Inkscape.desktop"
                  "applications:org.kde.krita.desktop"
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
      # lookAndFeel = "org.kde.breezedark.desktop";
      wallpaper = /home/ty/.dotfiles/resource/wallpapers/36claremont.jpg;
    };
  };

}
