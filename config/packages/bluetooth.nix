{ config, pkgs, inputs, lib, ... }:

# Enables Bluetooth
# https://wiki.nixos.org/wiki/Bluetooth
# note: dconf is gnome-specific and enabled in ./gnome.nix

{

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    settings = {
      General = {
        Enable = "Source,Sink,Media,Socket"; # A2DP sink for modern headsets
        Experimental = true; # enable this for viewing battery state of connected BT device
      };
    };
  };

  fileSystems."/var/lib/bluetooth" = {
    device = "/persist/var/lib/bluetooth";
    options = [ "bind" "noauto" "x-systemd.automount" ];
    noCheck = true;
  };

  # I have overskride in ./common-desktop.nix, which is a DE-agnostic BT management frontend.
  # Alternatively, NixOS makes blueman available like this:
#  services.blueman.enable = true;

}
