{ config, pkgs, lib, ... }:

{
  imports = [
    ../modules/systemd-boot.nix
    ../modules/powersave.nix
    ../modules/hibernate.nix
    ../modules/nix.nix
    ../modules/networking.nix
    ../modules/physical-security.nix

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

  # Security
  security.allowUserNamespaces = true;
  boot.kernel.sysctl."kernel.unprivileged_userns_clone" = 1;

  security.chromiumSuidSandbox.enable = false;

  # Services
  location.provider = "geoclue2";

  services = {
    # SSD block reclamation service
    fstrim.enable = true;
  };

  # Internationalisation
  i18n.defaultLocale = lib.mkDefault "en_US.UTF-8";
  console.font       = lib.mkDefault "Lat2-Terminus16";
  console.keyMap     = lib.mkDefault "us";
}
