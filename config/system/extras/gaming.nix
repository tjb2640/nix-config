{ config, pkgs, lib, ... }:

# Specifies gaming-related packages

{

  # Enables some temporary performance tweaks when run
  programs.gamemode.enable = true;

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
    desmume          # DS emu
    dolphin-emu      # GC/Wii emu
    gamepad-tool     #
    mupen64plus      # N64 emu
    nanoboyadvance   # GBA emu
    prismlauncher    # Minecraft launcher
    wl-clipboard     # `wl-copy --clear` before launching steam while using niri will allow steam to launch!
                     # i do not know why this is a problem!
    zsnes            # SNES emu
  ];
  
}
