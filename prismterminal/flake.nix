{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        libwebkit = pkgs.webkitgtk_4_1;
      in
      {
        packages = {
          prismaterminal = pkgs.callPackage ./package.nix {};
        };

        devShells.default = with pkgs; mkShell {
          buildInputs = [ libwebkit ];
          LD_LIBRARY_PATH = lib.makeLibraryPath [ libwebkit ];
        };
      } 
    );
}
