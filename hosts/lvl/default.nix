/*
  hosts/lvl/default.nix

  created by ludw
  on 2026-04-22
*/

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

      inputs.firefox-addons.overlays.default
      inputs.obsidian-plugins.overlays.default

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
        file.".face".source = ../../assets/avatar + "/${userConfig.avatar}";

        stateVersion = "25.11";

        sessionVariables = {
          ELECTRON_PASSWORD_STORE = "gnome-libsecret";
          XDG_CURRENT_DESKTOP = "GNOME";
          XDG_MENU_PREFIX = "gnome-";
        }
        // {
          # wayland window config
          ELM_DISPLAY = "wl";
          CLUTTER_BACKEND = "wayland";

          ELECTRON_OZONE_PLATFORM_HINT = "auto";
          NIXOS_OZONE_WL = "1";

          _JAVA_OPTIONS = "-Dawt.toolkit.name=WLToolkit -Dide.linux.hide.native.title.bar=true";

          # scaling
          QT_AUTO_SCREEN_SCALE_FACTOR = "1";
          QT_ENABLE_HIGHDPI_SCALING = "1";

          QT_SCALE_FACTOR_ROUNDING_POLICY = "PassThrough";

          # window decorations
          QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";

          # smoother scrolling
          MOZ_USE_XINPUT2 = "1";
        };

        packages = userConfig.packages pkgs;
      };

      accounts.email.accounts = userConfig.accounts;

      programs.home-manager.enable = true;
      programs.zsh.enable = true;

      systemd.user.startServices = "sd-switch";
    }) userList;
  };
}
