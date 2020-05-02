{ pkgs, ... }:

let
  unstable = import <nixpkgs-unstable> {};
in
{
  # Setup package sources
  nixpkgs = {
    config = {
      # Allow proprietary packages
      allowUnfree = true;
      allowBroken = false;

      # # Overrides
      # packageOverrides = pkgs: {
      #   nur = import (builtins.fetchTarball
      #   "https://github.com/nix-community/NUR/archive/master.tar.gz") {
      #     inherit pkgs;
      #   };
      # };

      # Configure packages
      firefox = {
       enableGnomeExtensions = false;
       enableGoogleTalkPlugin = false;
      };
    };
  };

  # Enable program extensions
  programs.gnupg.agent.enable = true;

  # Add packages to environment
  environment = {
    systemPackages = with pkgs;
    let
      core-packages = [
        (pkgs.callPackage ./pkgs/alacritty.nix {
          alacritty = unstable.alacritty;
          config = builtins.readFile ./configs/alacritty.yml;
        })
        (pkgs.callPackage ./pkgs/neovim.nix {
          neovim = unstable.neovim;
          config = builtins.readFile ./configs/neovim.vim;
        })

        acpi
        htop

        bat
        exa
        bash
        binutils
        coreutils
        psmisc
        tldr
        lsof

        which
        fd
        file
        findutils
        fzf
        ripgrep
        jq

        zip
        unrar
        unzip
        p7zip

        wget
        rsync
        curl
        iputils
        inetutils

        # backup
        gitFull
        gitAndTools.git-annex
        gitAndTools.gitRemoteGcrypt
        rsync
        bup
      ];
      crypt-packages = [
        cryptsetup
        git-crypt
        gnupg1
        kbfs
        keybase
        keybase-gui
      ];
      development-packages = [
        gitFull
        gitAndTools.git-hub
        gitAndTools.hub
        gitAndTools.git-standup
        gitAndTools.git-absorb
        gitAndTools.git-gone

        ispell

        direnv
        haskellPackages.niv
        nixfmt

        httpie
        cloc
      ];
    in
      core-packages
      ++ crypt-packages
      ++ development-packages;

    variables.TERMINAL = "xterm";
    variables.TERM = "xterm";

    variables.EDITOR = "nvim";
    variables.VISUAL = "nvim";

    variables.QT_QPA_PLATFORMTHEME = "qt5ct";
  };
}
