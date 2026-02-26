/*
  modules/home/programs/web/chrome.nix

  created by ludw
  on 2026-02-23
*/

{
  pkgs,
  ...
}:
{
  programs.chromium = {
    enable = true;
    package = pkgs.google-chrome;

    dictionaries = [
      pkgs.hunspellDictsChromium.en_US
    ];

    nativeMessagingHosts = [
      pkgs.kdePackages.plasma-browser-integration
    ];
  };
}
