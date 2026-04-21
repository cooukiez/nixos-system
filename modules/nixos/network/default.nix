{
  config,
  pkgs,
  lib,
  ...
}:
let
  network = import ./packages.nix { inherit pkgs; };
  cfg = config.graphicalPkgNetwork;
in
{
  options.graphicalPkgNetwork = {
    core = lib.mkOption {
      type = lib.types.bool;
      default = true;
    };
    tui = lib.mkOption {
      type = lib.types.bool;
      default = true;
    };

    ssh = lib.mkOption {
      type = lib.types.bool;
      default = true;
    };
    tailscale = lib.mkOption {
      type = lib.types.bool;
      default = true;
    };
    vsftpd = lib.mkOption {
      type = lib.types.bool;
      default = true;
    };
    printing = lib.mkOption {
      type = lib.types.bool;
      default = true;
    };
  };

  config = {
    environment.systemPackages =
      (lib.optionals cfg.core network.core) ++ (lib.optionals cfg.tui network.tui);

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

    services.printing = lib.mkIf cfg.priting {
      enable = true;
      drivers = [ pkgs.hplip ];
    };

    services.avahi = lib.mkIf cfg.priting {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
    };
  };
}
