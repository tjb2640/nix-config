{ config, pkgs, inputs, lib, ... }:

# Enables GNOME as the desktop environment
# https://wiki.nixos.org/wiki/GNOME

{
  
  services.desktopManager.gnome.enable = true;
  services.displayManager.gdm.enable = true;

  environment.gnome.excludePackages = with pkgs; [ gnome-tour gnome-user-docs ];
  environment.systemPackages = with pkgs; [
    gnomeExtensions.blur-my-shell
    gnomeExtensions.just-perfection
    gnomeExtensions.arc-menu
  ];

  # Enable some experimental GNOME features
  programs.dconf = {
    enable = true;
    profiles.ty.databases = [
      {
#        lockAll = true; # prevent overrides
        settings = {
          "org/gnome/desktop/interface" = {
            accent-color = "blue";
          };
          "org/gnome/mutter" = {
            experimental-features = [
              "scale-monitor-framebuffer" # Enables fractional scaling (125% 150% 175%)
              "variable-refresh-rate"     # Enables Variable Refresh Rate (VRR) on compatible displays
              "xwayland-native-scaling"   # Scales Xwayland applications to look crisp on HiDPI screens
            ];
          };
        };
      }
    ];
  };

  # Style QT apps like GNOME
  qt = {
    enable = true;
    platformTheme = "gnome";
    style = "adwaita-dark";
  };

}
