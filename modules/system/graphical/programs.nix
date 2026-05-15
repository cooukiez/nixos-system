/*
  modules/system/graphical/programs.nix

  part of nixos system
  created 2026-04-22 by ludw
*/

{
  config,
  pkgs,
  lib,
  ...
}:
let
  desktop = import ./packages.nix { inherit pkgs; };
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
          developmentPkg = mkEnableDefault;
          gamingPkg = mkEnableDefault;
          modellingPkg = mkEnableDefault;
          otherPkg = mkEnableDefault;
          pwaPkg = mkEnableDefault;
          systemPkg = mkEnableDefault;

          nemo = mkEnableDefault;
          vscode = mkEnableDefault;
          zedEditor = mkEnableDefault;
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
    (lib.mkIf cfg.developmentPkg {
      environment.systemPackages = desktop.development ++ desktop.developmentGameEngines;
    })

    (lib.mkIf cfg.gamingPkg {
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

    (lib.mkIf cfg.modellingPkg {
      environment.systemPackages = desktop.modelling;
    })

    (lib.mkIf cfg.otherPkg {
      environment.systemPackages = desktop.other;
    })

    (lib.mkIf cfg.pwaPkg {
      environment.systemPackages = desktop.pwa;
    })

    (lib.mkIf cfg.systemPkg {
      environment.systemPackages = desktop.system;
    })

    (lib.mkIf cfg.nemo {
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

    (lib.mkIf cfg.vscode {
      pkgConfig.vscode = pkgs.unstable.vscode;

      programs.vscode = {
        enable = true;
        package = config.pkgConfig.vscode;
      };
    })

    (lib.mkIf cfg.zedEditor {
      pkgConfig.zedEditor = pkgs.unstable.zed-editor;

      environment.systemPackages = [
        config.pkgConfig.zedEditor
      ];
    })
  ];
}
