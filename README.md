# nixos-configuration

* [configuration.nix](./configuration.nix): The main NixOS module which contains necessary NixOS information and imports other modules
* [users.nix](./users.nix): A module which defines users in this system.
* [hoshino.nix](./hoshino.nix): My home-manager configuration
* [nix.nix](./nix.nix): A module which configures nix and nixpkgs.
* [packages.nix](./packages.nix): A module which defines system wide packages.
* [packages](./packages/): A directory which contains modules/Nix expression that defines packages with potentially massive configuration.
* [modules/desktop.nix](./modules/hardwares.nix): A module which defines hardware configurations, which involves kernel, audio, network, graphics, desktop, etc.
* [modules/miscellaneous.nix](./modules/miscellaneous.nix): A module which defines miscellaneous configurations, which typically invokes services.

You should use your own [hardware-configuration.nix](./hardware-configuration.nix).
You may upgrade all NixOS version pin to the nixpkgs you are using,
such as `system.stateVersion` in [configuration.nix](./configuration.nix) and `home.stateVersion` in [hoshino.nix](./hoshino.nix).