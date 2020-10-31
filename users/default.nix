{ pkgs, ... }:

{
  nix.trustedUsers = [ "root" "martin" ];

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users = {
    martin = {
      extraGroups = [
        "wheel"
        "networkmanager"
        "docker"
        "audio"
        "jackaudio"
        "video"
        "vboxusers"
      ];

      home = "/home/martin";
      createHome = true;

      shell = pkgs.zsh;

      isNormalUser = true;
      uid = 1000;
    };
  };
  home-manager.users = {
    martin = { pkgs, ... }:
    {
      imports = [ ];

      xresources.properties = import ./martin/xresources.nix;

      programs = {
        zsh = import ./martin/zsh.nix { inherit pkgs; };
        direnv = {
          enable = true;
          enableZshIntegration = true;
        };
        fzf = {
          enable = true;
          enableZshIntegration = true;
          defaultCommand = "fd --type f --hidden --follow --exclude .git";
        };
        neovim = import ./martin/neovim.nix { inherit pkgs; };
        git = import ./martin/git.nix { inherit pkgs; };
        gh = {
          enable = true;
          gitProtocol = "ssh";
        };
        alacritty = import ./martin/alacritty.nix { inherit pkgs; };
      };

      home.packages = with pkgs; [
        fd  # fzf source

        gitAndTools.hub
        gitAndTools.git-absorb
        gitAndTools.git-gone
        gitAndTools.git-standup

        firefox
        xfce.thunar
        xfce.ristretto
        spotify

        libreoffice
        pdftk
        xournal
        vlc

        slack

        gimp
        inkscape
        blender

        shotwell
        rawtherapee
        shotcut
      ];
    };
  };
  home-manager.useGlobalPkgs = true;
}
