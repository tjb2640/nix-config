{ pkgs, lib, ... }:

{
  
  services.ollama = {
    enable = true;
    loadModels = [ "deepseek-r1:1.5b" "dolphin3:8b" ];
    package = lib.mkDefault pkgs.ollama-cpu; # packages/nvidia.nix will set this to "-cuda
  };

  services.open-webui = {
    enable = true;
    port = 8083;
  };

}
  
