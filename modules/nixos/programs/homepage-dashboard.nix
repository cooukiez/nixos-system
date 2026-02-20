{
  services.homepage-dashboard = {
    enable = true;
    listenPort = 8082;

    # Highly recommended: Use an environment file for secrets like your Syncthing API key
    # environmentFile = "/var/lib/homepage-dashboard/.env";

    services = [
      {
        "File Management" = [
          {
            "Syncthing" = {
              icon = "syncthing.png";
              href = "http://192.168.1.10:8384";
              description = "Continuous File Synchronization";
              widget = {
                type = "syncthing";
                url = "http://192.168.1.10:8384";
                # If using environmentFile, you can template this: "{{HOMEPAGE_VAR_SYNCTHING_KEY}}"
                key = "your_syncthing_api_key_here";
              };
            };
          }
          {
            "Copyparty" = {
              icon = "folder"; # Homepage includes many generic icons
              href = "http://192.168.1.10:3923";
              description = "File Server & Gallery";
              # Since Homepage doesn't have a native Copyparty widget,
              # a ping/port check acts as a status widget on the dashboard.
              ping = "192.168.1.10:3923";
            };
          }
        ];
      }
      {
        "Network Storage" = [
          {
            "VSFTPD" = {
              icon = "server";
              href = "ftp://192.168.1.10"; # Direct FTP link
              description = "FTP Server";
              # Optional: Add a port check to ensure the FTP server is online
              widget = {
                type = "port";
                server = "192.168.1.10";
                port = 21;
              };
            };
          }
        ];
      }
    ];

    # Optional: Customize the look and feel
    settings = {
      title = "My NixOS Homelab";
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
}
