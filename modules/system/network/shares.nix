{
  config,
  lib,
  ...
}:
let
  cfg = config.networkConfig.samba;

  mkEnableDefault = lib.mkOption {
    type = lib.types.bool;
    default = true;
  };
in
{
  options.networkConfig = {
    samba = lib.mkOption {
      type = lib.types.submodule {
        options = {
          server = mkEnableDefault;
          fritzMount = mkEnableDefault;
        };
      };

      default = { };
    };
  };

  config = {
    services.samba = lib.mkIf cfg.server {
      enable = true;
      settings = {
        global = {
          "workgroup" = "WORKGROUP";
          "server string" = "smbnix";
          "netbios name" = "smbnix";
          "security" = "user";
          "hosts allow" = "192.168.178.";
          "hosts deny" = "0.0.0.0/0";
          "guest account" = "nobody";
          "map to guest" = "bad user";
        };
      };
    };

    age.secrets.fritz-creds = lib.mkIf cfg.fritzMount {
      file = ../../../secrets/fritz-creds.age;
    };

    fileSystems."/mnt/fritz" = lib.mkIf cfg.fritzMount {
      device = "//fritz.box/fritz.box";
      fsType = "cifs";
      options = [
        "credentials=${config.age.secrets.fritz-creds.path}"
        "x-systemd.automount"
        "noatime"
        "uid=1000"
        "gid=100"
        "vers=3.0"
      ];
    };
  };
}
