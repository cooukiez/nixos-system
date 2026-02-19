#!/usr/bin/env bash

# this script calculates the disk usage of BTRFS snapshots in /snapshots

if [[ $EUID -ne 0 ]]; then
   echo "Please run this script as root."
   exit 1
fi

echo "Calculating BTRFS snapshot space usage..."
echo "This can take a few minutes because BTRFS must calculate deduplicated extents block-by-block."
echo "---------------------------------------------------------------------------------------------"

btrfs filesystem du -s /snapshots/*/*/*