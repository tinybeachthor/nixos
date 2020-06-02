{ config, lib, pkgs, ... }:

{
  services.xserver = {
    enable = true;
    enableCtrlAltBackspace = true;

    layout = config.console.keyMap;         # Use same keyMap as console
    xkbOptions = "eurosign:e, ctrl:nocaps"; # CapsLock is Ctrl

    # Enable touchpad support.
    libinput = {
      enable = true;
      naturalScrolling = true;
      disableWhileTyping = true;
    };
    synaptics.enable = false;

    # Desktop
    desktopManager = {
      xfce.enable = true;
      xterm.enable = false;
    };
    windowManager.i3 = {
      enable = true;
      extraPackages = with pkgs; [
        rofi
        i3status-rust
        i3lock-color
      ];
      package = pkgs.i3-gaps;
    };
    displayManager = {
      sddm.enable = true;
    };
    displayManager.defaultSession = "none+i3";
  };

  services.upower.enable = true; # needed by i3status-rust for battery stats

  environment.systemPackages = with pkgs; [
      # i3status-rust utils
      conky    # cpu stats

      xss-lock # x sesssion locker

      # x utils
      xclip
      xorg.xhost
  ];
}
