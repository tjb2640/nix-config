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
        marginHorizontal = 12;
        marginVertical = 8;
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
              id = "Volume";
              displayMode = "alwaysShow";
            }
            {
              id = "Brightness";
              displayMode = "alwaysShow";
            }
            {
              id = "WiFi";
            }
            {
              id = "Bluetooth";
            }
            {
              formatHorizontal = "HH:mm";
              formatVertical = "HH mm";
              id = "Clock";
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
}
