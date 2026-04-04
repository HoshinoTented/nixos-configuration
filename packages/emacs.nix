{ pkgs, ... }:

let
  emacsWithPkgs = (pkgs.emacsPackagesFor pkgs.emacs).emacsWithPackages;
  myEmacs = emacsWithPkgs (
    epkgs: with epkgs.melpaPackages; [ nix-mode ]
  );
in
{
  environment.systemPackages = [ myEmacs ];

  # Emacs service
  services.emacs = {
    enable = true;
    defaultEditor = true;
    package = myEmacs;
  };
}