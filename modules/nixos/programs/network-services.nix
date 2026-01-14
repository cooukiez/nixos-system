{ lib, pkgs, inputs, ... }:
{
  environment.systemPackages = with pkgs; [
    # enable copyparty from flake
    inputs.copyparty.packages.${pkgs.system}.copyparty
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

  # ftp server
  services.vsftpd = {
    enable = true;                # enable the service
    listen = true;                # vsftpd listens for IPv4 connections
    listen_ipv6 = false;          # disable IPv6 listening
    anonymous_enable = false;     # disable anonymous login
    local_enable = true;          # allow local users to log in
    write_enable = true;          # allow uploads and modifications
    chroot_local_user = true;     # restrict users to their home directories
    local_umask = "022";          # default permissions for uploaded files
    pasv_enable = true;           # enable passive mode
    pasv_min_port = 30000;        # passive port range start
    pasv_max_port = 31000;        # passive port range end
  };

  # copyparty
  services.copyparty = {
    enable = true;
    port = 8000;
    storage = "/srv/copyparty";
  };
}
