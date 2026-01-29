{
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

    # torrenting
    qbittorrent-enhanced
    qbittorrent-cli

    inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.twilight
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
