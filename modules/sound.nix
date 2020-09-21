{ config, lib, pkgs, ... }:
{
  sound.enable = true;
  sound.mediaKeys.enable = true;

  boot.kernelModules = [ "snd-seq" "snd-rawmidi" ];

  hardware.pulseaudio = {
    enable = true;
    package = pkgs.pulseaudio.override {
      jackaudioSupport = true;
    };
  };
  systemd.user.services.pulseaudio = {
    enable = true;
    environment = {
      JACK_PROMISCUOUS_SERVER = "jackaudio";
    };
  };

  services.jack = {
    jackd.enable = true;
    # support ALSA only programs via ALSA JACK PCM plugin
    alsa.enable = false;
    # support ALSA only programs via loopback device (supports programs like Steam)
    loopback = {
      enable = true;
      # buffering parameters for dmix device to work with ALSA only semi-professional sound programs
      #dmixConfig = ''
      #  period_size 2048
      #'';
    };
  };

  services.headphones.enable = true;
}
