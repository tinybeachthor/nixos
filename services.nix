{ config, pkgs, ... }:

{
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
  };
}
