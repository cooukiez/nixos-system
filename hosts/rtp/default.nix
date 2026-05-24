/*
hosts/rtp/default.nix

part of nixos system
created 2026-05-15 by ludw
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
}: {
  imports = [
    ./config.nix
    ./disko-config.nix
    ./hardware-generated.nix
    ./hardware.nix

    inputs.self.systemModules.graphical
    inputs.self.systemModules.network
    inputs.self.systemModules.packages

    inputs.disko.nixosModules.disko
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

        "luanti-5.14.0"
        "googleearth-pro-7.3.6.10201"
        "ventoy-1.1.10"
      ];
    };
  };

  nix = let
    flakeInputs = lib.filterAttrs (_: lib.isType "flake") inputs;
  in {
    settings = {
      experimental-features = "nix-command flakes";
      flake-registry = "";
      nix-path = config.nix.nixPath;
    };

    channel.enable = false;

    registry = lib.mapAttrs (_: flake: {inherit flake;}) flakeInputs;
    nixPath = lib.mapAttrsToList (n: _: "${n}=flake:${n}") flakeInputs;

    optimise.automatic = true;
    optimise.dates = ["03:45"];
  };

  age.identityPaths = ["/etc/ssh/ssh_host_ed25519_key"];

  age.secrets =
    lib.mapAttrs' (
      username: _:
        lib.nameValuePair "password-${username}" {
          file = ../../secrets/passwords/${username}.age;
          owner = username;
          group = "users";
        }
    )
    userList
    // lib.mapAttrs' (
      username: _:
        lib.nameValuePair "ssh-${username}" {
          file = ../../secrets/ssh/${username}.age;
          path = "/home/${username}/.ssh/id_ed25519";
          owner = username;
          group = "users";
        }
    )
    userList;

  users.users =
    lib.mapAttrs (_: user: {
      enable = true;

      description = user.fullName;
      isNormalUser = true;
      createHome = true;

      hashedPasswordFile = config.age.secrets."password-${user.name}".path;

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

      shell = pkgs.zsh;
    })
    userList;

  systemd.tmpfiles.rules =
    lib.flatten (
      lib.mapAttrsToList (username: _: [
        "d /home/${username}/.ssh 0700 ${username} users - -"
      ])
      userList
    )
    ++ lib.flatten (
      lib.mapAttrsToList (
        username: user:
          lib.mapAttrsToList (target: source: [
            "d ${source} 0775 root users - -"

            "r /home/${username}/${target}"
            "L /home/${username}/${target} - - - - ${source}"
          ]) (user.bindDirs or {})
      )
      userList
    );

  home-manager = {
    useGlobalPkgs = false;
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

    users =
      lib.mapAttrs (
        username: userConfig: {
          config,
          hostConfig,
          ...
        }: {
          imports = [
            inputs.self.homeModules

            inputs.agenix.homeManagerModules.default
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
              permittedInsecurePackages = [];
            };
          };

          age.identityPaths = ["${config.home.homeDirectory}/.ssh/id_ed25519"];
          _module.args.userConfig = userConfig;

          home = {
            username = username;
            packages = userConfig.packages pkgs;

            homeDirectory = "/home/${username}";
            file.".face".source = ../../assets/avatar + "/${userConfig.avatar}";
            file.".ssh/id_ed25519.pub" = {
              text = ''
                ${userConfig.sshPublicKey} ${username}@${hostConfig.hostname}
              '';
            };

            stateVersion = "25.11";
          };

          age.secrets = (
            builtins.mapAttrs (name: _: {
              file = ../../secrets/mail/${name}.age;
            })
            userConfig.accounts
          );

          accounts.email.accounts =
            builtins.mapAttrs (
              name: value:
                value
                // {
                  passwordCommand = "cat ${config.age.secrets.${name}.path}";
                }
            )
            userConfig.accounts;

          programs.home-manager.enable = true;
          programs.zsh.enable = true;

          systemd.user.startServices = "sd-switch";
        }
      )
      userList;
  };
}
