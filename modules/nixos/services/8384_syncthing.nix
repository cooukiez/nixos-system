/*
  modules/nixos/services/8384_syncthing.nix

  created by ludw
  on 2026-03-18
*/

{
  inputs,
  ...
}:
{
  containers.syncthing = {
    autoStart = true;
    privateNetwork = false;

    specialArgs = { inherit inputs; };
    bindMounts = {
      "/etc/ssh/ssh_host_ed25519_key" = {
        hostPath = "/etc/ssh/ssh_host_ed25519_key";
        isReadOnly = true;
      };

      "/srv/sync" = {
        hostPath = "/srv/sync";
        isReadOnly = false;
      };
      "/var/lib/syncthing" = {
        hostPath = "/var/lib/syncthing";
        isReadOnly = false;
      };

      "/data/documents" = {
        hostPath = "/data/documents";
        isReadOnly = false;
      };
      "/data/downloads" = {
        hostPath = "/data/downloads";
        isReadOnly = false;
      };
      "/data/music" = {
        hostPath = "/data/music";
        isReadOnly = false;
      };
      "/data/pictures" = {
        hostPath = "/data/pictures";
        isReadOnly = false;
      };
      "/data/videos" = {
        hostPath = "/data/videos";
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
        imports = [ inputs.agenix.nixosModules.default ];

        age.identityPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];
        age.secrets.syncthing-pw = {
          file = ../../../secrets/syncthing-pw.age;
          owner = "syncthing";
          group = "users";
        };

        # see https://wiki.nixos.org/wiki/Syncthing
        services.syncthing = {
          enable = true;

          # openDefaultPorts = true;

          # overrideDevices = true;
          # overrideFolders = true;

          # environment.STNODEFAULTFOLDER = "true";

          guiAddress = "127.0.0.1:8384";
          group = "users";

          guiPasswordFile = config.age.secrets.syncthing-pw.path;

          settings = {
            gui = {
              user = "net";
            };

            devices = {
              "pvl" = {
                id = "DFG5KAQ-5B3ECWH-NAXD36K-22VHGJ6-4G7REOC-74KTSWX-U66WICY-VMYXZAO";
              };
            };

            folders = {
              "general" = {
                path = "/srv/sync";
                devices = [ "pvl" ];
                ignorePerms = true;
              };

              # data folders
              "documents" = {
                path = "/data/documents";
                devices = [ "pvl" ];
                ignorePerms = true;
              };
              "downloads" = {
                path = "/data/downloads";
                devices = [ "pvl" ];
                ignorePerms = true;
              };
              "music" = {
                path = "/data/music";
                devices = [ "pvl" ];
                ignorePerms = true;
              };
              "pictures" = {
                path = "/data/pictures";
                devices = [ "pvl" ];
                ignorePerms = true;
              };
              "videos" = {
                path = "/data/videos";
                devices = [ "pvl" ];
                ignorePerms = true;
              };
            };
          };
        };

        networking.firewall.allowedTCPPorts = [ 8384 ];
        system.stateVersion = "25.11";
      };
  };
}
