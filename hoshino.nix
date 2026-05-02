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
      nixos-sync = "nixos-rebuild --sudo --flake /home/hoshino/.config/nixos";    # Clone your configuration to this directory
      gamma15 = "xgamma -gamma 1.5";
      gamma10 = "xgamma -gamma 1.0";
    };

    oh-my-zsh = {
      enable = true;
      plugins = [ "git" ];
      theme = "agnoster";
    };
  };

  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;
  };

  programs.git = {
    enable = true;
    settings = {
      user.name = "HoshinoTented";
      user.email = "hoshinotented@qq.com";
      pull.rebase = true;
      pager.branch = false;
      pager.stash = false;
    };
  };

  home.packages = with pkgs; [
    # IM
    telegram-desktop mumble
    # network
    v2rayn xray
    # utils
    bat
    (import ./packages/vscode-pkg.nix args)
    # gamma on x11
    xgamma
  ];
}
