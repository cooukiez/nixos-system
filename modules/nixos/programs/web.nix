/*
  modules/nixos/programs/web.nix

  created by ludw
  on 2026-01-29
*/

{
  inputs,
  hostSystem,
  pkgs,
  ...
}:
{
  environment.systemPackages = with pkgs; [
    # web browsers
    google-chrome

    # messenger
    signal-desktop
    discord
    legcord
    element-desktop
    # cinny-desktop

    # torrenting
    qbittorrent-enhanced
    qbittorrent-cli
    inputs.zen-browser.packages.${hostSystem}.twilight
  ];

  programs.firefox = {
    enable = true;
    package = pkgs.firefox;

    languagePacks = [
      "en-US"
      "de"
    ];
    nativeMessagingHosts.packages = [
      pkgs.kdePackages.plasma-browser-integration
    ];
    preferences = {
      "widget.use-xdg-desktop-portal.file-picker" = 1;
    };

    policies = {
      DisableTelemetry = true;
    };
  };

  programs.thunderbird = {
    enable = true;
    package = pkgs.unstable.thunderbird;
  };
}
