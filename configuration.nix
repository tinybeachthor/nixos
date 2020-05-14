# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, lib, pkgs, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ./cachix.nix

    ./profiles/base.nix
  ];

  environment = {
    shellAliases = import ./aliases.nix;
  };

  # Kernel
  boot.kernelPackages = pkgs.linuxPackages_latest_hardened;
  boot.kernelModules = [
    "tpm-rng"	# trusted platform module RNG (hardware entropy)
    "nvme"		# ssd module

    "hibernate"

    # intel
    "i915" 		  # intel graphics
    "kvm-intel"	# kernel-based virtual machine
    "coretemp"	# intel cpu temperature reading

    # thinkpad
    "tp_smapi"
    "acpi_call"

    # USB
    "xhci_pci"	    # USB3 module
    "usb_storage" 	# USB mass storage
    "rtsx_pci_sdmmc"
  ];
  boot.extraModulePackages = with config.boot.kernelPackages; [
    tp_smapi
    acpi_call
  ];
  boot.kernelParams = [
    "ipv6.disable=0"
  ];
  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot = {
    enable = true;
    editor = false;
  };
  boot.loader.efi.canTouchEfiVariables = true;

  # Select internationalisation properties.
  i18n = {
    defaultLocale = "en_US.UTF-8";
  };
  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };
  # Set your time zone.
  time.timeZone = "Europe/Amsterdam";

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "19.09"; # Did you read the comment?
}
