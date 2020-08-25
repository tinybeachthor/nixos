{ pkgs, ... }:

let
  smosModule = (builtins.fetchGit {
    url = "https://github.com/NorfairKing/smos";
    ref = "master";
    rev = "b3587542b07e682789f98367e7a7dc3ea57bd9bf";
  } + "/nix/program.nix");
in
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
      imports = [
        smosModule
      ];

      programs.smos = {
        enable = true;
        extraConfig = ''
          workflow-dir: "/home/martin/.smos/workflow"
        '';
      };

      home.packages = with pkgs; [ ];
    };
  };

  home-manager.useGlobalPkgs = true;
  # home-manager.useUserPackages = true;
}
