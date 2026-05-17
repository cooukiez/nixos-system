/*
modules/system/default.nix

part of nixos system
created 2026-02-26 by ludw
*/
{
  graphical = import ./graphical;
  network = import ./network;
  packages = import ./packages;
}
