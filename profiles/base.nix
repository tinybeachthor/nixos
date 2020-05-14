{
  imports = [
    ../modules/powersave.nix
    ../modules/nix.nix
    ../modules/zsh.nix

    ../services.nix

    ../users.nix
    ../environment.nix

    ../modules/fonts.nix
    ../desktop.nix
  ];

  # Setup package sources
  nixpkgs = {
    config = {
      allowUnfree = true;  # Allow proprietary packages
      allowBroken = false;

      packageOverrides = pkgs: import ../pkgs/overrides.nix { inherit pkgs; };

      # Configure packages
      firefox = {
       enableGnomeExtensions = false;
       enableGoogleTalkPlugin = false;
      };
    };
  };
}
