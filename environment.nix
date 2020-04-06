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

  # Add packages to environment
  environment = {
    systemPackages = with pkgs;
    let
      core-packages = [
        (pkgs.callPackage ./neovim.nix {
          neovim = unstable.neovim;
        })

        acpi
        htop

        alacritty

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
        git-hub
        gitAndTools.git-annex
        gitAndTools.git-standup
        gitAndTools.git-absorb
        gitAndTools.git-gone

        ispell

        direnv
        nixfmt

        httpie
        cloc

        docker
        virtualbox
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
