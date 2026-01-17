{ config, pkgs, libs, ... }:

# Device-specific plasma-manager values

{

  # `cat /proc/bus/input/devices` to find this info
  programs.plasma.input.touchpads = [
    # builtin touchpad
    {
      enable = false;
      name = "ELAN0678:00 04F3:3195 Touchpad";
      productId = "3195";
      vendorId = "04f3";
    }
  ];

  # you can't guess how long it took me to figure out i had to escape the path character
  programs.plasma.input.mice = [
    # builtin trackpoint
    {
      enable = true;
      name = "TPPS\\/2 Elan TrackPoint";
      productId = "000a";
      vendorId = "0002";
      acceleration = -0.6;
    }
  ];

}