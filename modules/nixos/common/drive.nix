{
  pkgs,
  ...
}:
{
  services.btrfs.autoScrub = {
    enable = true;
    interval = "weekly";
  };

  # system snapshots (daily)
  systemd.services.snapshot-system = {
    description = "btrfs system snapshot";
    serviceConfig.Type = "oneshot";
    path = with pkgs; [
      coreutils
      btrfs-progs
    ];
    script = ''
      mkdir -p /snapshots/system
      DATE=$(date +%Y-%m-%d-%H%M)

      btrfs subvolume snapshot -r / /snapshots/system/root-$DATE
      btrfs subvolume snapshot -r /nix /snapshots/system/nix-$DATE
      btrfs subvolume snapshot -r /var /snapshots/system/var-$DATE
    '';
  };

  systemd.timers.snapshot-system = {
    wantedBy = [ "timers.target" ];
    timerConfig = {
      OnCalendar = "daily";
      Persistent = true;
    };
  };

  # home snapshots (hourly)
  systemd.services.snapshot-home = {
    description = "btrfs home snapshot";
    serviceConfig.Type = "oneshot";
    path = with pkgs; [
      coreutils
      btrfs-progs
    ];
    script = ''
      mkdir -p /snapshots/home
      DATE=$(date +%Y-%m-%d-%H%M)

      btrfs subvolume snapshot -r /home /snapshots/home/home-$DATE
    '';
  };

  systemd.timers.snapshot-home = {
    wantedBy = [ "timers.target" ];
    timerConfig = {
      OnCalendar = "hourly";
      Persistent = true;
    };
  };

  # data snapshots (every 30 min)
  systemd.services.snapshot-data = {
    description = "btrfs data snapshot";
    serviceConfig.Type = "oneshot";
    path = with pkgs; [
      coreutils
      btrfs-progs
    ];
    script = ''
      mkdir -p /snapshots/data
      DATE=$(date +%Y-%m-%d-%H%M)

      btrfs subvolume snapshot -r /data /snapshots/data/data-$DATE
    '';
  };

  systemd.timers.snapshot-data = {
    wantedBy = [ "timers.target" ];
    timerConfig = {
      OnCalendar = "*:0/30";
      Persistent = true;
    };
  };

  # cleanup policy
  systemd.services.snapshot-cleanup = {
    description = "cleanup old snapshots";
    serviceConfig.Type = "oneshot";
    path = with pkgs; [
      findutils
      btrfs-progs
    ];
    script = ''
      find /snapshots/system -maxdepth 1 -type d -mtime +14 -exec btrfs subvolume delete {} \;
      find /snapshots/home -maxdepth 1 -type d -mtime +7 -exec btrfs subvolume delete {} \;
      find /snapshots/data -maxdepth 1 -type d -mtime +3 -exec btrfs subvolume delete {} \;
    '';
  };

  systemd.timers.snapshot-cleanup = {
    wantedBy = [ "timers.target" ];
    timerConfig.OnCalendar = "daily";
  };
}
