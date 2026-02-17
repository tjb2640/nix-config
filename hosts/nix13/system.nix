{ config, lib, modulesPath, ... }:

# Host: nix13 (my Thinkpad X13 gen 3 laptop)

{
  
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    ../../config/system/base/laptop.nix
    ../../config/system/packages/desktop/niri.nix
    ../../config/system/packages/firefox.nix
    ../../config/system/packages/gaming.nix
    ../../config/system/packages/idea.nix
    ../../config/system/packages/incus.nix
  ];

  # No need to touch below

  boot.initrd.availableKernelModules = [ "nvme" "xhci_pci" "thunderbolt" "usb_storage" "sd_mod" ];
  boot.initrd.kernelModules = [];
  boot.kernelModules = [ "kvm-amd" ];
  boot.extraModulePackages = [];

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/cc19eef7-a1d9-45fc-8bbc-591f441807cf";
    fsType = "ext4";
  };

  boot.initrd.luks.devices."luks-2f1bd7ca-b21d-4246-98ef-ca038a80a47e".device = "/dev/disk/by-uuid/2f1bd7ca-b21d-4246-98ef-ca038a80a47e";
  boot.initrd.luks.devices."luks-fa0277a9-062a-4b4c-b011-092fc1815abf".device = "/dev/disk/by-uuid/fa0277a9-062a-4b4c-b011-092fc1815abf";

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/DB8A-DB67";
    fsType = "vfat";
    options = [ "fmask=0077" "dmask=0077" ];
  };

  swapDevices = [
    { device = "/dev/disk/by-uuid/8ddfd40d-8fe1-4b70-8c1b-9d3285a9bdfc"; }
  ];

  networking.hostName = "nix13";
  networking.useDHCP = lib.mkDefault true;
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

  system.stateVersion = "25.11";

}
