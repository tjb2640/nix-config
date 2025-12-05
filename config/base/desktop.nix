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
      apple-fonts = final.callPackage ../../overlays/system/font/apple-fonts/default.nix {};
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
    filezilla
    ffmpeg
    gpa # gpg gui
    inkscape-with-extensions # load extensions from derivations
    krita
    libreoffice
    media-downloader # Qt yt-dlp
    monero-gui
    mullvad-vpn
    obs-studio
    obsidian
    openttd
    overskride # bluetooth frontend, in lieu of emabling blueman
    postman
    qbittorrent
    scrcpy # android device screen interaction
    signal-desktop
    strawberry
    telegram-desktop
    tor-browser-bundle-bin
    ungoogled-chromium
    vesktop # discord
    vlc
    vscodium
    yt-dlp
    youtube-music
  ];

}
