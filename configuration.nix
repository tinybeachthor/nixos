# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, lib, pkgs, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ./cachix.nix

    ./profiles/base.nix

    ./extras/intel.nix
    ./extras/thinkpad.nix
    ./extras/wacom.nix

    ./users.nix
    ./environment.nix
  ];

  nix.trustedUsers = [ "root" "martin" ];

  virtualisation.docker = {
    enable = true;
    enableOnBoot = false;
  };

  virtualisation.virtualbox = {
    host = {
      enable = true;
      # enableExtensionPack = true;
    };
  };

  environment.shellAliases = import ./aliases.nix;

  # Set your time zone.
  time.timeZone = "Europe/Amsterdam";

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "19.09"; # Did you read the comment?
}
