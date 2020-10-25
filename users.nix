{ pkgs, ... }:

{
  nix.trustedUsers = [ "root" "martin" ];

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users = {
    martin = {
      extraGroups = [
        "wheel"
        "networkmanager"
        "docker"
        "audio"
        "jackaudio"
        "video"
        "vboxusers"
      ];

      home = "/home/martin";
      createHome = true;

      isNormalUser = true;
      uid = 1000;
    };
  };
  home-manager.users = {
    martin = { pkgs, ... }: {
      imports = [ ];

      home.packages = with pkgs; [
        dolphin
        breeze-icons
        xfce.thunar

        firefox
        chromium

        pdftk
        libreoffice
        xournal
        vlc
        xfce.ristretto

        thunderbird
        slack

        spotify

        gimp
        inkscape
        blender

        shotwell
        rawtherapee
        shotcut
      ];
    };
  };
  home-manager.useGlobalPkgs = true;
}
