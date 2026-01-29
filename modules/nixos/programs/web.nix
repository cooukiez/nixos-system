{
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
