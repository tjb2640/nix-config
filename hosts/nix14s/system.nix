{ config, pkgs, inputs, lib, ... }:

# Host: nix14s (my Thinkpad P14s laptop)

{
  
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    ../../config/base/laptop.nix
    ../../config/packages/desktop/plasma.nix
    ../../config/packages/firefox.nix
    ../../config/packages/gaming.nix
    ../../config/packages/nvidia.nix
  ];

  # System-specific NVidia options
  # https://nixos.wiki/wiki/Nvidia
  hardware.nvidia = {
    prime = {
      sync.enable = true;
      # sudo lshw -c display
      intelBusId = "PCI:0:2:0";
      nvidiaBusId = "PCI:45:0:0";
    };
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  # No need to touch below

  boot.initrd.availableKernelModules = [ "xhci_pci" "nvme" "usbhid" "usb_storage" "sd_mod" "rtsx_pci_sdmmc" ];
  boot.initrd.kernelModules = [];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [];

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/9a878c99-7018-4bac-bb59-fc1fcab2ac68";
    fsType = "ext4";
  };

  boot.initrd.luks.devices."luks-4b327bf7-5c8b-46ca-aa64-f71cae9b317c".device = "/dev/disk/by-uuid/4b327bf7-5c8b-46ca-aa64-f71cae9b317c";
  boot.initrd.luks.devices."luks-13d2ad5e-9021-4597-a2bf-ea0479eda9a6".device = "/dev/disk/by-uuid/13d2ad5e-9021-4597-a2bf-ea0479eda9a6";
  
  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/9904-8840";
    fsType = "vfat";
    options = [ "fmask=0077" "dmask=0077" ];
  };

  swapDevices = [
    { device = "/dev/disk/by-uuid/52cab943-f0f1-4963-a422-dc19827bd8ba"; }
  ];

  networking.hostName = "nix14s";
  networking.useDHCP = lib.mkDefault true;
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

  system.stateVersion = "25.11";

}
