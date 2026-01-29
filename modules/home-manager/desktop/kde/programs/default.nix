/*
  modules/home-manager/desktop/kde/programs/default.nix

  created by ludw
  on 2026-01-29
*/

{ pkgs, userConfig, ... }:
{
  imports = [
    ./kate.nix
    ./konsole.nix
  ];
}
