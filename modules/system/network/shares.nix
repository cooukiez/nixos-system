/*
modules/system/network/shares.nix

part of nixos system
created 2026-04-22 by ludw
*/
{
  config,
  lib,
  ...
}: let
  cfg = config.networkConfig.samba;

  mkEnableDefault = lib.mkOption {
    type = lib.types.bool;
    default = true;
  };

  mkDisableDefault = lib.mkOption {
    type = lib.types.bool;
    default = false;
  };
in {
  options.networkConfig = {
    samba = lib.mkOption {
      type = lib.types.submodule {
        options = {
          server = mkEnableDefault;
          localNetPolicy = mkEnableDefault;

          fritzMount = mkDisableDefault;
          dhsMount = mkDisableDefault;

          shares = lib.mkOption {
            type = lib.types.attrsOf (lib.types.attrsOf lib.types.str);
            default = {};
          };
        };
      };

      default = {};
    };
  };

  config = {
    services.samba = lib.mkIf cfg.server {
      enable = true;
      settings = lib.mkMerge [
        {
          global = (
            {
              "workgroup" = "WORKGROUP";
              "server string" = "smbnix";
              "netbios name" = "smbnix";
              "security" = "user";
              "guest account" = "nobody";
              "map to guest" = "bad user";
            }
            // (lib.optionalAttrs cfg.localNetPolicy {
              "hosts allow" = "192.168.178.0/24";
              "hosts deny" = "0.0.0.0/0";
            })
          );
        }

        cfg.shares
      ];
    };

    age.secrets.fritz-smb = lib.mkIf cfg.fritzMount {
      file = ../../../secrets/smb/fritz.age;
    };

    fileSystems."/mnt/fritz" = lib.mkIf cfg.fritzMount {
      device = "//fritz.box/fritz.box";
      fsType = "cifs";
      options = [
        "credentials=${config.age.secrets.fritz-smb.path}"
        "x-systemd.automount"
        "noatime"
        "uid=1000"
        "gid=100"
        "vers=3.0"
        "x-gvfs-show"
      ];
    };

    age.secrets.dhs-smb = lib.mkIf cfg.dhsMount {
      file = ../../../secrets/smb/dhs.age;
    };

    fileSystems."/mnt/dhs" = lib.mkIf cfg.dhsMount {
      device = "//192.168.178.3/root-share";
      fsType = "cifs";
      options = [
        "credentials=${config.age.secrets.dhs-smb.path}"
        "x-systemd.automount"
        "noatime"
        "uid=0"
        "gid=0"
        "vers=3.0"
        "x-gvfs-show"
      ];
    };
  };
}
