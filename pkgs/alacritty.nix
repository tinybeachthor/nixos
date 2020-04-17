{ pkgs, lib, alacritty, config }:

let
  escape = list: lib.replaceChars list (map (c: "\\${c}") list);
  config-escaped = escape ["`"] config;
in
  pkgs.runCommand "alacritty" {
    buildInputs = [ pkgs.makeWrapper ];
  } ''
    mkdir $out
    # Link every top-level dir to our new target
    ln -s ${alacritty}/* $out
    # Except the bin dir
    rm $out/bin
    mkdir $out/bin
    # We create the bin dir ourselves and link every binary in it
    ln -s ${alacritty}/bin/* $out/bin
    # Except the program binary
    rm $out/bin/alacritty
    # Because we create this ourself, by creating a wrapper
    makeWrapper ${alacritty}/bin/alacritty $out/bin/alacritty \
      --add-flags "--no-live-config-reload" \
      --add-flags "--config-file $out/alacritty.yml" \
      --set "WINIT_HIDPI_FACTOR" "1" \
      --set "WINIT_X11_SCALE_FACTOR" "1"

    # Write config file
    cat >> $out/alacritty.yml <<EOL
    ${config-escaped}
    EOL
  ''
