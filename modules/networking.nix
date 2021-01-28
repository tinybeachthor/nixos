{ config, pkgs, ... }:

{
  networking = {
    networkmanager.enable = true;
    firewall.enable = true;
  };

  services = {
    # network configuration
    avahi = {
      enable = true;
      nssmdns = true;
    };
  };
}
