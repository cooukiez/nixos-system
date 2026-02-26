/*
  modules/nixos/programs/web.nix

  created by ludw
  on 2026-02-23
*/

{
  inputs,
  hostSystem,
  pkgs,
  ...
}:
{
  environment.systemPackages = with pkgs; [
    # messenger
    signal-desktop
    unstable.discord
    unstable.legcord
    element-desktop
    # cinny-desktop

    # torrenting
    qbittorrent-enhanced
    qbittorrent-cli

    # browser extensions
    firefoxpwa
    kdePackages.plasma-browser-integration
  ];

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
}
