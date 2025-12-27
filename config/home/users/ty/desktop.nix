{ config, pkgs, inputs, lib, ... }:

# home-manager config for desktop machines. Mostly graphical applications

{
  
  imports = [
    ../../extras/zenbrowser.nix
  ];

}