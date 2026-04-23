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
    pkgConfig.firefox = pkgs.unstable.firefox;

    programs.firefox = {
      enable = true;
      package = pkgs.unstable.firefox;

      languagePacks = [
        "en-US"
        "de"
      ];

      nativeMessagingHosts.packages = [
        pkgs.firefoxpwa
        pkgs.kdePackages.plasma-browser-integration
      ];

      policies = (import ./config.nix).policies;
      preferences = (import ./config.nix).preferences;
    };
  };
}
