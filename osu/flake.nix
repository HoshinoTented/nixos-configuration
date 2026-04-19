{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        libwebkit = pkgs.webkitgtk_4_1;
      in
      {
        devShells.default = with pkgs; mkShell {
          buildInputs = [ steam-run libwebkit ];
          LD_LIBRARY_PATH = lib.makeLibraryPath [ libwebkit ];
        };
      } 
    );
}