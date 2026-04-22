{
  pkgs,
  lib,
  ...
}:
let
  desktop = import ./packages.nix { inherit pkgs; };
  cfg = config.graphicalConfig.programs;

  _nautilusBackspaceSrc = pkgs.fetchFromGitHub {
    owner = "TheWeirdDev";
    repo = "nautilus-backspace";
    rev = "main";
    sha256 = "sha256-4x5bMIgwNIp9nxuCHWLLNvWG2zuviyEOyCZgVLRZ5W4=";
  };

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
          system = mkEnableDefault;

          programNautilus = mkEnableDefault;
        };
      };

      default = { };
    };
  };

  config = lib.mkMerge [
    (lib.mkIf cfg.development {
      environment.systemPackages = desktop.development ++ desktop.developmentGameEngines;
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

    (lib.mkIf cfg.system {
      environment.systemPackages = desktop.system;
    })

    (lib.mkIf cfg.programNautilus {
      environment.systemPackages = desktop.nautilus;

      environment.pathsToLink = [
        "/share/nautilus-python/extensions"
      ];
    })
  ];
}
