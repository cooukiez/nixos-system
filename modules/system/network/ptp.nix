{
  inputs,
  config,
  pkgs,
  lib,
  ...
}: let
  cfg = config.networkConfig;
in {
  imports = [
    inputs.copyparty.nixosModules.default
  ];

  users.users.copyparty = {
    isSystemUser = true;
    group = "copyparty";
  };

  users.groups.copyparty = {};

  # open firewall for ptp sharing
  networking.firewall = lib.mkMerge [
    (lib.mkIf cfg.vsftpd {
      allowedTCPPorts = [21];
      allowedTCPPortRanges = [
        {
          from = 30000;
          to = 31000;
        }
      ];
    })

    (lib.mkIf cfg.copyparty {
      allowedTCPPorts = [8000];
    })
  ];

  # vsftpd
  services.vsftpd = lib.mkIf cfg.vsftpd {
    enable = true;

    localUsers = true;
    writeEnable = true;

    chrootlocalUser = true;
    allowWriteableChroot = true;

    localRoot = null;
    anonymousUser = false;

    forceLocalLoginsSSL = false;
    forceLocalDataSSL = false;

    extraConfig = ''
      listen=YES
      listen_ipv6=NO
      local_umask=022
      pasv_enable=YES
      pasv_min_port=30000
      pasv_max_port=31000
      pam_service_name=ftp
    '';
  };

  # copyparty
  age.secrets.copyparty = lib.mkIf cfg.copyparty {
    owner = "copyparty";
    group = "copyparty";
  };

  systemd.tmpfiles.rules = lib.mkIf cfg.copyparty [
    "d /srv/copyparty 0775 copyparty copyparty -"
  ];

  services.copyparty = lib.mkIf cfg.copyparty {
    enable = true;

    package = pkgs.copyparty.override {
      extraPackages = [pkgs.exiftool];
    };

    user = "copyparty";
    group = "copyparty";

    settings.i = "0.0.0.0";
    settings.p = 8000;
    settings.no-reload = true;

    accounts = {
      pm.passwordFile = config.age.secrets.copyparty.path;
    };

    groups = {
      pg = ["pm"];
    };

    volumes = {
      "/" = {
        path = "/srv/copyparty";

        # see `copyparty --help-accounts`
        access = {
          r = "*";
          rw = ["pm"];
          d = ["pm"];
        };

        # see `copyparty --help-flags`
        flags = {
          fk = 4;
          scan = 60;
          e2d = true;
          d2t = true;

          # skips hashing file contents if matches
          nohash = "\.iso$";
        };
      };
    };

    openFilesLimit = 8192;
  };
}
