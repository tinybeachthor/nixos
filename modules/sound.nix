{ config, lib, pkgs, ... }:
{
  sound.enable = true;
  sound.mediaKeys.enable = true;

  hardware.pulseaudio = {
    enable = true;
    package = pkgs.pulseaudio.override {
      useSystemd = true;
      systemd = pkgs.systemd;
    };
  };
  systemd.user.services.pulseaudio.enable = true;

  services.headphones.enable = true;
}
