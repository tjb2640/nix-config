{ config, pkgs, inputs, lib, modulesPath, ... }:

# Host: yoga16 (16" Lenovo Yoga from 2024, I think?)

{
  
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    ../../config/system/base/laptop.nix
    ../../config/system/packages/desktop/niri.nix
    ../../config/system/packages/firefox.nix
    ../../config/system/packages/gaming.nix
    ../../config/system/packages/nvidia.nix # 4050 ti mobile
  ];

  # System-specific NVidia options
  # https://nixos.wiki/wiki/Nvidia
  hardware.nvidia = {
    prime = {
      sync.enable = true;
      # sudo lshw -c display
      intelBusId = "PCI:0:2:0";
      nvidiaBusId = "PCI:1:0:0";
    };
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  # No need to touch below

  boot.initrd.availableKernelModules = [ "xhci_pci" "thunderbolt" "nvme" "usb_storage" "sd_mod" "sdhci_pci" ];
  boot.initrd.kernelModules = [];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [];

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/98571827-68ee-43ba-9f44-125480664ab0";
    fsType = "ext4";
  };
  
  boot.initrd.luks.devices."luks-45d830e5-2448-40a4-a71c-72c5d87c458d".device = "/dev/disk/by-uuid/45d830e5-2448-40a4-a71c-72c5d87c458d";
  boot.initrd.luks.devices."luks-81e0f8e3-cd8b-43ec-8804-7fc9834168e6".device = "/dev/disk/by-uuid/81e0f8e3-cd8b-43ec-8804-7fc9834168e6";

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/16F2-98BE";
    fsType = "vfat";
    options = [ "fmask=0077" "dmask=0077" ];
  };

  swapDevices = [
    { device = "/dev/disk/by-uuid/9feef4e3-f53c-4159-9b96-10cc546de0db"; }
  ];

  networking.hostName = "yoga16";
  networking.useDHCP = lib.mkDefault true;
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

  system.stateVersion = "25.05";

}
