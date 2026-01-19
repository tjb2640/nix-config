{ pkgs, inputs, ... }:

# File for enabling udiskie, using this with niri
# udisks2 is enabled in the system wm/niri config
{

  services.udiskie = {
    enable = true;
    settings = {
        program_options = {
            file_manager = "${pkgs.nemo-with-extensions}/bin/nemo";
        };
    };
  };

}

