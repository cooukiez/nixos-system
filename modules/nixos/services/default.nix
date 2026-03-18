/*
  modules/nixos/dashboard/default.nix

  created by ludw
  on 2026-02-26
*/

{
  staticIP,
  ...
}:
{
  imports = [
    ./80_homepage.nix
    ./3923_copyparty.nix
    ./8000_vnstat.nix
    ./8080_transfer-sh.nix
    ./8384_syncthing.nix
    ./61208_glances.nix
  ];

  boot.enableContainers = true;
  virtualisation.containers.enable = true;
  virtualisation.docker.enable = true;
  virtualisation.docker.storageDriver = "btrfs";

  networking = {
    nat = {
      enable = true;
      internalInterfaces = [ "ve-+" ];
      externalInterface = "eth0";
    };
  };
}
