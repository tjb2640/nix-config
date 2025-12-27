{ config, pkgs, inputs, lib, ... }:

# home-manager config for desktop machines. Mostly graphical applications

{
  
  imports = [
    inputs.zen-browser.homeModules.beta
  ];

  # from the zen-browser community flake
  programs.zen-browser.enable = true;

}