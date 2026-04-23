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
      policies = (import ./config-browser.nix).policies;
      policies.Preferences = (import ./config-browser.nix).preferences;
    };

    environment.systemPackages = [
      config.pkgConfig.zen-browser
    ];
  };
}
