{ pkgs, ... }:
{
  # graphics hardware configuration
  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver # for broadwell (2014) or newer processors. LIBVA_DRIVER_NAME=iHD
      # intel-vaapi-driver # for older processors. LIBVA_DRIVER_NAME=i965
    ];
  };

  # set LIBVA_DRIVER_NAME environment variable for video acceleration
  environment.sessionVariables = {
    LIBVA_DRIVER_NAME = "iHD";
  };

  # networking configuration
  networking.networkmanager.enable = true;
  networking.firewall.enable = false;

  # openssh
  services.openssh = {
    enable = true;
    settings = {
      # opinionated: forbid root login through SSH
      PermitRootLogin = "no";
      # opinionated: keys and passwords
      PasswordAuthentication = true;
    };
  };

  # audio configuration
  services.pipewire = {
    enable = true;
    pulse.enable = true;

    alsa = {
      enable = true;
      support32Bit = true;
    };

    jack.enable = true;

    # bluetooth enhancements for pipewire
    wireplumber.extraConfig.bluetoothEnhancements = {
      "monitor.bluez.properties" = {
        "bluez5.enable-sbc-xq" = true;
        "bluez5.enable-msbc" = true;
        "bluez5.enable-hw-volume" = true;
        "bluez5.roles" = [
          "hsp_hs"
          "hsp_ag"
          "hfp_hf"
          "hfp_ag"
        ];
      };
    };
  };

  # bluetooth configuration
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
      };
      Policy = {
        # enable all controllers when they are found
        AutoEnable = true;
      };
    };
  };

  # touchpad services
  services.libinput.enable = true;

  # printing services
  services.printing.enable = true;

  # location services
  services.locate.enable = true;
}
