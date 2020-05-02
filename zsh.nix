{ environment, pkgs, ... }:

let
  # Custom prompt
  p10k = pkgs.stdenv.mkDerivation {
    name = "p10k";
    src = pkgs.fetchFromGitHub {
      rev = "1b5ee70b3dfe670fafffabc8da0f31bbff1456a6";
      owner = "romkatv";
      repo = "powerlevel10k";
      sha256 = "1qjjkvndqxbnmgdymi0bvl8ixs1ny7bgn8kmvn6glwc09rvgdy71";
    };
    installPhase = ''
      cp -r config $out/
      cp -r internal $out/
      cp -r gitstatus $out/
      cp powerlevel10k.zsh-theme $out/
      cp prompt_powerlevel10k_setup $out/
    '';
  };
in
{
  # Enable zsh
  programs.zsh.enable = true;
  programs.zsh.enableCompletion = true;

  # Setup config
  programs.zsh.setOptions = [
    "HIST_IGNORE_ALL_DUPS"
    "SHARE_HISTORY"
    "APPEND_HISTORY"
    "HIST_FCNTL_LOCK"

    "AUTO_CD"

    "EXTENDED_GLOB"
    "NOMATCH"

    "NOTIFY"
  ];

  programs.zsh.histSize = 100000;
  programs.zsh.histFile = "$HOME/.histfile";

  environment.etc.zshenv.text = builtins.readFile ./configs/.zshrc;

  # Setup prompt
  environment.systemPackages = [
    p10k
  ];
  programs.zsh.promptInit = ''
    source ${p10k}/powerlevel10k.zsh-theme
  ''
  + builtins.readFile ./configs/.p10k.zsh +
  ''
    [[ -f $HOME/.p10k.zsh ]] && source $HOME/.p10k.zsh
  '';

  # Set zsh as default shell
  users.defaultUserShell = pkgs.zsh;
}
