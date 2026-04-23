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
    firefox = lib.mkOption { type = lib.types.package; };
  };

  config = lib.mkIf cfg.firefox {
    pkgConfig.firefox = pkgs.unstabe.firefox;

    programs.firefox = {
      enable = true;
      package = config.pkgConfig.firefox;

      languagePacks = [
        "en-US"
        "de"
      ];

      nativeMessagingHosts.packages = [
        pkgs.firefoxpwa
        pkgs.kdePackages.plasma-browser-integration
      ];

      policies = (import ./config-browser.nix).policies;
      preferences = (import ./config-browser.nix).preferences;
    };
  };
}
