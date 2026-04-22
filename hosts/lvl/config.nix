{
  pkgs,
  ...
}:
{
  # boot configuration
  boot = {
    kernelPackages = pkgs.linuxPackages_zen;

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
    hostName = hostname;
    nameservers = dnsServers;

    networkmanager = {
      enable = true;
    };

    firewall = {
      enable = true;
      allowedTCPPorts = [ ];
      allowedUDPPorts = [ ];
    };
  };

  services.tailscale = {
    enable = true;

    extraUpFlags = [
      "--exit-node=100.71.244.88"
      "--exit-node-allow-lan-access=true"
    ];

    extraSetFlags = [
      "--operator=ceirs"
    ];
  };

  # locale configuration
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocales = [ ];
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

  # disable fingerprint for boot login
  security.pam.services.login.fprintAuth = false;

  security.pki.certificateFiles = [
    ../../dhs.crt
  ];

  # generating entropy
  services.haveged.enable = true;

  # location
  services.locate.enable = true;
}
