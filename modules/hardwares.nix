{ pkgs, ... }:
{
  # kernel
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # boot
  ## Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # audio
  ## PipeWire

  # see https://github.com/NixOS/nixpkgs/issues/102547 if something go wrong
  # not sure if this will work
  security.rtkit.enable = true;
  # For more information, see: https://docs.pipewire.org/page_config.html
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
    # This require a reboot
    # try to make quantum value as small as possible
    extraConfig.pipewire."92-low-latency" = {
      "context.properties" = {
        "default.clock.rate" = 48000;   # Cannot set this to 44100, otherwise osu! will be no audio.
        "default.clock.quantum" = 128;
        "default.clock.min-quantum" = 128;
        "default.clock.max-quantum" = 128;
      };
    };
  };

  # graphics
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  # network
  networking.hostName = "hoshino-nix";
  networking.networkmanager.enable = true;
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [
      53317   # localsend
    ];
    allowedUDPPorts = [
      53317
    ];
  };
  

  services.resolved = {
    enable = true;

    # enables mdns, but this doesn't enough,
    # still need to enbale mdns for network manager by
    # ```bash
    # nmcli connection modify "wireless connection name (not interface name)" connection.mdns yes
    # ```
    # ^i am not sure if this is needed
    extraConfig = ''
      MulticastDNS=yes
    '';
  };

  services.avahi = {
    enable = true;
  };

  # no need to enable tlp, plasma enables power-profiles-daemon

  # bluetooth
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };

  # desktop
  services.xserver.enable = true;
  services.desktopManager.plasma6.enable = true;
  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.wayland.enable = true;

  # required by flatpak
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  xdg.portal.config.common.default = "gtk";
}
