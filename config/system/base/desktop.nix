{ config, pkgs, inputs, lib, ... }:

# Desktop computer common values

{

  imports = [ ./base.nix ];

  # ###########################################################
  #   OVERLAYS
  # ###########################################################
  
  nixpkgs.overlays = [
    # Fonts: SF & NY
    (final: prev: rec {
      apple-fonts = final.callPackage ../../../overlays/system/apple-fonts/default.nix {};
    })
  ];

  # ###########################################################
  #   SYSTEM & SERVICES
  # ###########################################################

  environment.systemPackages = with pkgs; [
    hack-font
  ];

  # Enable these in case they are not already
  hardware.graphics.enable = true;
  hardware.graphics.enable32Bit = true;

  services.mullvad-vpn.enable = true;
  services.openssh.enable = lib.mkForce false;
  services.pipewire = {
    enable = lib.mkForce true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
    wireplumber.enable = true;
  };
  services.printing.enable = lib.mkForce true; # CUPS
  security.rtkit.enable = true; # let Pipewire use the realtime scheduler

  # ###########################################################
  #   ACCOUNTS
  # ###########################################################

  users.users.ty.packages = with pkgs; [
    # overlays
    apple-fonts
    # nixpkgs
    cmus
    ffmpeg
    inkscape-with-extensions # load extensions from derivations
    krita
    libreoffice
    media-downloader # Qt yt-dlp
    mullvad-vpn
    qbittorrent
    scrcpy # android device screen interaction
    signal-desktop
    telegram-desktop
    vesktop # discord
    vlc
    vscodium
    yt-dlp
    youtube-music
  ];

}
