/*
  modules/home-manager/desktop/kde/programs/konsole.nix

  created by ludw
  on 2026-01-29
*/

{ pkgs, userConfig, ... }:
{
  programs.konsole = {
    enable = true;

    profiles.default = {
      name = "default";

      extraConfig = {

      };
    };
  };
}
