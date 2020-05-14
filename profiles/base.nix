{
  imports = [
    ../modules/nix.nix
    ../modules/zsh.nix

    ./services.nix

    ./users.nix
    ./environment.nix

    ./desktop.nix
  ];
}
