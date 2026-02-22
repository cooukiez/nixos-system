/*
  modules/nixos/common/hardware.nix

  created by ludw
  on 2026-02-18
*/

{
  pkgs,
  ...
}:
{
  # power profiles
  services.power-profiles-daemon.enable = true;

  # battery
  services.upower.enable = true;

  # graphics hardware configuration
  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver
    ];
  };

  # audio configuration
  services.pipewire = {
    enable = true;
    audio.enable = true;
    pulse.enable = true;
    alsa = {
      enable = true;
      support32Bit = true;
    };

    # opens UDP ports 6001-6002
    raopOpenFirewall = true;
    extraConfig.pipewire = {
      # airplay configuration
      "10-airplay" = {
        "context.modules" = [
          {
            name = "libpipewire-module-raop-discover";
            # increase the buffer size if dropouts/glitches
            # args = {
            #   "raop.latency.ms" = 500;
            # };
          }
        ];
      };

      # disable system bell
      "99-silent-bell.conf" = {
        "context.properties" = {
          "module.x11.bell" = false;
        };
      };

      # todo: fix bluetooth codecs here
      # see https://wiki.nixos.org/wiki/PipeWire
    };
    jack.enable = true;
  };

  # allow pipewire real-time scheduling
  security.rtkit.enable = true;

  # bluetooth fixing
  boot.extraModprobeConfig = ''
    # keep bluetooth coexistence disabled for better audio stability
    options iwlwifi bt_coex_active=0
    # enable software crypto (helps coexistence sometimes)
    options iwlwifi swcrypto=1
    # disable power saving on wifi module to reduce radio state changes that might disrupt bluetooth
    options iwlwifi power_save=0
    # disable unscheduled automatic power save delivery (U-APSD) to improve audio stability
    options iwlwifi uapsd_disable=1
    # disable D0i3 power state to avoid problematic power transitions
    options iwlwifi d0i3_disable=1
    # set power scheme for performance (iwlmvm)
    options iwlmvm power_scheme=1
  '';

  # bluetooth configuration
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    settings = {
      General = {
        # shows battery charge of connected devices on supported
        Experimental = true;
        # when enabled other devices can connect faster to us
        # the tradeoff is increased power consumption
        FastConnectable = true;
        # enable A2DP audio sink
        Enable = "Source,Sink,Media,Socket";
      };
      Policy = {
        # enable all controllers when they are found
        AutoEnable = true;
      };
    };
  };

  # enable touchpad and other input functionality
  services.libinput.enable = true;

  # mounting usb devices
  services.usbmuxd = {
    enable = true;
    package = pkgs.usbmuxd2;
  };
}
