{ pkgs, ... }:
{
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users = {
    users = {
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
  };
  home-manager.users = {
    martin = { pkgs, ... }: {
      imports = [ ];

      home.packages = with pkgs; [
        pdftk
        libreoffice
        xournal

        gimp
        inkscape

        shotwell
        rawtherapee
      ];
    };
  };
  home-manager.useGlobalPkgs = true;
  # home-manager.useUserPackages = true;
}
