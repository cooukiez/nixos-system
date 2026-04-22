{
  config,
  pkgs,
  lib,
  ...
}:
let
  network = import ./packages.nix { inherit pkgs; };
  cfg = config.networkConfig;

  mkEnableDefault = lib.mkOption {
    type = lib.types.bool;
    default = true;
  };
in
{
  imports = [
    ./shares.nix
  ];

  options.networkConfig = {
    corePkg = mkEnableDefault;
    tuiPkg = mkEnableDefault;

    ssh = mkEnableDefault;
    tailscale = mkEnableDefault;
    vsftpd = mkEnableDefault;
    vnstat = mkEnableDefault;
    printing = mkEnableDefault;
  };

  config = {
    environment.systemPackages =
      (lib.optionals cfg.corePkg network.core) ++ (lib.optionals cfg.tuiPkg network.tui);

    services.openssh = lib.mkIf cfg.ssh {
      enable = true;
      openFirewall = true;

      settings = {
        PermitRootLogin = "no";
        PasswordAuthentication = true;
      };
    };

    services.tailscale = lib.mkIf cfg.tailscale {
      enable = true;

      extraUpFlags = [
        "--exit-node=100.71.244.88"
        "--exit-node-allow-lan-access=true"
      ];
      extraSetFlags = [
        "--operator=ceirs"
      ];
    };

    services.vsftpd = lib.mkIf cfg.vsftpd {
      enable = true;
      openFirewall = true;

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
      '';
    };
    services.vnstat.enable = lib.mkIf cfg.vnstat true;

    services.printing = lib.mkIf cfg.printing {
      enable = true;
      drivers = [ pkgs.hplip ];
    };

    services.avahi = lib.mkIf cfg.printing {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
    };
  };
}
