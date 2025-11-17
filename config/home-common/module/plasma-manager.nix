{ config, pkgs, libs, ... }:

# Configure plasma-manager to declare the plasma 6 install

{
  programs.plasma.plasmaManager = {
    enable = true;
    overrideConfig = true;

    # all KDE settings
    appearance = {
      colors = {
        theme = "Breeze Dark";
      };
    };

    config = {
      shortcuts = {
        "Ctrl+Alt+T" = "alacritty";
      };
    };
  };
}