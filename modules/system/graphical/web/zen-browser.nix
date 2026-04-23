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
    zen-browser = pkgs.zen-browser.override {
      policies = {
        DisableAppUpdate = true;
        DisableTelemetry = true;
      };
    };
  };

  config = lib.mkIf cfg.zen-browser {
    environment.systemPackages = [
      config.pkgConfig.zen-browser
    ];
  };
}
