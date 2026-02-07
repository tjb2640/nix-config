{ config, pkgs, lib, ... }:

{
  environment.systemPackages = with pkgs; [
    jetbrains.idea-oss
  ];
}