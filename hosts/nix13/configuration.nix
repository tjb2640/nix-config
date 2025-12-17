{ config, pkgs, inputs, lib, ... }:

# Host: nix13 (my Thinkpad X13 gen 3 laptop)

{
  
  imports = [
    ./hardware-configuration.nix
    ../../config/base/laptop.nix
    ../../config/de/plasma/env.nix
    ../../config/extras/bluetooth.nix
    ../../config/extras/firefox.nix
    ../../config/extras/gaming.nix
    ../../config/extras/slop.nix
  ];

  boot.initrd.luks.devices."luks-fa0277a9-062a-4b4c-b011-092fc1815abf".device = "/dev/disk/by-uuid/fa0277a9-062a-4b4c-b011-092fc1815abf";
  networking.hostName = "nix13";

  system.stateVersion = "25.05";

}
