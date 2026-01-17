{ config, pkgs, inputs, lib, ... }:

# home-manager config for desktop machines. Mostly graphical applications

{
  
  imports = [
    ../../extras/zenbrowser.nix
  ];

  # link a face icon for desktop environments
  home.file.".face.icon".source = ../../../../resource/images/avatar.png;

}