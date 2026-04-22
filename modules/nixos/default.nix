/*
  modules/nixos/default.nix

  created by ludw
  on 2026-02-26
*/

{
  imports = [
    ./graphical
  ];

  common = import ./common;
  desktop = import ./desktop;
  packages = import ./packages;
  programs = import ./programs;
  services = import ./services;
}
