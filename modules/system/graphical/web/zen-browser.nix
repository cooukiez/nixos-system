/*
  modules/system/graphical/web/zen-browser.nix

  part of nixos system
  created 2026-04-23 by ludw
*/

{
  config,
  pkgs,
  lib,
  ...
}:
let
  cfg = config.graphicalConfig.web;
in
{
  options.pkgConfig = {
    zen-browser = lib.mkOption { type = lib.types.package; };
  };

  config = lib.mkIf cfg.zen-browser {
    pkgConfig.zen-browser = pkgs.zen-browser.override {
      extraPolicies = (import ./config.nix).policies // {
        Preferences = (import ./config.nix).preferences;
      };
    };

    environment.systemPackages = [
      config.pkgConfig.zen-browser
    ];
  };
}
