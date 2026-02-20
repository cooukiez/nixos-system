let
  serverIP = "192.168.178.24";
in
{
  services.homepage-dashboard = {
    enable = true;
    listenPort = 8082;

    services = [
      {
        "File Management" = [
          {
            "Syncthing" = {
              icon = "syncthing.png";
              href = "http://127.0.0.1:8384";
              description = "Continuous File Synchronization";
              ping = "${serverIP}";
            };
          }
          {
            "Copyparty" = {
              icon = "folder";
              href = "http://${serverIP}:3923";
              description = "File Server & Gallery";
              ping = "${serverIP}";
            };
          }
        ];
      }
      {
        "Network Storage" = [
          {
            "VSFTPD" = {
              icon = "server";
              href = "ftp://${serverIP}";
              description = "FTP Server";
            };
          }
        ];
      }
    ];

    settings = {
      title = "lvl";
      headerStyle = "clean";
      layout = {
        "File Management" = {
          style = "row";
          columns = 3;
        };
        "Network Storage" = {
          style = "row";
          columns = 3;
        };
      };
    };
  };

  services.nginx = {
    enable = true;
    virtualHosts."${serverIP}" = {
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
