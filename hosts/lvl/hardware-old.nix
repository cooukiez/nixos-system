{
  pkgs,
  ...
}:
{
  hardware.enableAllFirmware = true;

  # session variables
  environment.sessionVariables = {
    LIBVA_DRIVER_NAME = "iHD";
  };

  # firmware updating
  services.fwupd.enable = true;
  # device monitoring
  services.devmon.enable = true;

  # processor and graphics
  services.power-profiles-daemon.enable = true;

  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver
    ];
  };

  # memory and swap
  swapDevices = [
    { device = "/dev/disk/by-partlabel/swap"; }
  ];

  zramSwap.enable = true;
  zramSwap.memoryPercent = 50;
  zramSwap.algorithm = "lz4";

  # battery
  services.upower = {
    enable = true;
    ignoreLid = false;
  };

  # mounting usb devices
  services.usbmuxd = {
    enable = true;
    package = pkgs.usbmuxd2;
  };

  # audio
  services.pipewire = {
    enable = true;
    raopOpenFirewall = true;

    audio.enable = true;
    pulse.enable = true;
    jack.enable = true;

    alsa = {
      enable = true;
      support32Bit = true;
    };

    extraConfig.pipewire = {
      "10-airplay" = {
        "context.modules" = [
          {
            name = "libpipewire-module-raop-discover";
            # increase the buffer size if dropouts / glitches
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
    };
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

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;

    settings = {
      General = {
        Experimental = true;
        FastConnectable = true;
        Enable = "Source,Sink,Media,Socket";
      };

      Policy = {
        AutoEnable = true;
      };
    };
  };

  # drive
  services.btrfs.autoScrub = {
    enable = true;
    interval = "weekly";
  };

  # data snapshots (every 30 min)
  systemd.services.snapshot-data = {
    description = "btrfs data snapshot";
    serviceConfig.Type = "oneshot";
    path = with pkgs; [
      coreutils
      btrfs-progs
    ];

    script = ''
      DATE=$(date +%Y-%m-%d-%H%M)
      mkdir -p /snapshots/data/data-$DATE
      btrfs subvolume snapshot -r /data /snapshots/data/data-$DATE/data
    '';
  };

  systemd.timers.snapshot-data = {
    wantedBy = [ "timers.target" ];
    timerConfig = {
      OnCalendar = "*:0/30";
      Persistent = true;
    };
  };

  # cleanup policy
  systemd.services.snapshot-cleanup = {
    description = "cleanup old snapshots";
    serviceConfig.Type = "oneshot";
    path = with pkgs; [
      findutils
      btrfs-progs
    ];
    script = ''
      find /snapshots/data -mindepth 1 -maxdepth 1 -type d -mtime +3 -exec sh -c '
        for dir do
          btrfs subvolume delete "$dir"/*
          rmdir "$dir"
        done
      ' sh {} +
    '';
  };

  systemd.timers.snapshot-cleanup = {
    wantedBy = [ "timers.target" ];
    timerConfig.OnCalendar = "daily";
  };
}
