/*
  configuration.nix

  created by ludw
  on 2026-01-29
*/

# system configuration file

{
  inputs,
  config,
  pkgs,
  lib,
  hostname,
  users,
  ...
}:
let
  # todo: add way to configure mount target per user
  bind_dirs = [
    {
      source = "/data/documents";
      target = "Documents";
    }
    {
      source = "/data/downloads";
      target = "Downloads";
    }
    {
      source = "/data/music";
      target = "Music";
    }
    {
      source = "/data/pictures";
      target = "Pictures";
    }
    {
      source = "/data/videos";
      target = "Videos";
    }
  ];
in
{
  imports = [
    # import generated hardware configuration
    ./hardware-configuration.nix

    # import other system configuration modules
    inputs.self.nixosModules.common
    inputs.self.nixosModules.desktop
    inputs.self.nixosModules.programs

    inputs.nix-flatpak.nixosModules.nix-flatpak
    inputs.niri.nixosModules.niri
    inputs.copyparty.nixosModules.default
    inputs.agenix.nixosModules.default
    inputs.spicetify-nix.nixosModules.default
  ];
  nixpkgs = {
    # add overlays here
    overlays = [
      inputs.self.overlays.additions
      inputs.self.overlays.modifications
      inputs.self.overlays.unstable-packages
      inputs.self.overlays.nur
      inputs.niri.overlays.niri
      inputs.copyparty.overlays.default
    ];

    # configure your nixpkgs instance
    config = {
      # allow unfree packages
      allowUnfree = true;
      permittedInsecurePackages = [
        "dotnet-sdk-6.0.428"
        "dotnet-runtime-6.0.36"
        "ventoy-1.1.07"
        "googleearth-pro-7.3.6.10201"
      ];
    };
  };
  nix =
    let
      flakeInputs = lib.filterAttrs (_: lib.isType "flake") inputs;
    in
    {
      settings = {
        # enable flakes and new nix command
        experimental-features = "nix-command flakes";
        # opinionated: disable global registry
        flake-registry = "";
        # workaround for https://github.com/NixOS/nix/issues/9574
        nix-path = config.nix.nixPath;
      };

      # opinionated: disable channels
      channel.enable = false;
      # opinionated: make flake registry and nix path match flake inputs
      registry = lib.mapAttrs (_: flake: { inherit flake; }) flakeInputs;
      nixPath = lib.mapAttrsToList (n: _: "${n}=flake:${n}") flakeInputs;

      optimise.automatic = true;
      optimise.dates = [ "03:45" ];
    };

  # boot settings
  boot = {
    kernelPackages = pkgs.linuxPackages_zen;
    consoleLogLevel = 0;
    initrd.verbose = false;
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
  };

  # disable systemd services that are affecting the boot time
  systemd.services = {
    NetworkManager-wait-online.enable = false;
    plymouth-quit-wait.enable = false;
  };

  # hostname
  networking.hostName = hostname;

  # timezone
  time.timeZone = "Europe/Berlin";
  services.timesyncd.enable = true;

  # locales / language
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

  # PATH configuration
  environment.localBinInPath = true;

  # user configuration
  users.users = lib.mapAttrs (_: user: {
    description = user.fullName;
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "networkmanager"
      "audio"
      "video"
      "input"
    ];
    password = "CHANGE-ME";
    shell = pkgs.zsh;
  }) users;

  # create bind targers
  systemd.tmpfiles.rules = lib.concatLists (
    lib.mapAttrsToList (
      username: _: map (bind: "d /home/${username}/${bind.target} 0775 ${username} users - -") bind_dirs
    ) users
  );

  # bind mount configuration
  systemd.mounts = lib.concatLists (
    lib.mapAttrsToList (
      username: _:
      map (bind: {
        where = "/home/${username}/${bind.target}";
        what = bind.source;
        type = "none";
        options = "bind,rw,nofail";
        unitConfig = {
          DefaultDependencies = false;
        };

        after = [
          "local-fs.target"
          "home.mount"
        ];

        before = [ "remote-fs.target" ];
        wantedBy = [ "multi-user.target" ];
      }) bind_dirs
    ) users
  );

  # passwordless sudo
  security.sudo.wheelNeedsPassword = false;

  # swap configuration
  swapDevices = [
    { device = "/dev/disk/by-partlabel/swap"; }
  ];

  # zram configuration
  zramSwap.enable = true;
  zramSwap.memoryPercent = 50;
  zramSwap.algorithm = "lz4";

  # see https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "25.11";
}
