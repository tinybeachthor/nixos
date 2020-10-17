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
    windowManager.i3 = {
      enable = true;
      extraPackages = with pkgs; [
        rofi
        i3status-rust
        i3lock-color

        conky    # cpu stats
        xss-lock # x sesssion locker
      ];
      package = pkgs.i3-gaps;
    };
    displayManager.defaultSession = "none+i3";
  };

  services.upower.enable = true;  # needed by i3status-rust for battery stats

  environment.systemPackages = with pkgs; [
      xclip
      xorg.xhost
  ];
}
