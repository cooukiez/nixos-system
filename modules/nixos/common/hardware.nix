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
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    settings = {
      General = {
        Experimental = true;
        FastConnectable = true;
      };
      Policy = {
        AutoEnable = true;
      };
    };
  };

  services.blueman.enable = true;

  # touchpad services
  services.libinput.enable = true;

  # printing services
  services.printing.enable = true;

  # location services
  services.locate.enable = true;
}
