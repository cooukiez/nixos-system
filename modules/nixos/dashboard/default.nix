/*
  modules/nixos/dashboard/default.nix

  created by ludw
  on 2026-02-23
*/

{
  staticIP,
  ...
}:
{
  services.homepage-dashboard = {
    enable = true;
    listenPort = 8082;

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
                url = "http://${staticIP}:61208";
                version = 4;
                metric = "cpu";
              };
            };
          }
          {
            "Memory Usage" = {
              widget = {
                type = "glances";
                url = "http://${staticIP}:61208";
                version = 4;
                metric = "memory";
              };
            };
          }
          {
            "Network Usage" = {
              widget = {
                type = "glances";
                url = "http://${staticIP}:61208";
                version = 4;
                metric = "network:wlp0s20f3";
              };
            };
          }
          {
            "Disk I/O" = {
              widget = {
                type = "glances";
                url = "http://${staticIP}:61208";
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
              href = "http://127.0.0.1:8384";
              description = "Continuous File Synchronization";
              ping = "${staticIP}";
            };
          }
          {
            "Copyparty" = {
              icon = "https://cdn.jsdelivr.net/gh/homarr-labs/dashboard-icons/svg/copyparty.svg";
              href = "http://${staticIP}:3923";
              description = "File Server & Gallery";
              ping = "${staticIP}";
            };
          }
        ];
      }
      {
        "Network Storage" = [
          {
            "VSFTPD" = {
              icon = "mdi-server-network";
              href = "ftp://${staticIP}";
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

  services.glances = {
    enable = true;
    # ensure it listens to subnet IP
    extraArgs = [
      "-w"
      "-B"
      "${staticIP}"
    ];
  };

  services.nginx = {
    enable = true;
    virtualHosts."${staticIP}" = {
      default = true;
      serverAliases = [
        "127.0.0.1"
        "localhost"
        "lvl"
      ];
      locations."/" = {
        proxyPass = "http://127.0.0.1:8082";
        proxyWebsockets = true;
      };
    };
  };
}
