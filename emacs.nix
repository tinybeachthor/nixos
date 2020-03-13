{ pkgs ? import <nixpkgs> {} }:

let
  myEmacs = (pkgs.emacs.override {
    # Use gtk3 instead of the default gtk2
    withGTK3 = true; withGTK2 = false;
  }).overrideAttrs (attrs: {
    # I don't want emacs.desktop file because I only use emacsclient.
    postInstall = (attrs.postInstall or "") + ''
      rm $out/share/applications/emacs.desktop
    '';
  });
  emacsWithPackages = (pkgs.emacsPackagesGen myEmacs).emacsWithPackages;
in
  emacsWithPackages (epkgs:
  (with epkgs.melpaStablePackages; [
  ])
  ++ (with epkgs.melpaPackages; [
  ])
  ++ (with epkgs.elpaPackages; [
  ])
  ++ (with pkgs; [
    # From main packages set

    coreutils # basic GNU utilities
    git
    clang
    ripgrep
    fd

    material-design-icons
    ispell

    (python3.withPackages (ps: with ps; [
      pip
      setuptools
    ]))
  ]))
