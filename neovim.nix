{ neovim, pkgs, stdenv }:

let
  vimrc = builtins.readFile ./neovim.vim;

  python3Packages = packages: with packages; [
    jedi
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
       vim-commentary
       vim-unimpaired
       vim-surround
       vim-repeat
       ferret
       vim-trailing-whitespace
       vim-signature

       coc-nvim

       vimwiki

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
       typescript-vim
       haskell-vim
       vim-go
       Jenkinsfile-vim-syntax
     ];
     opt = [
       coc-pairs
       coc-lists
       coc-highlight
       coc-snippets
       coc-smartf
       coc-git
       coc-yaml
       coc-json
       coc-vimtex
     ];
   };
 };
}
