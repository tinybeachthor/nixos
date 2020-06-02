{ config, pkgs, ... }:

{
  networking = {
    hostName = "ALBATROSS";
    networkmanager.enable = true;
    firewall.enable = true;
  };

  location.provider = "geoclue2";

  services = {
    # SSD block reclamation service
    fstrim.enable = true;

    # usbguard - BadUSB protection
    usbguard = {
      enable = true;
      # Non-GUI package
      package = pkgs.usbguard-nox;
    };

    # network configuration
    avahi = {
      enable = true;
      nssmdns = true;
    };
  };
}
