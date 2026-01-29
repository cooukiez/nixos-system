/*
  modules/nixos/default.nix

  created by ludw
  on 2026-01-29
*/

{
  # list module files here
  common = import ./common;
  desktop = import ./desktop;
  programs = import ./programs;
}
