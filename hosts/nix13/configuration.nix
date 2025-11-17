{ config, pkgs, inputs, lib, ... }:

# Host: nix13 (my Thinkpad X13 gen 3 laptop)

{
  
  imports = [
    ./hardware-configuration.nix
    ../../config/base/laptop.nix
    ../../config/de/plasma.nix
    ../../config/packages/bluetooth.nix
    ../../config/packages/firefox.nix
    ../../config/packages/gaming.nix
  ];

  boot.initrd.luks.devices."luks-ed8dffb9-5047-4119-8abf-2099653adb25".device = "/dev/disk/by-uuid/ed8dffb9-5047-4119-8abf-2099653adb25";
  networking.hostName = "nix13";

  system.stateVersion = "25.05";

}
