/*
  modules/system/graphical/programs.nix

  part of nixos system
  created 2026-04-22 by ludw
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
          # todo: add pkg suffix
          development = mkEnableDefault;
          gaming = mkEnableDefault;
          modelling = mkEnableDefault;
          other = mkEnableDefault;
          pwa = mkEnableDefault;
          system = mkEnableDefault;

          programNemo = mkEnableDefault;
          programVSCode = mkEnableDefault;
          programZedEditor = mkEnableDefault;
        };
      };

      default = { };
    };
  };

  options.pkgConfig = {
    nemo = lib.mkOption { type = lib.types.package; };
    vscode = lib.mkOption { type = lib.types.package; };
    zedEditor = lib.mkOption { type = lib.types.package; };
  };

  config = lib.mkMerge [
    (lib.mkIf cfg.development {
      environment.systemPackages = desktop.development ++ desktop.developmentGameEngines;
    })

    (lib.mkIf cfg.gaming {
      environment.systemPackages = desktop.gameClients ++ desktop.gamingExtra ++ desktop.games;

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
      ];
    })

    (lib.mkIf cfg.programVSCode {
      pkgConfig.vscode = pkgs.unstable.vscode;

      programs.vscode = {
        enable = true;
        package = config.pkgConfig.vscode;
      };
    })

    (lib.mkIf cfg.programZedEditor {
      pkgConfig.zedEditor = pkgs.unstable.zed-editor;

      environment.systemPackages = [
        config.pkgConfig.zedEditor
      ];
    })
  ];
}
