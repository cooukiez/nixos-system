{
  inputs,
  lib,
  staticIP,
  ...
}:
let
  glancesAddress = "http://127.0.0.1:61208";
  syncthingAddress = "http://127.0.0.1:8384";
  copypartyAddress = "http://${staticIP}:3923";
  ftpAddress = "ftp://${staticIP}";
in
{
  containers.homepage = {
    autoStart = true;
    privateNetwork = false;

    specialArgs = { inherit inputs; };
    bindMounts = {
      "/etc/ssh/ssh_host_ed25519_key" = {
        hostPath = "/etc/ssh/ssh_host_ed25519_key";
        isReadOnly = true;
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

        users.mutableUsers = false;
        users.allowNoPasswordLogin = true;

        users.users.homepage-dashboard = {
          isSystemUser = true;
          group = "homepage-dashboard";
        };

        users.groups.homepage-dashboard = { };

        age.identityPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];

        services.homepage-dashboard = {
          enable = true;
          listenPort = 80;

          widgets = [
            {
              greeting = {
                text = "My Laptop";
                help = true;
              };
            }
            {
              datetime = {
                format = {
                  date = "long";
                  time = "short";
                  hour12 = false;
                };
              };
            }
            {
              openmeteo = {
                label = "Weather";

                # location: berlin
                latitude = "52.52";
                longitude = "13.40";

                units = "metric";
                cache = 5;
              };
            }
            {
              resources = {
                disk = "/";
              };
            }
          ];

          # logos: https://github.com/homarr-labs/dashboard-icons.git
          # icons: https://pictogrammers.com/library/mdi/

          services = [
            {
              "System Monitor" = [
                {
                  "CPU Usage" = {
                    widget = {
                      type = "glances";
                      url = glancesAddress;
                      version = 4;
                      metric = "cpu";
                    };
                  };
                }
                {
                  "Memory Usage" = {
                    widget = {
                      type = "glances";
                      url = glancesAddress;
                      version = 4;
                      metric = "memory";
                    };
                  };
                }
                {
                  "Network Usage" = {
                    widget = {
                      type = "glances";
                      url = glancesAddress;
                      version = 4;
                      metric = "network:wlp0s20f3";
                    };
                  };
                }
                {
                  "Disk I/O" = {
                    widget = {
                      type = "glances";
                      url = glancesAddress;
                      version = 4;
                      metric = "disk:nvme0n1";
                    };
                  };
                }
              ];
            }
            {
              "File Management" = [
                {
                  "Syncthing" = {
                    icon = "https://cdn.jsdelivr.net/gh/homarr-labs/dashboard-icons/svg/syncthing.svg";
                    href = syncthingAddress;
                    description = "Continuous File Synchronization";
                  };
                }
                {
                  "Copyparty" = {
                    icon = "https://cdn.jsdelivr.net/gh/homarr-labs/dashboard-icons/svg/copyparty.svg";
                    href = copypartyAddress;
                    description = "File Server & Gallery";
                  };
                }
              ];
            }
            {
              "Network Storage" = [
                {
                  "VSFTPD" = {
                    icon = "mdi-server-network";
                    href = ftpAddress;
                    description = "FTP Server";
                  };
                }
              ];
            }
          ];

          settings = {
            title = "lvl";
            headerStyle = "clean";
            background = "/background.png";

            layout = {
              "System Monitor" = {
                style = "row";
                columns = 4;
              };
              "File Management" = {
                style = "row";
                columns = 4;
              };
              "Network Storage" = {
                style = "row";
                columns = 4;
              };
            };
          };
        };

        systemd.services.homepage-dashboard.environment = {
          HOMEPAGE_ALLOWED_HOSTS = lib.mkForce "127.0.0.1,localhost,${staticIP}";
        };

        networking.firewall.allowedTCPPorts = [ 80 ];
        system.stateVersion = "25.11";
      };
  };
}
