{ pkgs, lib, ... }:

{
  imports = [
    ../modules/systemd-boot.nix
    ../modules/powersave.nix
    ../modules/nix.nix
    ../modules/zsh.nix

    ../services.nix

    ../environment.nix

    ../modules/fonts.nix
    ../desktop.nix
  ];

  config = {
    # Kernel
    boot.kernelPackages = pkgs.linuxPackages_latest_hardened;

    boot.kernelModules = [
      "tpm-rng"	# trusted platform module RNG (hardware entropy)

      "hibernate"
    ];
    boot.kernelParams = [
      "ipv6.disable=0"
    ];

    # Setup package sources
    nixpkgs = {
      config = {
        allowUnfree = true;  # Allow proprietary packages
        allowBroken = false;

        packageOverrides = pkgs: import ../pkgs/overrides.nix { inherit pkgs; };
      };
    };

    # Internationalisation
    i18n.defaultLocale = lib.mkDefault "en_US.UTF-8";
    console.font       = lib.mkDefault "Lat2-Terminus16";
    console.keyMap     = lib.mkDefault "us";
  };
}
