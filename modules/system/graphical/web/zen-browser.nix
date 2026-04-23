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
