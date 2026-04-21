/*
  modules/nixos/default.nix

  created by ludw
  on 2026-02-26
*/

{
  # list module files here
  common = import ./common;
  desktop = import ./desktop;
  packages = import ./packages;
  programs = import ./programs;
  services = import ./services;
}
