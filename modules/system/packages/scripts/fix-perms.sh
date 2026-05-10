#!/usr/bin/env bash

if [ -z "$1" ]; then
  echo "Please provide a directory."
  exit 1
fi

chmod -R 775 "$1"
chmod -R g+s "$1"
chown -R root:users "$1"

echo "Permissions fixed."