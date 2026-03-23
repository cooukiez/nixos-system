/*
  modules/nixos/services/3923_copyparty.nix

  created by ludw
  on 2026-03-18
*/

{
  inputs,
  ...
}:
{
  containers.copyparty = {
    autoStart = true;
    privateNetwork = false;

    specialArgs = { inherit inputs; };
    bindMounts = {
      "/etc/ssh/ssh_host_ed25519_key" = {
        hostPath = "/etc/ssh/ssh_host_ed25519_key";
        isReadOnly = true;
      };

      "/srv/copyparty" = {
        hostPath = "/srv/copyparty";
        isReadOnly = false;
      };
      "/var/lib/copyparty" = {
        hostPath = "/var/lib/copyparty";
        isReadOnly = false;
      };
    };

    config =
      {
        inputs,
        config,
        pkgs,
        ...
      }:
      {
        imports = [
          inputs.agenix.nixosModules.default
          inputs.copyparty.nixosModules.default
        ];

        nixpkgs.overlays = [
          inputs.copyparty.overlays.default
        ];

        age.identityPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];
        age.secrets.copyparty-pw = {
          file = ../../../secrets/copyparty-pw.age;
          owner = "copyparty";
          group = "copyparty";
        };

        # copyparty, fast file sharing server
        services.copyparty = {
          enable = true;
          user = "copyparty";
          group = "copyparty";

          settings.i = "0.0.0.0";
          settings.p = 3923;
          settings.no-reload = true;

          accounts = {
            pm = {
              passwordFile = config.age.secrets.copyparty-pw.path;
            };
          };

          groups = {
            pg = [ "pm" ];
          };

          volumes = {
            "/" = {
              path = "/srv/copyparty";

              # see `copyparty --help-accounts`
              access = {
                # everyone gets read access
                r = "*";
                # users here get write access
                rw = [ "pm" ];
              };

              # see `copyparty --help-flags`
              flags = {
                # "fk" enables filekeys (necessary for upget permission) (4 chars long)
                fk = 4;
                # scan for new files every 60sec
                scan = 60;
                # volflag "e2d" enables the uploads database
                e2d = true;
                # "d2t" disables multimedia parsers (in case the uploads are malicious)
                d2t = true;
                # skips hashing file contents if path matches *.iso
                nohash = "\.iso$";
              };
            };
          };

          openFilesLimit = 8192;
        };

        networking.firewall.allowedTCPPorts = [ 3923 ];
        system.stateVersion = "25.11";
      };
  };
}
