{
  inputs = {
    nixpkgs.url = github:NixOS/nixpkgs/nixos-20.09;
    home-manager = {
      url = github:rycee/home-manager/release-20.09;
      inputs.nixpkgs.follows = "nixpkgs";
    };
    tinybeachthor = {
      url = github:tinybeachthor/nur-packages/master;
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = { self, nixpkgs, home-manager, tinybeachthor }:
  {
    nixosConfigurations.ALBATROSS = nixpkgs.lib.nixosSystem rec {
      system = "x86_64-linux";
      modules = [
        ({
          nixpkgs = {
            overlays = [ tinybeachthor.overlay ];
            config = { allowUnfree = true; allowBroken = false; };
          };
          nix.registry.nixpkgs.flake = nixpkgs;

          networking.hostName = "ALBATROSS";
        })
        ./hardware-configuration.nix
        ./cachix.nix

        ./profiles/base.nix

        ./extras/intel.nix
        ./extras/thinkpad.nix
        ./extras/wacom.nix

        home-manager.nixosModules.home-manager
        ./users
        ./environment.nix

        ({
          virtualisation.docker = {
            enable = true;
            enableOnBoot = false;
          };

          # Set your time zone.
          time.timeZone = "Europe/Amsterdam";

          # This value determines the NixOS release with which your system is to be
          # compatible, in order to avoid breaking some software such as database
          # servers. You should change this only after NixOS release notes say you
          # should.
          system.stateVersion = "19.09"; # Did you read the comment?
        })
      ];
    };
  };
}
