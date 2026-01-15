{ config, pkgs, inputs, lib, ... }:

# Host: nix13 (my Thinkpad X13 gen 3 laptop)

{
  
  imports = [
    ./hardware-configuration.nix
    ../../config/system/base/laptop.nix
    ../../config/system/de/plasma.nix
    ../../config/system/extras/bluetooth.nix
    ../../config/system/extras/firefox.nix
    ../../config/system/extras/gaming.nix
    ../../config/system/extras/plymouth.nix
    ../../config/system/extras/zoom.nix
  ];

  boot.initrd.luks.devices."luks-fa0277a9-062a-4b4c-b011-092fc1815abf".device = "/dev/disk/by-uuid/fa0277a9-062a-4b4c-b011-092fc1815abf";
  networking.hostName = "nix13";

  system.stateVersion = "25.05";

}
