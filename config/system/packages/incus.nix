{ ... }:

# Enable Incus (LXD replacement)
# TODO: https://wiki.nixos.org/wiki/Incus

{
  
  networking.nftables.enable = true;
  
  users.users.ty.extraGroups = [
    "incus-admin"
  ];
  
  virtualisation.incus.enable = true;

}
