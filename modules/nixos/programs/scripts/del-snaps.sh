!/usr/bin/env bash

# delete ALL snapshots in the defined directories

SNAPSHOT_DIRS=(
  "/snapshots/system"
  "/snapshots/home"
  "/snapshots/data"
)

for base_dir in "${SNAPSHOT_DIRS[@]}"; do
  if [ -d "$base_dir" ]; then
    echo "Purging all snapshots in $base_dir..."
    find "$base_dir" -mindepth 1 -maxdepth 1 -type d -exec sh -c '
      for dir do
        btrfs subvolume delete "$dir"/*
        rmdir "$dir"
      done
    ' sh {} +
  else
    echo "Directory $base_dir does not exist. Skipping."
  fi
done

echo "All snapshots deleted."