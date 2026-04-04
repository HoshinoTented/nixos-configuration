{ config, pkgs, ... }:
{
  imports = [ ./packages/emacs.nix ];

  # Some vscode extensions are unfree, so...
  nixpkgs.config.allowUnfree = true;
  nix.settings.substituters = [ "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store" ];
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  programs.firefox.enable = true;

  # This may require a reboot
  programs.gnupg.agent = {
    enable = true;
    pinentryPackage = with pkgs; pinentry-qt;
  };

  programs.direnv.enable = true;
  services.flatpak.enable = true;
  
  # List packages installed in system profile.
  # Only fundamental packages should be installed in this way, for other packages, use user configuration, nix profile or home-manager
  environment.systemPackages = with pkgs; [
    vim wget steam-run
    neofetch localsend
  ];

  # OpenTabletDriver
  hardware.opentabletdriver.enable = true;
  hardware.uinput.enable = true;
  boot.kernelModules = [ "uinput" ];

  fonts.packages = with pkgs; [
    lxgw-wenkai fira-code
    noto-fonts-cjk-sans
  ];

  # fcitx5
  i18n.inputMethod = {
    type = "fcitx5";
    enable = true;
    fcitx5.addons = with pkgs; [
      fcitx5-gtk
      qt6Packages.fcitx5-chinese-addons
    ];
    # suppress wayland warning
    fcitx5.waylandFrontend = true;
  };

  # steam, require allowUnfree
  programs.steam = {
    enable = true;
    localNetworkGameTransfers.openFirewall = true;
  };
}
