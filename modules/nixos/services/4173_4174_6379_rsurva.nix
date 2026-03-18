{ config, pkgs, ... }:

{
  virtualisation.oci-containers.containers = {
    rsurva-db = {
      image = "redis:7-alpine";
      volumes = [
        "/var/lib/rsurva/redis:/data"
      ];
      autoStart = true;
    };

    rsurva-be = {
      image = "rsurva-be:latest";
      dependsOn = [ "rsurva-db" ];
      ports = [ "4174:8000" ];
      environment = {
        REDIS_URL = "redis://rsurva-db:6379";
      };
      autoStart = true;
    };

    rsurva-fe = {
      image = "rsurva-fe:latest";
      ports = [ "4173:4173" ];
      environment = {
        VITE_API_URL = "http://localhost:4174";
      };
      autoStart = true;
    };
  };
}
