# system configuration file
{
  inputs,
  hostname,
  lib,
  config,
  userConfig,
  pkgs,
  ...
}: {
  # import other nixos modules here
  imports = [
    # use modules your own flake exports (from modules/nixos):
    # inputs.self.nixosModules.example

    # modules from other flakes (such as nixos-hardware):
    # inputs.hardware.nixosModules.common-cpu-amd
    # inputs.hardware.nixosModules.common-ssd

    # split up your configuration and import pieces of it here:
    # ./users.nix

    # import generated (nixos-generate-config) hardware configuration
    ./hardware-configuration.nix

    inputs.self.nixosModules.common
    inputs.self.nixosModules.desktop
    inputs.self.nixosModules.programs
  ];

  nixpkgs = {
	# add overlays here
    overlays = [
	  # add overlays your own flake exports (from overlays and pkgs dir):
      inputs.self.overlays.additions
      inputs.self.overlays.modifications
      inputs.self.overlays.unstable-packages
      inputs.self.overlays.nur

	  # add overlays exported from other flakes:
      # neovim-nightly-overlay.overlays.default

      # or define it inline:
      # (final: prev: {
      #   hi = final.hello.overrideAttrs (oldAttrs: {
      #     patches = [ ./change-hello-to-hi.patch ];
      #   });
      # })
    ];
	  # configure your nixpkgs instance
    config = {
	  # allow unfree packages
      allowUnfree = true;
      permittedInsecurePackages = [
        "dotnet-sdk-6.0.428"
        "dotnet-runtime-6.0.36"
      ];
    };
  };

  nix = let
    flakeInputs = lib.filterAttrs (_: lib.isType "flake") inputs;
  in {
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
    registry = lib.mapAttrs (_: flake: {inherit flake;}) flakeInputs;
    nixPath = lib.mapAttrsToList (n: _: "${n}=flake:${n}") flakeInputs;
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

  # PATH configuration
  environment.localBinInPath = true;

  # user configuration
  users.users.${userConfig.name} = {
    description = userConfig.fullName;
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "audio" "video" ];
    #openssh.authorizedKeys.keys = [];
    password = "CHANGE-ME"; # replace after install with passwd
    shell = pkgs.zsh;
  };

  # passwordless sudo
  security.sudo.wheelNeedsPassword = false;
  
  # swap configuration
  swapDevices = [
    { device = "/dev/disk/by-partlabel/swap"; }
  ];
  
  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "25.11";
}
