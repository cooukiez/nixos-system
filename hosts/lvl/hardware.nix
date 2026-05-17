/*
hosts/lvl/hardware.nix

part of nixos system
created 2026-04-22 by ludw
*/
{
  inputs,
  config,
  pkgs,
  ...
}: {
  disabledModules = [
    "hardware/facter"
  ];

  imports = [
    "${inputs.nixpkgs-unstable}/nixos/modules/hardware/facter"
  ];

  hardware.facter = {
    enable = true;
    reportPath = ./facter.json;

    detected.uefi.supported = true;

    detected.graphics.enable = true;
    detected.bluetooth.enable = true;

    detected.camera.ipu6.enable = true;
    detected.fingerprint.enable = true;
  };

  hardware.enableAllFirmware = true;
  services.fwupd.enable = true;

  services.devmon.enable = true;

  # processor and graphics
  services.power-profiles-daemon.enable = true;

  environment.sessionVariables = {
    LIBVA_DRIVER_NAME = "iHD";
  };

  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver
    ];
  };

  packageConfig.gpuPowerApps = false;

  # memory and swap
  swapDevices = [
    {device = "/dev/disk/by-partlabel/swap";}
  ];

  zramSwap.enable = true;
  zramSwap.memoryPercent = 50;
  zramSwap.algorithm = "lz4";

  services.udev.extraRules = ''
    SUBSYSTEM=="memory", ACTION=="add", ATTR{state}=="online", GOTO="hyperv_hotadd_end"
    LABEL="hyperv_hotadd_end"
  '';

  # network
  boot.kernel.sysctl = {
    # "net.ipv4.conf.all.proxy_arp" = 0;
    # "net.ipv4.conf.default.proxy_arp" = 0;

    # "net.ipv6.conf.all.use_tempaddr" = lib.mkForce 2;
    # "net.ipv6.conf.default.use_tempaddr" = lib.mkForce 2;
  };

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
          {name = "libpipewire-module-raop-discover";}
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

  # webcam support
  boot.kernelModules = [
    "v4l2loopback"
    "intel-ipu6"
    "intel-ipu6-isys"
  ];

  boot.extraModulePackages = with config.boot.kernelPackages; [v4l2loopback];

  # drive
  services.btrfs.autoScrub = {
    enable = true;
    interval = "weekly";
  };

  zshSettings.dataPartitionAliases = true;

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
    wantedBy = ["timers.target"];
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
    wantedBy = ["timers.target"];
    timerConfig.OnCalendar = "daily";
  };

  security.pam.loginLimits = [
    {
      domain = "*";
      type = "soft";
      item = "nofile";
      value = "8192";
    }
  ];
}
