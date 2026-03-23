/*
  modules/nixos/services/8080_transfer-sh.nix

  created by ludw
  on 2026-03-18
*/

{
  containers.transfer-sh = {
    autoStart = true;
    privateNetwork = false;

    bindMounts."/var/lib/transfer.sh" = {
      hostPath = "/var/lib/transfer.sh";
      isReadOnly = false;
    };

    config =
      { config, pkgs, ... }:
      {
        # transfer-sh for uploading files
        services.transfer-sh = {
          enable = true;

          provider = "local";

          settings = {
            # this does not work
            listener = ":8080";
          };
        };

        networking.firewall.allowedTCPPorts = [ 8080 ];
        system.stateVersion = "25.11";
      };
  };
}
