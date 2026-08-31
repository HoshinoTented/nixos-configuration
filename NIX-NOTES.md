## Flake

When using flake as system configuration, you should use nix commands (which uses flake inputs)
instead of `nix-` commands (which uses `nix-channel`):
* `nix shell nixpkgs#hello` <----- `nix-shell -p hello`
* `nix repl nixpkgs` then use `legacyPackages.${builtins.currentSystem}` <----- `nix repl -f "<nixpkgs>"`
* Use `nix search nixpkgs hello` to search packages (although I still prefer searching on website)

You can use `:lf .` in `nix repl` to enter the output of a flake.

## NixOS Updating

Use `nix flake update` to update nixpkgs.
Use `nix-collect-garbage --delete-older-than <period>` (you can use `30d`) to delete old packages, if you run this command as root, it will also delete system genertions that older than the period.