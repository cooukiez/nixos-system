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
    firefox = pkgs.unstable.firefox;
  };

  config = lib.mkIf cfg.firefox {
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

      preferences = {
        "widget.use-xdg-desktop-portal.file-picker" = 1;
      };

      policies = {
        AutofillAddressEnabled = true;
        AutofillCreditCardEnabled = false;

        DisableAppUpdate = true;
        DisableFeedbackCommands = true;
        DisableFirefoxStudies = true;
        DisablePocket = true;
        DisableTelemetry = true;

        DontCheckDefaultBrowser = true;

        NoDefaultBookmarks = true;
        OfferToSaveLogins = false;

        EnableTrackingProtection = {
          Value = true;
          Locked = true;
          Cryptomining = true;
          Fingerprinting = true;
        };
      };
    };
  };
}
