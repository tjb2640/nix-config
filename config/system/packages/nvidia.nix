{ pkgs, lib, ... }:

# File that enables enable modern NVidia GPU stuff
# This does not work out of the box with laptops!
# 
# All system-specific options like hardware.nvidia.prime
# and the selected driver package
# should be defined in the host's system.nix
#
# https://nixos.wiki/wiki/Nvidia
#
# e.g. hosts/<...>/system.nix:
#
#  {
#    hardware.nvidia.prime = {
#      sync.enable = true;
#      # Make sure to use the correct Bus ID values for your system!
#      intelBusId = "PCI:0:2:0";
#      nvidiaBusId = "PCI:14:0:0";
#    };
#  }
#
# hosts/nix14s/system.nix has an example configuration

{
  # hardware.graphics is enabled in /config/system/base/desktop.nix

  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement = {
      enable = false;
      finegrained = false;
    };
    open = false;
    nvidiaSettings = true;
  };
  
  # This was previously set to "pkgs.ollama-rocm" for amdgpu in /config/system/base/desktop.nix
  services.ollama.package = lib.mkForce pkgs.ollama-cuda;

  # Wiki says this enables driver for Wayland
  services.xserver.videoDrivers = [ "nvidia" ];

}
