{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils, ... }:
    let
      # TODO: figure out which platforms prismterminal supports
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; config.allowUnfree = true; };
      libwebkit = pkgs.webkitgtk_4_1;
      prism = pkgs.callPackage ./package.nix {};
    in
    {
      packages.${system}.default = prism;

      nixosModules = rec {
        prismterminal = import ./nixos prism;
        default = prismterminal;
      };

      devShells.${system}.default = with pkgs; mkShell {
        buildInputs = [ libwebkit ];
        LD_LIBRARY_PATH = lib.makeLibraryPath [ libwebkit ];
      };
    };
}
