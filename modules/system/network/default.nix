/*
modules/system/network/default.nix

part of nixos system
created 2026-04-22 by ludw
*/
{
  config,
  pkgs,
  lib,
  ...
}: let
  network = import ./packages.nix {inherit pkgs;};
  cfg = config.networkConfig;

  mkEnableDefault = lib.mkOption {
    type = lib.types.bool;
    default = true;
  };

  mkDisableDefault = lib.mkOption {
    type = lib.types.bool;
    default = false;
  };
in {
  imports = [
    ./shares.nix
  ];

  options.networkConfig = {
    corePkg = mkEnableDefault;
    tuiPkg = mkEnableDefault;

    ssh = mkEnableDefault;

    tailscaleClient = mkDisableDefault;
    tailscaleServer = mkDisableDefault;

    tailscaleClientExitNode = lib.mkOption {
      type = lib.types.str;
      default = "";
    };

    tailscaleOperator = lib.mkOption {
      type = lib.types.str;
      default = "root";
    };

    vnstat = mkEnableDefault;
    vsftpd = mkEnableDefault;

    printing = mkDisableDefault;

    glances = mkDisableDefault;
    glancesPort = lib.mkOption {
      type = lib.types.int;
      default = 61208;
    };
  };

  config = {
    environment.systemPackages =
      (lib.optionals cfg.corePkg network.core) ++ (lib.optionals cfg.tuiPkg network.tui);

    services.openssh = lib.mkIf cfg.ssh {
      enable = true;
      openFirewall = true;

      settings = {
        UseDns = true;
        X11Forwarding = false;

        PermitRootLogin = "no";
        PasswordAuthentication = true;
      };
    };

    services.tailscale = let
      tailscaleEnabled = cfg.tailscaleClient || cfg.tailscaleServer;
    in
      lib.mkIf tailscaleEnabled {
        enable = true;

        extraUpFlags =
          []
          ++ lib.optionals cfg.tailscaleClient [
            "--exit-node=${cfg.tailscaleClientExitNode}"
            "--exit-node-allow-lan-access=true"
          ]
          ++ lib.optionals cfg.tailscaleServer [
            "--advertise-exit-node"
            "--advertise-routes=192.168.178.0/24"
          ];

        extraSetFlags = [
          "--operator=${cfg.tailscaleOperator}"
        ];
      };

    services.networkd-dispatcher = lib.mkIf cfg.tailscaleServer {
      enable = true;
      rules."50-tailscale-optimizations" = {
        onState = ["routable"];
        script = ''
          ${pkgs.ethtool}/bin/ethtool -K eth0 rx-udp-gro-forwarding on rx-gro-list off
        '';
      };
    };

    services.vnstat.enable = lib.mkIf cfg.vnstat true;

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
      '';
    };

    networking.firewall = lib.mkIf cfg.vsftpd {
      allowedTCPPorts = [21];
      allowedTCPPortRanges = [
        {
          from = 30000;
          to = 31000;
        }
      ];
    };

    services.printing = lib.mkIf cfg.printing {
      enable = true;
      drivers = [pkgs.hplip];
    };

    services.avahi = lib.mkIf cfg.printing {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
    };

    services.glances = lib.mkIf cfg.glances {
      enable = true;

      extraArgs = [
        "-w"
        "-p"
        "${toString cfg.glancesPort}"
        "-B"
        "0.0.0.0"
      ];
    };
  };
}
