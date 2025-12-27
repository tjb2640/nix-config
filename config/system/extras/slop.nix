{ config, pkgs, lib, ... }:

# local AI-related slop research

{

  services.ollama = {
    enable = true;
    acceleration = "rocm"; # AMD
    loadModels = [ "deepseek-r1:1.5b" "dolphin3:8b" ];
  };

  services.open-webui = {
    enable = true;
    port = 8083;
  };

}
