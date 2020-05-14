{ config, pkgs, ... }:
{
  hardware = {
    enableAllFirmware = true;
    enableRedistributableFirmware = true;

    cpu.intel.updateMicrocode = config.hardware.enableRedistributableFirmware;
  };

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

  # Docker
  virtualisation.docker = {
    enable = true;
    enableOnBoot = false;
  };

  # # VirtualBox
  # virtualisation.virtualbox = {
  #   host = {
  #     enable = true;
  #     # enableExtensionPack = true;
  #   };
  # };
}
