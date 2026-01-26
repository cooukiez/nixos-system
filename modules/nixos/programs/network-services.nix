{
  lib,
  pkgs,
  inputs,
  ...
}:
let
  copyparty_pm_password = pkgs.writeText "copyparty-pm-password" ''
    fileupload123
  '';
in
{
  environment.systemPackages = with pkgs; [
    # enable copyparty from flake
    pkgs.copyparty
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

  # network statistics
  services.vnstat.enable = true;

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

  # copyparty
  services.copyparty = {
    enable = true;

    user = "copyparty";
    group = "copyparty";

    settings.i = "0.0.0.0";
    settings.p = 8000;
    settings.no-reload = true;

    accounts = {
      pm = {
        # provide the path to a file containing the password, keeping it out of /nix/store
        # must be readable by the copyparty service user
        passwordFile = "${copyparty_pm_password}";
      };
    };

    groups = {
      pg = [ "pm" ];
    };

    volumes = {
      # volume at "/" (the webroot)
      "/" = {
        # share the contents of "/srv/copyparty"
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

    # you may increase the open file limit for the process
    openFilesLimit = 8192;
  };
}
