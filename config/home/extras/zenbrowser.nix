{ config, pkgs, inputs, lib, ... }:

# Enables the zen browser and adds some extensions and things

{

  imports = [
    inputs.zen-browser.homeModules.beta
  ];

  programs.zen-browser.enable = true;

}