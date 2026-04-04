{ pkgs, ... }:

{
  users.users.hoshino = {
    isNormalUser = true;
    home = "/home/hoshino";
    extraGroups = [
      "wheel"
      "networkmanager"
    ];

    # This require `programs.zsh.enable = true` in `configuration.nix` even it was enabled in home-manager
    shell = pkgs.zsh;
  };
}
