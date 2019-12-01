{ neovim, pkgs, stdenv }:

let
  vimrc = builtins.readFile (./neovim.vim);

  python3Packages = packages: with packages; [
    pylint
    jedi
    black
  ];
in
  neovim.override {

  vimAlias = true;
  viAlias = true;

  withPython = true;
  withPython3 = true;
  withNodeJs = true;

  extraPython3Packages = python3Packages;

  configure = {
    customRC = vimrc;
    packages.myVimPackages = with pkgs.vimPlugins; {
      start = [
       # core
       auto-pairs
       vim-obsession
       vim-commentary
       vim-repeat
       vim-unimpaired
       vim-surround
       ferret
       vim-trailing-whitespace

       # lsp
       coc-nvim
       coc-denite
       coc-lists
       coc-pairs

       # files
       fzf-vim
       vim-eunuch
       vim-vinegar

       # git
       vim-fugitive
       vim-gitgutter

       # look
       vim-airline
       NeoSolarized

       # languages
       vim-nix
       vim-javascript
       vim-jsx-pretty
       haskell-vim
       vim-go
       Jenkinsfile-vim-syntax
     ];
     opt = [
       # coc lsp

       coc-highlight
       coc-git

       coc-yaml
       coc-css
       coc-json
       coc-vimtex

       coc-tsserver
       coc-eslint
       coc-python
       coc-go
       coc-java
     ];
   };
 };
}
