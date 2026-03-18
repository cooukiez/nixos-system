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
