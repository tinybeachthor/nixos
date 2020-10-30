{ pkgs, ... }:

{
  enable = true;
  package = pkgs.gitFull;

  userName = "Martin Toman";
  userEmail = "toman.martin@live.com";
  signing = null;

  ignores = [
    "Session.vim"
    "*.un~"
    "*.swp"
    ".vim/"
    "NetrwTreeListing"

    ".direnv/"

    "tags"
    ".ccls-cache/"
  ];

  extraConfig = {
    core = { };
    rerere = { enabled = true; };

    merge = { tool = "vimdiff"; };
    diff = { tool = "vimdiff"; };
  };
}
