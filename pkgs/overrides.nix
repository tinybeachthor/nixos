{ pkgs, ... }:

{
  alacritty = { config ? "", alacritty ? pkgs.alacritty }:
    pkgs.callPackage ./alacritty.nix {
      inherit alacritty;
      inherit config;
    };
}
