/*
  modules/home/programs/browsers/zen-browser.nix

  created by ludw
  on 2026-01-29
*/

{
  pkgs,
  ...
}:
{
  # see https://github.com/0xc000022070/zen-browser-flake
  programs.zen-browser = {
    enable = true;

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

        # desktop integration
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
        "browser.newtabpage.pinned" = [ ];

        # disable requirement for extension signatures
        "xpinstall.signatures.required" = false;
      };

      # see https://github.com/0xc000022070/zen-browser-flake#search
      search = {
        # needed for nix to overwrite search settings on rebuild
        force = true;
        default = "google";

        engines = {
          mynixos = {
            name = "My NixOS";
            urls = [
              {
                template = "https://mynixos.com/search?q={searchTerms}";
                params = [
                  {
                    name = "query";
                    value = "searchTerms";
                  }
                ];
              }
            ];

            icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
            definedAliases = [ "@nx" ];
          };
        };
      };
    };
  };
}
