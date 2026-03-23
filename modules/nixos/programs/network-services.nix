/*
  modules/nixos/programs/network-services.nix

  created by ludw
  on 2026-02-26
*/

{
  config,
  inputs,
  hostSystem,
  staticIP,
  pkgs,
  ...
}:
{
  age.secrets.fritz-creds = {
    file = ../../../secrets/fritz-creds.age;
  };

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

  # tailscale configuration
  services.tailscale = {
    enable = true;
    # useRoutingFeatures = "client";
    # extraUpFlags = [ "--accept-dns=true" ];
  };

  # remote desktop
  services.xrdp = {
    # plasma is only wm with x11 support
    defaultWindowManager = "startplasma-x11";
    enable = true;
    openFirewall = true;
  };

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

  # fritzbox smb
  fileSystems."/mnt/fritz" = {
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

  services.samba-wsdd = {
    enable = true;
    openFirewall = true;
  };
}
