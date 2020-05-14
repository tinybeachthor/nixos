{ config, pkgs, ... }:
{
  powerManagement = {
    enable = true;
    powertop.enable = true;
  };

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

    # enable powersaving manager
    tlp.enable = true;
    tlp.extraConfig = ''
      TLP_DEFAULT_MODE=BAT
      CPU_HWP_ON_BAT=power
      CPU_SCALING_GOVERNOR_ON_AC=performance
      CPU_SCALING_GOVERNOR_ON_BAT=powersave
      SATA_LINKPWR_ON_BAT="min_power med_power_with_dipm"
      CPU_MIN_PERF_ON_AC=0
      CPU_MAX_PERF_ON_AC=100
      CPU_MIN_PERF_ON_BAT=0
      CPU_MAX_PERF_ON_BAT=35
    '';
    upower.enable = true;

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
