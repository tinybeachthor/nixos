{
  inputs = {
    nixpkgs.url = github:NixOS/nixpkgs/nixos-20.09;
    home-manager.url = github:rycee/home-manager/release-20.09;
    my-nur.url = github:tinybeachthor/nur-packages/master;
  };
  outputs = { self, nixpkgs, home-manager, my-nur }:
  {
    nixosConfigurations.ALBATROSS = nixpkgs.lib.nixosSystem rec {
      system = "x86_64-linux";
      modules = [
        ({ nixpkgs = {
            overlays = [
              my-nur.overlay
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
