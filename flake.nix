{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    home-manager.url = "github:nix-community/home-manager/release-26.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    prismterminal = {
      url = "path:/home/hoshino/.config/nixos/prismterminal";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, prismterminal, ... }: {
    nixosConfigurations."hoshino-nix" = nixpkgs.lib.nixosSystem {
      specialArgs = { inherit home-manager; };
      modules = [
        ./configuration.nix
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users."hoshino" = ./hoshino.nix;
          home-manager.backupFileExtension = "bak";
        }
        prismterminal.nixosModules.prismterminal
      ];
    };
  };
}

