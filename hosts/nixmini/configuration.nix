{ config, pkgs, inputs, lib, ... }:

# Host: nixmini (desktop)

{
  
  imports = [
    ./hardware-configuration.nix
    ../../config/base/desktop.nix
    ../../config/de/plasma/env.nix
    ../../config/packages/firefox.nix
  ];

  boot.initrd.luks.devices."luks-bbe55676-4764-4ccf-9ffe-212d5089955a".device = "/dev/disk/by-uuid/bbe55676-4764-4ccf-9ffe-212d5089955a";
  networking.hostName = "nixmini";

  system.stateVersion = "25.05";

}
