{ config, pkgs, lib, ... }:

{
  imports = [
    ../modules/systemd-boot.nix
    ../modules/powersave.nix
    ../modules/hibernate.nix
    ../modules/nix.nix

    ../services.nix

    ../modules/fonts.nix
    ../desktop.nix
    ../modules/i3.nix
    ../modules/sound.nix
  ];

  # Kernel
  boot.kernelPackages = pkgs.linuxPackages_latest_hardened;

  boot.kernelModules = [
    "tpm-rng"	# Trusted Platform Module RNG (hardware entropy)
  ];
  boot.kernelParams = [
    "ipv6.disable=0"
  ];

  # Internationalisation
  i18n.defaultLocale = lib.mkDefault "en_US.UTF-8";
  console.font       = lib.mkDefault "Lat2-Terminus16";
  console.keyMap     = lib.mkDefault "us";
}
