{ pkgs, ... }:
{
  # audio
  ## PipeWire

  # see https://github.com/NixOS/nixpkgs/issues/102547 if something go wrong
  # not sure if this will work
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
    extraConfig.pipewire."92-low-latency" = {
      "context.properties" = {
        "default.clock.rate" = 44100;
        "default.clock.allowed-rates" = [ 44100 ];
        "default.clock.quantum" = 32;
        "default.clock.min-quantum" = 32;
        "default.clock.max-quantum" = 32;
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
