# My NixOS

## Repo structure

```
/
  .config/         # Non-nix config files
    ...

  pkgs/            # Custom & overridden pkgs
    overrides.nix  # Exports all pkgs
    ...

  modules/         # Standalone tidbits
    ...

  profiles/        # Full system configs
    base.nix
    ...

  extras/          # Standalone extras (not included in any profiles)
    ...

  cachix/
  cachix.nix
  hardware-configuration.nix
  configuration.nix
```

## Usage

1. Generate `hardware-configuration.nix` for your system
2. Edit your `configuration.nix` to import your chosen profile from `profiles/`
   (do not change `system.stateVersion`)
3. Import stuff you like from `extras/`

See `configuration.nix` for an example configuration.

