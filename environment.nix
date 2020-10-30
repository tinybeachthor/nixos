{ pkgs, ... }:

{
  # Enable program extensions
  programs.gnupg.agent.enable = true;

  # Add packages to environment
  environment = {
    systemPackages = with pkgs;
    let
      core-packages = [
        neovim

        cachix

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
        vifm
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
        gitAndTools.hub
        gitAndTools.git-standup
        gitAndTools.git-absorb
        gitAndTools.git-gone

        ispell
        aspellDicts.en

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
