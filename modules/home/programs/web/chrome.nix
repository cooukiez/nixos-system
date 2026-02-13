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
