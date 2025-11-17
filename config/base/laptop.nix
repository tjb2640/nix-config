{ config, pkgs, inputs, lib, ... }:

# Laptop computers common values

{
  imports = [ ./desktop.nix ];

  powerManagement.enable = true; # for battery status

}
