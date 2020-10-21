{
  inputs = {
    nixpkgs.url = github:NixOS/nixpkgs/nixos-20.09;
    home-manager.url = github:rycee/home-manager/release-20.09;
    tinybeachthor.url = github:tinybeachthor/nur-packages/master;
  };
  outputs = { self, nixpkgs, home-manager, tinybeachthor }:
  {
    nixosConfigurations.ALBATROSS = nixpkgs.lib.nixosSystem rec {
      system = "x86_64-linux";
      modules = [
        ({ nixpkgs = {
            overlays = [
              tinybeachthor.overlay
            ];
            config = {
              allowUnfree = true;
              allowBroken = false;
              packageOverrides = pkgs: import ./pkgs/overrides.nix { inherit pkgs; };
            };
          };
        })
        ./configuration.nix
        home-manager.nixosModules.home-manager
      ];
    };
  };
}
