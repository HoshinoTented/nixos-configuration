{ pkgs, ... }:
{
  # kernel
  hardware.enableRedistributableFirmware = true;

  # Swap
  zramSwap.enable = true;

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
    # This require `systemctl --user restart pipewire`
    # try to make quantum value as small as possible

    # Per-application configuration
    ## Q: Why pipewire-pulse
    ## A: `pw-dump | jq '.[] | select(.info.props["application.name"] == "osu!")' | .info.props["client.api"]`
    ##    is "pipewire-pulse"
    extraConfig.pipewire-pulse."92-low-latency" = {
      "stream.rules" = [
        {
          "matches" = [
            {
              "application.name" = "osu!";
            }
          ];
          "actions" = {
            "update-props" = {
              # Cannot set to 44100
              "node.latency" = "64/48000";
            };
          };
        }
      ];
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
  networking.nftables.enable = true;
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [
      53317   # localsend
    ];
    allowedUDPPorts = [
      53317
    ];
  };

  services.resolved.enable = true;
  services.avahi.enable = true;

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
