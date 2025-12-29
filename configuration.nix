# system configuration file
{
  inputs,
  lib,
  config,
  pkgs,
  ...
}:
let
  info = import ./info.nix;
in
{
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

  # bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # kernel
  boot.kernelPackages = pkgs.linuxPackages_zen;
   
  # hostname
  networking.hostName = info.hostname;

  # timezone
  time.timeZone = info.timezone;
  services.timesyncd.enable = true;

  # locales / language
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.supportedLocales = [ "en_US.UTF-8" "de_DE.UTF-8" ];
  console.keyMap = "de";

  # user configuration
  users.users = {
    ludw = {
      isNormalUser = true;
      extraGroups = [ "wheel" "networkmanager" "audio" "video" ];
      openssh.authorizedKeys.keys = [
        # todo: add your SSH public key here
      ];
      password = "CHANGE-ME"; # replace after install with passwd
    };
  };
  
  # swap configuration
  swapDevices = [
    { device = "/dev/disk/by-partlabel/swap"; }
  ];
  
  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "25.11";
}