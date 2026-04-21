{
  age.secrets.fritz-creds = {
    file = ../../../secrets/fritz-creds.age;
  };

  services.samba = {
    enable = false;
    settings = {
      global = {
        "workgroup" = "WORKGROUP";
        "server string" = "smbnix";
        "netbios name" = "smbnix";
        "security" = "user";

        "hosts allow" = "192.168.178.";
        "hosts deny" = "0.0.0.0/0";

        "guest account" = "nobody";
        "map to guest" = "bad user";
      };
    };
  };

  #
  # mounts
  #
  fileSystems."/mnt/fritz" = {
    device = "//fritz.box/fritz.box";
    fsType = "cifs";
    options = [
      "credentials=${config.age.secrets.fritz-creds.path}"
      "x-systemd.automount"
      "noatime"
      "uid=1000"
      "gid=100"
      "vers=3.0"
    ];
  };
}
