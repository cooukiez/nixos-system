/*
  modules/nixos/default.nix

  created by ludw
  on 2026-02-17
*/

{
  # list module files here
  common = import ./common;
  desktop = import ./desktop;
  programs = import ./programs;
}
