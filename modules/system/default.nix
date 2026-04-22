/*
  modules/nixos/default.nix

  created by ludw
  on 2026-02-26
*/

{
  graphical = import ./graphical;
  network = import ./network;
  packages = import ./packages;
}
