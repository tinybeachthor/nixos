{ config, lib, pkgs, ... }:
{
  imports = [
      ./fonts.nix
    ];

  # X
  services.xserver = {
    enable = true;
    enableCtrlAltBackspace = true;

    layout = "us";
    xkbOptions = "eurosign:e, ctrl:nocaps";

    # Enable pen input
    modules = [ pkgs.xf86_input_wacom ];
    wacom.enable = true;
    # Setup touch screen
    multitouch = {
      enable = true;
      invertScroll = true;
      ignorePalm = true;
    };

    # Enable touchpad support.
    synaptics.enable = false;
    libinput = {
      enable = true;
      naturalScrolling = true;
      disableWhileTyping = true;
    };

    # Display managssdm
    displayManager.sddm = {
      enable = true;
    };
    # Desktop manager
    desktopManager = {
      default = "xfce";
      xfce.enable = true;
      xterm.enable = false;
    };
    # Window manager
    windowManager.i3 = {
      enable = true;
      extraPackages = with pkgs; [
        rofi
        i3status-rust
        i3lock-color
      ];
      package = pkgs.i3-gaps;
    };
  };

  # Sound
  sound.enable = true;
  sound.mediaKeys.enable = true;
  hardware.pulseaudio.enable = false;
  services.headphones.enable = true;

  # Graphics
  hardware.opengl.extraPackages = with pkgs; [
    vaapiIntel
    vaapiVdpau
    libvdpau-va-gl
  ];

  # Display
  programs.light.enable = true;
  services.actkbd = {
    enable = true;
    bindings = [
      { keys = [ 224 ]; events = [ "key" ]; command = "/run/current-system/sw/bin/light -U 4"; }
      { keys = [ 225 ]; events = [ "key" ]; command = "/run/current-system/sw/bin/light -A 4"; }
    ];
  };
  services.redshift = {
    enable = true;
    temperature.day = 6500;
    temperature.night = 2700;
  };

  # Bluetooth
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = false;
  };

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

  # Set zsh as default shell
  programs.zsh.enable = true;
  programs.zsh.enableCompletion = true;
  programs.zsh.interactiveShellInit = ''
    export ZSH=${pkgs.oh-my-zsh}/share/oh-my-zsh/
    export ZSH_CACHE_DIR=$HOME/.cache/zsh

    # Customize your oh-my-zsh options here
    ZSH_THEME="agnoster"
    DEFAULT_USER=martin
    prompt_context(){}

    plugins=(
      git
      docker
      kubectl
      sudo
    )

    source $ZSH/oh-my-zsh.sh
  '';
  programs.zsh.promptInit = ""; # Clear this to avoid a conflict with oh-my-zsh

  # Include nixos manual
  services.nixosManual.showManual = true;

  # User packages
  environment = {
    systemPackages = with pkgs; [
      gnome3.gnome-calculator
      aspellDicts.en
      firefox
      chromium
      pdftk
      vscode
      slack
      vlc
      spotify
      simplenote
      freetype
      fontmatrix
      gparted
      breeze-icons
      imagemagick
      hibernate
      powertop
      conky
      gitkraken
      wireshark
      dolphin

      xbindkeys
      xorg.xev
      xclip
      xfontsel
      xsel
      xss-lock
      xterm
    ];
  };
}
