{ config, pkgs, inputs, lib, ... }:

# Don't import this file. Import one of ./desktop.nix, ./laptop.nix,
# or ./server.nix. One only, depending on type of system,
# not all three at once.

{
  
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.systemd-boot.enable = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = lib.mkForce true;

  # ###########################################################
  #   SYSTEM & SERVICES
  # ###########################################################

  # Time and Locale
  i18n.defaultLocale = "en_CA.UTF-8";
  time.timeZone = lib.mkDefault "America/Toronto";

  networking.networkmanager.enable = true;
  powerManagement.enable = lib.mkDefault false;
  services.libinput.enable = true;
  services.openssh.enable = lib.mkDefault false;
  services.pipewire.enable = lib.mkDefault false;
  services.printing.enable = lib.mkDefault false;
  services.pulseaudio.enable = false; # always prefer pipewire if anything
  services.xserver.enable = lib.mkDefault false; # this is a Wayland household

  # Run automatic garbage collection for old generations
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
    persistent = true;
  };

  # ###########################################################
  #   PROGRAMS
  # ###########################################################

  environment.systemPackages = with pkgs; [
    android-tools
    cifs-utils # SMB/CIFS
    curl
    ddate
    exfat
    eza # flashy modern ls alternative
    file
    gdb
    git # required by flakes
    glib
    glibc
    htop
    libgcc
    lm_sensors # provides `sensors`
    lshw # useful for discovering bus id values
    p7zip
    rename
    unzip
    usbutils # provides `lsusb`
    vim
    wget
    xz
    zip
  ];
  
  # "Some programs need SUID wrappers, can be configured
  # further or are started in user sessions."
  programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  programs.zsh.enable = true;

  # ###########################################################
  #   ACCOUNTS
  # ###########################################################

  # Main user account
  users.users.ty = {
    shell = pkgs.zsh;
    isNormalUser = true;
    description = "Ty B";
    extraGroups = [ "networkmanager" "wheel" "adbusers" ];
  };

}
