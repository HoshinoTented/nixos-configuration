This file are some possible issues and solutions when playing osu.

## How do I run MeowpadConfiguratorForV2?

The common issue is missing `webkit2gtk4.1`, which can be solved by:
* Install `steam-run` (you need `.allowUnfree = true` for this)
* Run `nix-shell -p webkitgtk_4_1` or install `webkitgtk_4_1` in your prefer manner (nixos configuration, flake or whatever)
* Find the derivation path by evaluating `webkitgtk_4_1` in `nix repl -f "<nixpkgs>"`.
* Then run `LD_LIBRARY_PATH="<PATH_TO_WEBKITGTK_4_1>/lib" steam-run /path/to/meowpadconfigurator`.

> This only work on `.deb` package of MeowpadConfigurator. `.AppImage` still got the error even `webkit2gtk4.1` is bundled in the package. 

## My cursor doesn't reponse when playing in fullscreen

Use X11 instead of Wayland.