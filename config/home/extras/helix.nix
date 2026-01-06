{ cfg, inputs, pkgs, lib, ... }:

# Enable helix editor and associated home-manager settings

{
  programs.helix = {
    enable = true;
    settings = {
      editor = {
        cursor-shape = {
          normal = "block";
          insert = "bar";
          select = "underline";
        };
      };
      theme = "autumn_night_transparent";
    };
    languages.language = [{
      auto-format = true;
      formatter.command = lib.getExe pkgs.nixfmt-rfc-style;
      name = "nix";
    }];
    themes = {
      autumn_night_transparent = {
        "inherits" = "autumn_night";
        "ui.background" = { };
      };
    };
  };
}
