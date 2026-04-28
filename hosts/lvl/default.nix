{
  inputs,
  outputs,
  config,
  pkgs,
  lib,
  hostConfig,
  userList,
  ...
}:
{
  imports = [
    ./config.nix
    ./hardware-generated.nix
    ./hardware-old.nix

    inputs.self.systemModules.graphical
    inputs.self.systemModules.network
    inputs.self.systemModules.packages

    inputs.agenix.nixosModules.default
    inputs.home-manager.nixosModules.home-manager
  ];

  nixpkgs = {
    overlays = [
      inputs.self.overlays.additions
      inputs.self.overlays.modifications
      inputs.self.overlays.unstable-packages

      (final: prev: {
        valkey = prev.valkey.overrideAttrs (oldAttrs: {
          doCheck = false;
        });
      })
    ];

    config = {
      allowUnfree = true;
      permittedInsecurePackages = [
        "dotnet-sdk-6.0.428"
        "dotnet-runtime-6.0.36"

        "googleearth-pro-7.3.6.10201"
        "ventoy-1.1.10"
      ];
    };
  };
  nix =
    let
      flakeInputs = lib.filterAttrs (_: lib.isType "flake") inputs;
    in
    {
      settings = {
        experimental-features = "nix-command flakes";
        flake-registry = "";
        nix-path = config.nix.nixPath;
      };

      channel.enable = false;

      registry = lib.mapAttrs (_: flake: { inherit flake; }) flakeInputs;
      nixPath = lib.mapAttrsToList (n: _: "${n}=flake:${n}") flakeInputs;

      optimise.automatic = true;
      optimise.dates = [ "03:45" ];
    };

  users.users = lib.mapAttrs (_: user: {
    description = user.fullName;
    isNormalUser = true;
    extraGroups = [
      "wheel"

      "audio"
      "input"
      "video"

      "networkmanager"
      "tailscale"

      "cdrom"
      "optical"
    ];
    password = "CHANGE-ME";
    shell = pkgs.zsh;
  }) userList;

  systemd.tmpfiles.rules = lib.flatten (
    lib.mapAttrsToList (
      username: user:
      lib.mapAttrsToList (target: source: [
        "r /home/${username}/${target}"
        "L /home/${username}/${target} - - - - ${source}"
      ]) (user.bindDirs or { })
    ) userList
  );

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "hm-bak";

    extraSpecialArgs = {
      inherit
        inputs
        outputs
        hostConfig
        ;

      pkgConfig = config.pkgConfig;
    };

    users = lib.mapAttrs (username: userConfig: {
      imports = [
        inputs.self.homeModules
      ];

      _module.args.userConfig = userConfig;

      home = {
        username = username;
        homeDirectory = "/home/${username}";
        stateVersion = "25.11";
      };

      # copy avatar picture
      # home.file.".face".source = userConfig.avatar;

      programs.home-manager.enable = true;
      systemd.user.startServices = "sd-switch";
    }) userList;
  };
}
