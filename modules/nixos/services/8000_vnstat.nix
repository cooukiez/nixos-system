/*
  modules/nixos/services/8000_vnstat.nix

  created by ludw
  on 2026-03-18
*/

{
  virtualisation.oci-containers.containers.vnstat-dashboard = {
    image = "kshitizb/vnstat-dashboard:latest";

    extraOptions = [
      "--network=host"
      "--privileged"
    ];

    volumes = [
      "/var/lib/vnstat:/var/lib/vnstat:ro"
    ];

    environment = {
      PORT = "8000";
      # ALLOWED_PREFIXES = "eth,wlan,enp";
    };

    autoStart = true;
  };
}
