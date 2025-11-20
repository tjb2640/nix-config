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
  # TODO: first install on p14s then fill these in and test.
#  hardware.nvidia = {
#    prime = {
#      sync.enable = true;
#      # sudo lshw -c display
#      intelBusId = "TBD";
#      nvidiaBusId = "TBD";
#    };
#    package = config.boot.kernelPackages.nvidiaPackages.stable;
#  };

  # TODO: boot.initrd.luks.devices
  networking.hostName = "nix14s";

  system.stateVersion = "25.05";

}
