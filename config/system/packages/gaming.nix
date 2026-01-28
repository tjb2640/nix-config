{ config, pkgs, lib, ... }:

# Specifies gaming-related packages

{

  # Steam
  programs.steam = {
    enable = true;
    extraCompatPackages = with pkgs; [ proton-ge-bin ]; # give us the good proton
    dedicatedServer.openFirewall = true;
    gamescopeSession.enable = true;
    localNetworkGameTransfers.openFirewall = true;
    remotePlay.openFirewall = true;
  };

  users.users.ty.packages = with pkgs; [
    prismlauncher   # Minecraft launcher
    wl-clipboard    # `wl-copy --clear` before launching steam while using niri will allow steam to launch!
                    # Issue with xwayland-satellite unwrap()ping something from the clipboard in rust
  ];
  
}
