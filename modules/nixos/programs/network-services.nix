/*
  modules/nixos/programs/network-services.nix

  created by ludw
  on 2026-02-21
*/

{
  config,
  inputs,
  hostSystem,
  pkgs,
  ...
}:
{
  age.secrets.copyparty-pw = {
    file = ../../../secrets/copyparty-pw.age;
    owner = "copyparty";
    group = "copyparty";
  };

  age.secrets.syncthing-pw = {
    file = ../../../secrets/syncthing-pw.age;
    owner = "syncthing";
    group = "users";
  };

  age.identityPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];

  environment.systemPackages = with pkgs; [
    # enable copyparty standalone package
    pkgs.copyparty
    # age encrypted secrets management
    inputs.agenix.packages.${hostSystem}.default
  ];

  # openssh
  services.openssh = {
    enable = true;
    settings = {
      # opinionated: forbid root login through SSH
      PermitRootLogin = "no";
      # opinionated: keys and passwords
      PasswordAuthentication = true;
    };
  };

  # remote desktop
  services.xrdp = {
    # plasma is only wm with x11 support
    defaultWindowManager = "startplasma-x11";
    enable = true;
    openFirewall = true;
  };

  # see https://wiki.nixos.org/wiki/Syncthing
  services.syncthing = {
    enable = true;
    openDefaultPorts = true;

    # overrideDevices = true;
    # overrideFolders = true;

    # environment.STNODEFAULTFOLDER = "true";

    guiAddress = "127.0.0.1:8384";
    group = "users";

    guiPasswordFile = config.age.secrets.syncthing-pw.path;

    settings = {
      gui = {
        user = "net";
      };

      devices = {
        "pvl" = {
          id = "DFG5KAQ-5B3ECWH-NAXD36K-22VHGJ6-4G7REOC-74KTSWX-U66WICY-VMYXZAO";
        };
      };

      folders = {
        "general" = {
          path = "/srv/sync";
          devices = [ "pvl" ];
          ignorePerms = true;
        };

        # data folders
        "documents" = {
          path = "/data/documents";
          devices = [ "pvl" ];
          ignorePerms = true;
        };
        "downloads" = {
          path = "/data/downloads";
          devices = [ "pvl" ];
          ignorePerms = true;
        };
        "music" = {
          path = "/data/music";
          devices = [ "pvl" ];
          ignorePerms = true;
        };
        "pictures" = {
          path = "/data/pictures";
          devices = [ "pvl" ];
          ignorePerms = true;
        };
        "videos" = {
          path = "/data/videos";
          devices = [ "pvl" ];
          ignorePerms = true;
        };
      };
    };
  };

  /*
    users.users.syncthing = {
      isSystemUser = true;
      extraGroups = [ "users" ];
    };
  */

  # ftp server
  services.vsftpd = {
    enable = true;

    # local users
    localUsers = true;
    writeEnable = true;

    chrootlocalUser = true;
    allowWriteableChroot = true;

    localRoot = null; # optional, keep home directory as root

    # anonymous access
    anonymousUser = false;

    # ssl not configured here, so do not force it
    forceLocalLoginsSSL = false;
    forceLocalDataSSL = false;

    # extra raw vsftpd.conf settings
    extraConfig = ''
      listen=YES
      listen_ipv6=NO
      local_umask=022
      pasv_enable=YES
      pasv_min_port=30000
      pasv_max_port=31000
    '';
  };

  # copyparty, fast file sharing server
  services.copyparty = {
    enable = true;
    user = "copyparty";
    group = "copyparty";

    settings.i = "0.0.0.0";
    settings.p = 3923;
    settings.no-reload = true;

    accounts = {
      pm = {
        passwordFile = config.age.secrets.copyparty-pw.path;
      };
    };

    groups = {
      pg = [ "pm" ];
    };

    volumes = {
      "/" = {
        path = "/srv/copyparty";

        # see `copyparty --help-accounts`
        access = {
          # everyone gets read access
          r = "*";
          # users here get write access
          rw = [ "pm" ];
        };

        # see `copyparty --help-flags`
        flags = {
          # "fk" enables filekeys (necessary for upget permission) (4 chars long)
          fk = 4;
          # scan for new files every 60sec
          scan = 60;
          # volflag "e2d" enables the uploads database
          e2d = true;
          # "d2t" disables multimedia parsers (in case the uploads are malicious)
          d2t = true;
          # skips hashing file contents if path matches *.iso
          nohash = "\.iso$";
        };
      };
    };

    openFilesLimit = 8192;
  };

  # samba
  services.samba = {
    enable = true;
    openFirewall = true;
    settings = {
      global = {
        "workgroup" = "WORKGROUP";
        "server string" = "smbnix";
        "netbios name" = "smbnix";
        "security" = "user";

        # "hosts allow" = "192.168.0. 127.0.0.1 localhost";
        # "hosts deny" = "0.0.0.0/0";

        "guest account" = "nobody";
        "map to guest" = "bad user";
      };

      /*
        "data" = {
          "path" = "/data";
          "browseable" = "no";
          "read only" = "no";
          "guest ok" = "no";
          "create mask" = "0664";
          "directory mask" = "0775";
          "force group" = "users";
        };
      */
    };
  };

  services.samba-wsdd = {
    enable = true;
    openFirewall = true;
  };

  # transfer-sh for uploading files
  services.transfer-sh = {
    enable = true;

    provider = "local";

    settings = {
      # this does not work
      listener = ":8080";
    };
  };
}
