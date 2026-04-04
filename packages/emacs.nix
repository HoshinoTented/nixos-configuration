{ pkgs }:

let
  emacs = pkgs.emacs;
  emacsWithPkgs = (pkgs.emacsPackagesFor emacs).emacsWithPackages;
in

emacsWithPkgs (
  epkgs: with epkgs.melpaPackages; [ nix-mode ]
)