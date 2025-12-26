{ input, pkgs, libs, ... }:

# Testing out plymouth theming 12/25

let 
  plymouth-theme-rbsys = pkgs.callPackage ../../overlays/system/plymouth/plymouth-theme-rbsys/default.nix {};
in
{

  users.users.ty.packages = with pkgs; [
    plymouth-theme-rbsys
  ];

  boot = {
    plymouth = {
      enable = true;
      theme = "rbsys";
      themePackages = [ plymouth-theme-rbsys ];
    };

    # other plymouth-related things
    consoleLogLevel = 3;
    initrd.verbose = false;
    kernelParams = [
      "quiet"
      "splash"
      "boot.shell_on_fail"
      "udev.log_priority=3"
      "rd.systemd.show_status=auto"
    ];
    loader.timeout = 0;
  };
}