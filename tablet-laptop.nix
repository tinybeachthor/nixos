{ config, lib, pkgs, ... }:
{
  # Rotate screen on mode switch
  services.acpid = {
    enable = true;
    handlers = {
      tablet-mode = {
        event = "video/tabletmode TBLT 0000008A 00000001";
        action = ''
          su martin -c 'onboard'
          su martin -c 'xrandr -d ":0" --output eDP-1 -o left'
        '';
      };
      laptop-mode = {
        event = "video/tabletmode TBLT 0000008A 00000000";
        action = ''
          su martin -c 'xrandr -d ":0" --output eDP-1 -o normal'
        '';
      };
    };
  };

  environment.systemPackages = with pkgs; [
    # Onscreen keyboard
    onboard
  ];
}
