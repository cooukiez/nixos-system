{ pkgs, userConfig, ... }:
{
  programs.firefox = {
    enable = true;
    package = pkgs.unstable.firefox;

    policies = {
      DefaultDownloadDirectory = "\${home}/Downloads";
    };

    profiles.default = {
      id = 0;
      name = "default";
      isDefault = true;

      settings = {
        # performance
        "gfx.webrender.all" = true;
        "layers.acceleration.force-enabled" = true;
        "media.hardware-video-decoding.enabled" = true;
        "browser.cache.disk.enable" = false;
        "browser.cache.memory.enable" = true;
        "network.http.pipelining" = true;
        "network.http.pipelining.maxrequests" = 8;

        # ui tweaks
        "browser.tabs.drawInTitlebar" = true; # hides window buttons (see note below)
        "browser.compactmode.show" = true; # set for compact
        "browser.uidensity" = 0; # 1 for compact

        # kde integration
        "widget.use-xdg-desktop-portal.file-picker" = 1;
        "widget.use-xdg-desktop-portal.settings" = 1;
        "widget.gtk.global-menu.enabled" = true;
        "widget.gtk.global-menu.wayland.enabled" = true;
        "widget.gtk.native-context-menus" = false;
        # custom stylesheets
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;

        # content blocking
        "browser.contentblocking.category" = "strict";

        # set locale
        "browser.search.region" = "DE";
        "browser.search.isUS" = false;
        "distribution.searchplugins.defaultLocale" = "en-US";
        "general.useragent.locale" = "en-Us";

        # default browser
        "browser.shell.checkDefaultBrowser" = false;

        # sponsors
        "browser.newtabpage.activity-stream.system.showSponsored" = false;
        "browser.urlbar.suggest.quicksuggest.nonsponsored" = false;
        "browser.urlbar.suggest.quicksuggest.sponsored" = false;
        "services.sync.prefs.sync.browser.newtabpage.activity-stream.showSponsored" = false;
        "services.sync.prefs.sync.browser.newtabpage.activity-stream.showSponsoredTopSites" = false;

        # new tab pinned
        "browser.newtabpage.pinned" = [];

        # disable requirement for extension signatures
        "xpinstall.signatures.required" = false;
      };

      extraConfig = ''
        user_pref("toolkit.legacyUserProfileCustomizations.stylesheets", true);
      '';

      # extensions can be declarative
      extensions = with pkgs.nur.repos.rycee.firefox-addons; [
#         ublock-origin
#         bitwarden
      ];
    };
  };

  home.file.".mozilla/firefox/default/chrome/userChrome.css" = {
    text = ''
      /* Remove close button*/
      .titlebar-buttonbox-container {
        display:none
      }
    '';
  };
}
