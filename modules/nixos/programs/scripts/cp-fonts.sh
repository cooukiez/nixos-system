#!/usr/bin/env bash

SRC="/run/current-system/sw/share/X11/fonts"
DEST="$HOME/.local/share/fonts/nixos-system-sync"

echo "Creating destination directory at $DEST..."
mkdir -p "$DEST"

echo "Copying fonts (dereferencing symlinks)..."
# -r: recursive
# -L: follow symlinks (critical for nixos)
# -n: do not overwrite existing files (faster)
cp -rL "$SRC"/* "$DEST"

echo "Setting permissions..."
chmod -R 744 "$DEST"

echo "Updating font cache..."
fc-cache -fv