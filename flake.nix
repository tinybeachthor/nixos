{
  inputs = {
    nixpkgs.url = github:NixOS/nixpkgs/nixos-20.09;
    home-manager.url = github:rycee/home-manager/release-20.09;

    my-nur.url = github:tinybeachthor/nur-packages/master;
    my-nur.inputs.nixpkgs.follows = "nixpkgs";
  };
  outputs = { self, nixpkgs, home-manager, my-nur }:
  {
    nixosConfigurations.ALBATROSS = nixpkgs.lib.nixosSystem rec {
      pkgs = import nixpkgs {
        inherit system;
        overlays = [
          (final: prev: with my-nur.packages.${system}; {
             inherit vimPlugins;
          })
        ];
        config = {
          allowUnfree = true;
        };
      };
      system = "x86_64-linux";
      modules = [
        ./configuration.nix
        home-manager.nixosModules.home-manager
      ];
    };
  };
}
