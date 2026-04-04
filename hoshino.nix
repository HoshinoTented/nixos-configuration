args@{ config, pkgs, ... }:
{
  home.username = "hoshino";
  home.homeDirectory = "/home/hoshino";

  home.stateVersion = "25.11";

  home.sessionPath = [
    "$HOME/.local/bin"
  ];

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    shellAliases = {
      la = "ls -alhF";
      nixos-sync = "sudo nixos-rebuild --flake /home/hoshino/.config/nixos";
    };

    oh-my-zsh = {
      enable = true;
      plugins = [ "git" ];
      theme = "agnoster";
    };
  };

  home.packages = with pkgs; [
    # IM
    telegram-desktop mumble
    # network
    v2rayn xray
    # utils
    bat git
    (import ./packages/vscode-pkg.nix args)
  ];
}
