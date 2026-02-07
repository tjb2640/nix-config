{ config, pkgs, inputs, lib, ... }:

# Desktop computer common values

let 
  plymouth-theme-rbsys = pkgs.callPackage ../../../overlays/system/plymouth-theme-rbsys/default.nix {};
in
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

  # Custom "rbsys" boot screen
  boot = {
    plymouth = {
      enable = true;
      theme = "rbsys";
      themePackages = [ plymouth-theme-rbsys ];
    };
    consoleLogLevel = 3;
    initrd.verbose = false;
    kernelParams = [
      "quiet"
      "splash"
      "boot.shell_on_fail"
      "udev.log_priority=3"
      "rd.systemd.show_status=auto"
    ];
    loader.timeout = 0;
  };

  environment.systemPackages = with pkgs; [
    hack-font
  ];

  fileSystems."/var/lib/bluetooth" = {
    device = "/persist/var/lib/bluetooth";
    options = [ "bind" "noauto" "x-systemd.automount" ];
    noCheck = true;
  };

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    settings = {
      General = {
        Enable = "Source,Sink,Media,Socket"; # A2DP sink for modern headsets
        Experimental = true; # for viewing battery state of connected device
      };
    };
  };

  # Enable these explicitly in case they are disabled
  hardware.graphics.enable = true;
  hardware.graphics.enable32Bit = true;

  services.blueman.enable = true;
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
  #   EXTRA PACKAGES
  # ###########################################################

  services.ollama = {
    enable = true;
    loadModels = [ "deepseek-r1:1.5b" "dolphin3:8b" ];
    package = lib.mkDefault pkgs.ollama-rocm; # AMD default, packages/nvidia.nix will set this to "-cuda
  };

  services.open-webui = {
    enable = true;
    port = 8083;
  };

  users.users.ty.packages = with pkgs; [
    apple-fonts
    cmus # terminal music player
    ffmpeg
    inkscape-with-extensions # load extensions from derivations
    krita
    libreoffice
    media-downloader # Qt yt-dlp
    mullvad-vpn
    obsidian
    pear-desktop # (formerly youtube-music)
    plymouth-theme-rbsys
    qbittorrent
    qt6Packages.qt6ct # qt6 theming
    scrcpy # android device screen interaction
    signal-desktop
    strawberry # graphical music player
    telegram-desktop
    vesktop # discord
    vlc
    vscodium # de-microsofted vscode
    yt-dlp # youtube downloader
  ];

}
