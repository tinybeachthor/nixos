{ pkgs, ... }:

{
  # Install the flakes edition
  nix.package = pkgs.nixFlakes;
  # Enable the nix 2.0 CLI and flakes support feature-flags
  # Garbage collect if disk full
  nix.extraOptions = ''
    experimental-features = nix-command flakes
    min-free = ${toString (100 * 1024 * 1024)}
    max-free = ${toString (1024 * 1024 * 1024)}
  '';

  # Garbage collect old generations
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };

  # AutoOptimiseStore
  nix.autoOptimiseStore = true;

  # Better nix-shell management
  services.lorri.enable = true;
}
