/*
hosts/lvl/config.nix

part of nixos system
created 2026-04-22 by ludw
*/
{
  config,
  pkgs,
  hostConfig,
  ...
}: {
  # boot configuration
  boot = {
    kernelPackages = pkgs.linuxPackages_latest;

    kernelParams = [
      "quiet"
      "splash"
      "rd.udev.log_level=3"
      "boot.shell_on_fail"
    ];

    loader.efi.canTouchEfiVariables = true;
    loader.systemd-boot.enable = true;
    loader.timeout = 0;

    plymouth.enable = true;
    initrd.verbose = false;
    consoleLogLevel = 0;

    initrd.luks.devices = {
      "cryptroot" = {
        device = "/dev/disk/by-partlabel/nixos";
        allowDiscards = true;
      };
    };
  };

  # disable systemd services affecting boot time
  systemd.services = {
    NetworkManager-wait-online.enable = false;
    plymouth-quit-wait.enable = false;
  };

  # time configuration
  time.timeZone = "Europe/Berlin";
  services.timesyncd.enable = true;

  # networking configuration
  networking = {
    hostName = hostConfig.hostname;
    nameservers = [
      "1.1.1.1"
      "8.8.8.8"
      "9.9.9.9"
    ];

    networkmanager = {
      enable = true;
    };

    firewall = {
      enable = true;

      allowedTCPPorts = [];
      allowedUDPPorts = [];
    };

    hosts = {
      "127.0.0.1" = ["nixos.wiki"];
      "192.168.178.1" = ["fritz.box"];
    };
  };

  networkConfig.tailscaleClient = true;
  networkConfig.tailscaleClientExitNode = "100.71.244.88";
  networkConfig.tailscaleOperator = "ludw";

  age.secrets.tailscale-key.file = ../../secrets/tailscale-key.age;
  services.tailscale.authKeyFile = config.age.secrets.tailscale-key.path;

  networkConfig.copyparty = true;
  age.secrets.copyparty.file = ../../secrets/copyparty.age;
  networkConfig.copypartyPasswardPath = config.age.secrets.copyparty.path;

  networkConfig.printing = true;

  networkConfig.samba.fritzMount = true;
  networkConfig.samba.dhsMount = true;

  # locale configuration
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocales = [];
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_IE.UTF-8";
    LC_IDENTIFICATION = "en_IE.UTF-8";
    LC_MEASUREMENT = "en_IE.UTF-8";
    LC_MONETARY = "en_IE.UTF-8";
    LC_NAME = "en_IE.UTF-8";
    LC_NUMERIC = "en_IE.UTF-8";
    LC_PAPER = "en_IE.UTF-8";
    LC_TELEPHONE = "en_IE.UTF-8";
    LC_TIME = "en_IE.UTF-8";
  };

  console.keyMap = "de";

  # security configuration
  security.sudo.wheelNeedsPassword = false;

  security.polkit.enable = true;
  services.fprintd.enable = true;

  security.pki.certificateFiles = [
    ../../dhs.crt
  ];

  # generating entropy
  services.haveged.enable = true;

  # location
  services.locate.enable = true;

  # disable documentation temporary
  documentation.nixos.enable = false;
}
