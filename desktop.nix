{ config, lib, pkgs, ... }:
{
  # User mount disks
  services.udisks2.enable = true;

  services.actkbd = with pkgs; {
    enable = true;
    bindings = [
      # Display
      { keys = [ 224 ]; events = [ "key" ];
        command = "/run/current-system/sw/bin/light -U 5"; }
      { keys = [ 225 ]; events = [ "key" ];
        command = "/run/current-system/sw/bin/light -A 5"; }
    ];
  };

  # Display
  programs.light.enable = true;
  # services.redshift = {
  #   enable = true;
  #   temperature.day = 6500;
  #   temperature.night = 2700;
  # };

  # Trackpoint
  hardware.trackpoint = {
    enable = true;
    emulateWheel = true;
  };
}
