/*
  modules/system/graphical/programs.nix

  created by ludw
  on 2026-04-22
*/

{
  config,
  pkgs,
  lib,
  hostConfig,
  ...
}:
let
  desktop = import ./packages.nix { inherit pkgs hostConfig; };
  cfg = config.graphicalConfig.programs;

  mkEnableDefault = lib.mkOption {
    type = lib.types.bool;
    default = true;
  };
in
{
  options.graphicalConfig = {
    programs = lib.mkOption {
      type = lib.types.submodule {
        options = {
          development = mkEnableDefault;
          gaming = mkEnableDefault;
          modelling = mkEnableDefault;
          other = mkEnableDefault;
          pwa = mkEnableDefault;
          system = mkEnableDefault;

          programNemo = mkEnableDefault;
          programVSCode = mkEnableDefault;
        };
      };

      default = { };
    };
  };

  options.pkgConfig = {
    nemo = lib.mkOption { type = lib.types.package; };
    vscode = lib.mkOption { type = lib.types.package; };
  };

  config = lib.mkMerge [
    (lib.mkIf cfg.development {
      environment.systemPackages = desktop.development ++ desktop.developmentGameEngines;

      programs.vscode.enable = true;
    })

    (lib.mkIf cfg.gaming {
      environment.systemPackages = desktop.gameClients ++ desktop.gamingExtra;

      programs.steam = {
        enable = true;

        remotePlay.openFirewall = true;
        dedicatedServer.openFirewall = true;
        localNetworkGameTransfers.openFirewall = true;
      };

      programs.gamescope = {
        enable = false;
        capSysNice = true;
      };
    })

    (lib.mkIf cfg.modelling {
      environment.systemPackages = desktop.modelling;
    })

    (lib.mkIf cfg.other {
      environment.systemPackages = desktop.other;
    })

    (lib.mkIf cfg.pwa {
      environment.systemPackages = desktop.pwa;
    })

    (lib.mkIf cfg.system {
      environment.systemPackages = desktop.system;
    })

    (lib.mkIf cfg.programNemo {
      pkgConfig.nemo = (
        pkgs.nemo-with-extensions.override {
          extensions = with pkgs; [
            folder-color-switcher
            nemo-emblems
            nemo-seahorse
            nemo-python
            nemo-fileroller
          ];

          useDefaultExtensions = false;
        }
      );

      environment.systemPackages = [
        config.pkgConfig.nemo

        /*
          pkgs.unstable.nautilus-python
          pkgs.unstable.nautilus-open-any-terminal
          pkgs.unstable.code-nautilus
        */
      ];

      /*
        environment.pathsToLink = [ "/share/nautilus-python/extensions" ];
        environment.sessionVariables = {
          NAUTILUS_EXTENSION_DIR = "${pkgs.unstable.nautilus-python}/lib/nautilus/extensions";
          NAUTILUS_4_EXTENSION_DIR = "${pkgs.unstable.nautilus-python}/lib/nautilus/extensions-4";
        };
      */
    })

    (lib.mkIf cfg.programVSCode {
      pkgConfig.vscode = pkgs.unstable.vscode;

      programs.vscode = {
        enable = true;
        package = config.pkgConfig.vscode;
      };
    })
  ];
}
