{
  containers.glances = {
    autoStart = true;
    privateNetwork = false;

    config =
      { config, pkgs, ... }:
      {
        services.glances = {
          enable = true;
          extraArgs = [
            "-w"
            "-p"
            "61208"
            "-B"
            "0.0.0.0"
          ];
        };

        networking.firewall.allowedTCPPorts = [ 61208 ];
        system.stateVersion = "25.11";
      };
  };
}
