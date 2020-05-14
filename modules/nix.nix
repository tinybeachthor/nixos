{
  # garbage collect old generations
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };

  # garbage collect if disk full
  nix.extraOptions = ''
    min-free = ${toString (100 * 1024 * 1024)}
    max-free = ${toString (1024 * 1024 * 1024)}
  '';

  # autoOptimiseStore
  nix.autoOptimiseStore = true;

  # better nix-shell management
  services.lorri.enable = true;
}
