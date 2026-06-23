args@{ config, pkgs, ... }:
let
  homeDirectory = "/home/hoshino";
  # Clone your configuration to this directory
  nixosConfigDir = homeDirectory + "/.config/nixos";
in
{
  home.username = "hoshino";
  home.homeDirectory = homeDirectory;

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
      nixos-sync = "nixos-rebuild --sudo --flake ${nixosConfigDir}";
      system-nixpkgs = "nix flake metadata path:${nixosConfigDir} --json 2> /dev/null | jq -r .locks.nodes.nixpkgs.locked.rev";
      gamma15 = "xgamma -gamma 1.5";
      gamma10 = "xgamma -gamma 1.0";
    };

    initContent = ''
      realwhich() {
        readlink -f "$(command -v $1)"
      }
    '';

    sessionVariables = {
      NIXOS_CONFIG_PATH = nixosConfigDir;
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
      user.signingkey = "99CC535652820E5B";
      commit.gpgsign = true;
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
    (import ./packages/vscode-pkg.nix args)
    # gamma on x11
    xgamma
    umu-launcher
    # All jetbrains IDE should be launched from toolbox, see https://github.com/NixOS/nixpkgs/issues/240444
    jetbrains-toolbox
  ];
}
