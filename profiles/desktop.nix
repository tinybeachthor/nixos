{ config, lib, pkgs, ... }:

{
  imports = [
    ./base.nix

    ../modules/powersave.nix
    ../modules/hibernate.nix
    ../modules/i3.nix
    ../modules/sound.nix
    ../modules/fonts.nix
  ];

  # User mount disks
  services.udisks2.enable = true;

  # Brightness
  programs.light.enable = true;
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

  # Trackpoint
  hardware.trackpoint = {
    enable = true;
    emulateWheel = true;
  };
}
