## Flake

When using flake as system configuration, you should use nix commands (which uses flake inputs)
instead of `nix-` commands (which uses `nix-channel`):
* `nix shell nixpkgs#hello` <----- `nix-shell -p hello`
* `nix repl nixpkgs.legacyPackages.{your system}` <----- `nix repl -f "<nixpkgs>"`
* Use `nix search nixpkgs hello` to search packages (although I still prefer searching on website)