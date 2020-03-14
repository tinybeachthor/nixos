# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, lib, pkgs, ... }:
{
  imports =
    [ # Include the result the hardware scan.
      ./hardware-configuration.nix

      # Cachix package cache
      ./cachix.nix

      # System setup
      ./services.nix
      ./users.nix
      ./environment.nix

      # Customized setups
      ./desktop.nix
      # ./tablet-laptop.nix
    ];

  # Use swap device
  swapDevices = [
    { device = "/dev/disk/by-label/swap"; }
  ];

  # setup kernel
  boot.kernelPackages = pkgs.linuxPackages_latest_hardened;

  # setup kernel modules
  boot.initrd.kernelModules = [
    "nvme"		# ssd module
  ];
  boot.kernelModules = [
    "tpm-rng"	# trusted platform module RNG (hardware entropy)
    "nvme"		# ssd module

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

    "hibernate"
  ];
  boot.extraModulePackages = with config.boot.kernelPackages; [
    tp_smapi
  ];
  boot.kernelParams = [
  	"ipv6.disable=0"
    "iwlwifi.power_save=Y"
    "acpi_brightness=vendor"
    "pcie_aspm=powersave"
    "i915.enable_rc6=7" "i915.enable_psr=2" "i915.enable_fbc=1" "i915.lvds_downclock=1" "i915.semaphores=1"
  ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Select internationalisation properties.
  i18n = {
    consoleFont = "Lat2-Terminus16";
    consoleKeyMap = "us";
    defaultLocale = "en_US.UTF-8";
  };
  # Set your time zone.
  time.timeZone = "Europe/Amsterdam";

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "19.09"; # Did you read the comment?
}
