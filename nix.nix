{ ... }:
{
  # Some vscode extensions are unfree, so...
  nixpkgs.config.allowUnfree = true;
  
  # .substituers is only available for root, .trusted-substituters is for non-root users
  nix.settings.trusted-substituters = [ "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store?priority=5" ];
  nix.settings.substituters = [ "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store?priority=5" ];
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
}