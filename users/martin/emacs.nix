{ pkgs
}:

{
  enable = true;

  package = pkgs.emacs-nox;

  overrides = self: super: rec {
  };

  extraPackages = (epkgs:
  (with epkgs; [
    # core
    use-package

    company
    lsp-mode
    lsp-ui
    flycheck

    which-key

    # vim
    evil
    undo-tree
    goto-chg

    # themes
    colorThemeSolarized

    # extras
    magit
    ein
  ]) ++ (with pkgs; [
  ]));
}
