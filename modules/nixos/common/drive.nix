/*
  modules/nixos/common/drive.nix

  created by ludw
  on 2026-02-26
*/

{
  pkgs,
  ...
}:
{
  services.btrfs.autoScrub = {
    enable = true;
    interval = "weekly";
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
