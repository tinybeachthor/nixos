{
  inputs = {
    nixpkgs.url = github:NixOS/nixpkgs/nixos-20.09;
    home-manager.url = github:rycee/home-manager/release-20.09;
  };
  outputs = { self, nixpkgs, home-manager }: {
    nixosConfigurations.ALBATROSS = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./configuration.nix
        home-manager.nixosModules.home-manager
      ];
    };
  };
}
