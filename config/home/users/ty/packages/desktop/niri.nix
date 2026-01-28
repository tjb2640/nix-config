{ pkgs, inputs, ... }:

# Configure noctalia (for niri) with home-manager

{

  imports = [
    inputs.noctalia.homeModules.default
  ];

  # noctalia does wallpapers in a different file:
  home.file.".cache/noctalia/wallpapers.json" = {
    text = builtins.toJSON {
      defaultWallpaper = "/home/ty/.dotfiles/resource/wallpapers/36claremont.jpg";
    };
  };

  # niri start script! needs wrapped in dbus
  home.file."niri.sh".source = ../../files/niri.sh;

  programs.noctalia-shell = {
    enable = true;
    colors = {
      # you must set ALL of these
      mError = "#dddddd";
      mOnError = "#111111";
      mOnPrimary = "#111111";
      mOnSecondary = "#111111";
      mOnSurface = "#d6beb9";
      mOnSurfaceVariant = "#d6beb9";
      mOnTertiary = "#d6beb9";
      mOnHover = "#111111";
      mOutline = "#a23e2a";
      mPrimary = "#a23e2a";
      mSecondary = "#c5a62f";
      mShadow = "#000000";
      mSurface = "#322222";
      mHover = "#90b542";
      mSurfaceVariant = "#311f1f";
      mTertiary = "#cccccc";
    };
    settings = {
      bar = {
        backgroundOpacity = 0;
        density = "default";
        position = "top";
        showCapsule = true;
        useSeparateOpacity = true;
        widgets = {
          left = [
            {
              id = "ControlCenter";
              useDistroLogo = true;
            }
            {
              id = "ActiveWindow";
              maxWidth = 384;
            }
            {
              id = "MediaMini";
              maxWidth = 256;
            }
          ];
          center = [
            {
              hideUnoccupied = false;
              id = "Workspace";
              labelMode = "none";
            }
          ];
          right = [
            {
              id = "Tray";
            }
            {
              alwaysShowPercentage = true;
              displayMode = "alwaysShow";
              id = "Battery";
              warningThreshold = 25;
            }
            {
              id = "PowerProfile";
            }
            {
              id = "Volume";
              displayMode = "alwaysShow";
            }
            {
              id = "Brightness";
              displayMode = "alwaysShow";
            }
            {
              id = "VPN";
              displayMode = "alwaysShow";
            }
            {
              id = "WiFi";
            }
            {
              id = "Bluetooth";
            }
            {
              id = "Clock";
              formatHorizontal = "HH:mm";
              formatVertical = "HH mm";
              useMonospacedFont = false;
              usePrimaryColor = false;
            }
          ];
        };
      };
      general = {
        avatarImage = "/home/ty/.face.icon";
        radiusRatio = 0.2;
      };
      location = {
        monthBeforeDay = true;
        name = "Pittsburgh, USA";
      };
      ui = {
        fontDefault = "DejaVu Serif";
        fontFixed = "DejaVu Serif";
        fontDefaultScale = 1.1;
        fontFixedScale = 1.1;
      };
    };
  };

  services.udiskie = {
    enable = true;
    settings = {
        program_options = {
            file_manager = "${pkgs.nemo-with-extensions}/bin/nemo";
        };
    };
  };
}
