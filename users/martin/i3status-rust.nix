{}:

{
  enable = true;

  theme = "modern";
  icons = "awesome";
  settings = {
    theme.overrides = {
      separator = "   ";
      separator_fg = "#222D32";
      separator_bg = "#222D32";
    };
  };

  blocks = [
    {
      block = "music";
      player = "spotify";
      marquee = false;
      smart_trim = true;
      max_width = 32;
      buttons = ["prev", "play", "next"];
      hide_when_empty = true;
    }
    {
      block = "docker";
      interval = 10;
      format = "{running}/{total}/{images}";
    }
    {
      block = "disk_space";
      path = "/nix";
      alias = "N";
      interval = 60;
    }
    {
      block = "disk_space";
      path = "/";
      alias = "/";
      interval = 60;
    }
    {
      block = "memory";
      display_type = "memory";
      format_mem = "{Mup}%";
      format_swap = "{SUp}%";
    }
    {
      block = "cpu";
      interval = 1;
      format = "{utilization}% {frequency}GHz";
      info = 50;
      warning = 70;
      critical = 90;
    }
    {
      block = "net";
      device = "wlp2s0";
      interval = 5;
      format = "{signal_strength} {ssid} {ip}";
    }
    {
      block = "sound";
      driver = "pulseaudio";
    }
    {
      block = "battery";
      driver = "upower";
      format = "{percentage}% {time}";
    }
    {
      block = "pomodoro";
      length = 20;
      break_length = 5;
      use_nag = false;
    }
    {
      block = "time";
      interval = 60;
      format = "%a %d/%m %R";
    }
  ];
}
