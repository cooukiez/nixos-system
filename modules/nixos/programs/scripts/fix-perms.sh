#!/usr/bin/env bash

if [ -z "$1" ]; then
  echo "Please provide a directory."
  exit 1
fi

sudo chmod -R 775 "$1"
sudo chmod -R g+s "$1"
sudo chown -R root:users "$1"

echo "Permissions fixed."
