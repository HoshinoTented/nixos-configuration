{
  config,
  lib,
  pkgs,
  prismterminal,
  ...
}:

let
  cfg = config.programs.prismterminal;
in
{
  options = {
    programs.prismterminal = {
      enable = lib.mkEnableOption "A configurator for meowpad";
    };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [ prismterminal ];
  };
}