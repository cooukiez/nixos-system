/*
  modules/nixos/default.nix

  created by ludw
  on 2026-02-21
*/

{
  # list module files here
  common = import ./common;
  dashboard = import ./dashboard;
  desktop = import ./desktop;
  programs = import ./programs;
}
