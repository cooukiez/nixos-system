/*
  modules/home-manager/desktop/kde/programs/default.nix

  created by ludw
  on 2026-01-17
*/


{ pkgs, userConfig, ... }:
{
  imports = [
    ./kate.nix
    ./konsole.nix
  ];
}
