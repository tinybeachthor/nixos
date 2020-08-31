{ pkgs, ... }:

{
  alacritty = { config ? "", alacritty ? pkgs.alacritty }:
    pkgs.callPackage ./alacritty.nix {
      inherit alacritty;
      inherit config;
    };
  neovim = { config ? "", neovim ? pkgs.neovim }:
    pkgs.callPackage ./neovim.nix {
      inherit neovim;
      inherit config;
    };
  jlink = pkgs.callPackage ./jlink.nix { };
  operator-sdk = pkgs.callPackage ./operator-sdk.nix { };

  vimPlugins = pkgs.vimPlugins // {
    distilled-vim =
      pkgs.callPackage ./distilled-vim.nix {
        buildVimPluginFrom2Nix = pkgs.vimUtils.buildVimPluginFrom2Nix;
      };
    vim-mdx-js =
      pkgs.callPackage ./vim-mdx-js.nix {
        buildVimPluginFrom2Nix = pkgs.vimUtils.buildVimPluginFrom2Nix;
      };
  };
}
