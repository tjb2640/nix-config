{ config, pkgs, inputs, lib, ... }:

# Host: nix14s (my Thinkpad P14s laptop)

{
  
  imports = [
    ./hardware-configuration.nix
    ../../config/base/laptop.nix
    ../../config/de/plasma/env.nix
    ../../config/packages/bluetooth.nix
    ../../config/packages/firefox.nix
    ../../config/packages/gaming.nix
    # this laptop is equipped with a modern quadro card
    ../../config/packages/nvidia.nix
  ];

  # System-specific NVidia options
  # https://nixos.wiki/wiki/Nvidia
  hardware.nvidia = {
    prime = {
      sync.enable = true;
      # sudo lshw -c display
      intelBusId = "PCI:00:02:0";
      nvidiaBusId = "PCI:2d:00:0";
    };
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  boot.initrd.luks.devices."luks-13d2ad5e-9021-4597-a2bf-ea0479eda9a6".device = "/dev/disk/by-uuid/13d2ad5e-9021-4597-a2bf-ea0479eda9a6";
  networking.hostName = "nix14s";

  system.stateVersion = "25.05";

}
