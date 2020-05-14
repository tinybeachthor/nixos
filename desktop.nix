{ config, lib, pkgs, ... }:
{
  # User mount disks
  services.udisks2.enable = true;

  # X
  services.xserver = {
    enable = true;
    enableCtrlAltBackspace = true;

    layout = "us";
    xkbOptions = "eurosign:e, ctrl:nocaps";

    # Enable touchpad support.
    synaptics.enable = false;
    libinput = {
      enable = true;
      naturalScrolling = true;
      disableWhileTyping = true;
    };

    wacom.enable = true;

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

  services.upower.enable = true; # needed by i3status-rust

  # Sound
  sound.enable = true;
  sound.mediaKeys.enable = true;

  hardware.pulseaudio = {
    enable = true;
    package = pkgs.pulseaudio.override {
      useSystemd = true;
      systemd = pkgs.systemd;
    };
  };
  systemd.user.services.pulseaudio.enable = true;

  services.headphones.enable = true;

  # Graphics
  hardware.opengl.extraPackages = with pkgs; [
    vaapiIntel
    vaapiVdpau
    libvdpau-va-gl
  ];

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

  # Power management
  services.logind = {
    lidSwitch = "suspend-then-hibernate";
    # don’t shutdown when power button is short-pressed
    extraConfig = "HandlePowerKey=ignore";
  };
  environment.etc."systemd/sleep.conf".text = ''
    [Sleep]
    HibernateDelaySec=1h
  '';

  # Include nixos manual
  services.nixosManual.showManual = true;

  # User packages
  environment = {
    systemPackages = with pkgs; [
      i3status-rust
      conky
      xss-lock

      xclip
      xorg.xhost

      imagemagick
      vlc
      spotify
      firefox
      chromium
      gnome3.gnome-calculator
      slack
      dolphin
      breeze-icons
      thunderbird
      xterm

      hibernate
    ];
  };
}
