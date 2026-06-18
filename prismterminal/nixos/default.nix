prismterminal:
{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.programs.prismterminal;
  udev-support = pkgs.callPackage ./udev-support.nix { inherit prismterminal; };
in
{
  options = {
    programs.prismterminal = {
      enable = lib.mkEnableOption "A configurator for meowpad";
      udevExtra = lib.mkOption {
        type = udev-support.hardwaresType;
        default = [];
        example = 
          [
            {
              name = "Meowpad Name";
              idVendor = "vendor id";
              idProduct = "product id";
            }
          ];
        description = "Extra udev rules for meowpad.";
      };
    };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [ prismterminal ];
    services.udev.packages = [ (udev-support.withExtra cfg.udevExtra) ];
  };
}