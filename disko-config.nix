/*
  disko-config.nix

  created by ludw
  on 2026-02-14
*/

{ lib, ... }:
{
  disko.devices.disk = {
    lvl-disk = {
      type = "disk";

      # todo: do not hardcode this
      device = "/dev/nvme0n1";
      content = {
        type = "gpt";
        partitions = {
          ESP = {
            type = "EF00";
            size = "1G";
            label = "esp";
            content = {
              type = "filesystem";
              format = "vfat";
              mountpoint = "/boot";
              mountOptions = [ "umask=0077" ];
            };
          };
          swap = {
            type = "8200";
            size = "32G";
            label = "swap";
          };
          nixos = {
            size = "100%";
            label = "nixos";
            content = {
              type = "btrfs";
              extraArgs = [ "--force" ];
              subvolumes = {
                "root" = {
                  mountpoint = "/";
                  mountOptions = [
                    "subvol=root"
                    "compress=zstd"
                    "noatime"
                  ];
                };
                "nix" = {
                  mountpoint = "/nix";
                  mountOptions = [
                    "subvol=nix"
                    "compress=zstd"
                    "noatime"
                  ];
                };
                "home" = {
                  mountpoint = "/home";
                  mountOptions = [
                    "subvol=home"
                    "compress=zstd"
                    "noatime"
                  ];
                };
                "var" = {
                  mountpoint = "/var";
                  mountOptions = [
                    "subvol=var"
                    "compress=zstd"
                    "noatime"
                  ];
                };
                "data" = {
                  mountpoint = "/data";
                  mountOptions = [
                    "subvol=data"
                    "compress=zstd"
                    "noatime"
                  ];
                };
              };
            };
          };
        };
      };
    };
  };
}
