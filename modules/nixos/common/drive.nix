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
      DATE=$(date +%Y-%m-%d-%H%M)

      mkdir -p /snapshots/system/root-$DATE
      mkdir -p /snapshots/system/nix-$DATE
      mkdir -p /snapshots/system/var-$DATE

      btrfs subvolume snapshot -r / /snapshots/system/root-$DATE/root
      btrfs subvolume snapshot -r /nix /snapshots/system/nix-$DATE/nix
      btrfs subvolume snapshot -r /var /snapshots/system/var-$DATE/var
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
      DATE=$(date +%Y-%m-%d-%H%M)
      mkdir -p /snapshots/home/home-$DATE
      btrfs subvolume snapshot -r /home /snapshots/home/home-$DATE/home
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
      DATE=$(date +%Y-%m-%d-%H%M)
      mkdir -p /snapshots/data/data-$DATE
      btrfs subvolume snapshot -r /data /snapshots/data/data-$DATE/data
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
      find /snapshots/system -mindepth 1 -maxdepth 1 -type d -mtime +14 -exec sh -c '
        for dir do
          btrfs subvolume delete "$dir"/*
          rmdir "$dir"
        done
      ' sh {} +; \
      find /snapshots/home -mindepth 1 -maxdepth 1 -type d -mtime +7 -exec sh -c '
        for dir do
          btrfs subvolume delete "$dir"/*
          rmdir "$dir"
        done
      ' sh {} +; \
      find /snapshots/data -mindepth 1 -maxdepth 1 -type d -mtime +3 -exec sh -c '
        for dir do
          btrfs subvolume delete "$dir"/*
          rmdir "$dir"
        done
      ' sh {} +
    '';
  };

  systemd.timers.snapshot-cleanup = {
    wantedBy = [ "timers.target" ];
    timerConfig.OnCalendar = "daily";
  };
}
