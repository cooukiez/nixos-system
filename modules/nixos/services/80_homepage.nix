/*
  modules/nixos/services/80_homepage.nix

  created by ludw
  on 2026-03-18
*/

{
  inputs,
  lib,
  staticIP,
  ...
}:
let
  glancesAddress = "http://127.0.0.1:61208";
  syncthingAddress = "http://127.0.0.1:8384";
  copypartyAddress = "http://127.0.0.1:3923";
  vnstatAddress = "http://127.0.0.1:8000";
  ftpAddress = "ftp://127.0.0.1";
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

      "/var/lib/homepage-dashboard" = {
        hostPath = "/var/lib/homepage-dashboard";
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
          listenPort = 8082;

          package = pkgs.homepage-dashboard.overrideAttrs (oldAttrs: {
            postInstall = ''
              mkdir -p $out/share/homepage/public/images
              ln -s ${./background.png} $out/share/homepage/public/images/background.png
            '';
          });

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
              "Networking" = [
                {
                  "VNStat" = {
                    icon = "mdi-chart-timeline-variant";
                    href = vnstatAddress;
                    description = "VNStat Dashboard";
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
          ];

          settings = {
            title = "lvl";
            headerStyle = "clean";

            background = {
              image = "/images/background.png";
              # blur = "";
              saturate = 75;
              brightness = 70;
              opacity = 100;
            };

            cardBlur = "md";

            layout = {
              "Networking" = {
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
              "System Monitor" = {
                style = "row";
                columns = 5;
              };
            };
          };
        };

        systemd.services.homepage-dashboard = {
          serviceConfig.PermissionsStartOnly = true;
          environment = {
            HOMEPAGE_ALLOWED_HOSTS = lib.mkForce "127.0.0.1,localhost,${staticIP}";
          };
        };

        # redirect to port 80
        services.caddy = {
          enable = true;
          virtualHosts."http://127.0.0.1, http://localhost, http://${staticIP}" = {
            extraConfig = ''
              reverse_proxy 127.0.0.1:8082 {
                  header_up Host {host}
                  header_up X-Real-IP {remote_host}
              }
            '';
          };
        };

        networking.firewall.allowedTCPPorts = [ 80 ];
        system.stateVersion = "25.11";
      };
  };
}
