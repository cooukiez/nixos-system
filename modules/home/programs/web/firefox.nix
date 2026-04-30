/*
  modules/home/programs/web/firefox.nix

  created by ludw
  on 2026-02-26
*/

{
  config,
  pkgs,
  lib,
  ...
}:
let
  cfg = config.graphicalPrograms.firefox;
  settings = import ./settings.nix;
in
{
  config = lib.mkIf cfg {
    programs.firefox = {
      enable = true;
      package = pkgs.unstable.firefox;

      profiles.default = {
        id = 0;
        name = "default";
        isDefault = false;

        settings = settings.core // settings.firefoxCore;
      };

      profiles.new = {
        id = 1;
        name = "new";
        isDefault = true;

        settings =
          settings.core
          // settings.firefoxCore
          // {
            # hides window buttons
            "browser.tabs.drawInTitlebar" = true;

            "browser.compactmode.show" = true;
            "browser.uidensity" = 0;

            # disable welcome / tips stuff
            "browser.aboutwelcome.enabled" = false;
            "browser.startup.firstrunSkipsHomepage" = true;

            "browser.uitour.enabled" = false;
            "browser.tips.enabled" = false;
            "browser.vpn_promo.enabled" = false;
            "browser.promo.focus.enabled" = false;

            "browser.newtabpage.activity-stream.asrouter.userprefs.cfr.addons" = false;
            "browser.newtabpage.activity-stream.asrouter.userprefs.cfr.features" = false;

            # sidebar disable chatbot
            "browser.ml.chat.enabled" = false;
            "browser.ml.chat.sidebar" = false;

            # bookmarks toolbar
            "browser.toolbars.bookmarks.visibility" = "newtab";

            "browser.uiCustomization.state" = builtins.toJSON {
              placements = {
                "widget-overflow-fixed-list" = [ ];

                "unified-extensions-area" = [
                  "addon_darkreader_org-browser-action"

                  "clearurls_kevin_roebert-browser-action"

                  "sponsorblocker_ajay_app-browser-action"
                  "sponsorblocker_spotsponsorblock_org-browser-action"
                ];

                "nav-bar" = [
                  "back-button"
                  "forward-button"
                  "stop-reload-button"
                  "vertical-spacer"
                  "urlbar-container"
                  "downloads-button"
                  "unified-extensions-button"

                  "ublock0_raymondhill_net-browser-action"
                  "_446900e4-71c2-419f-a6a7-df9c091e268b_-browser-action"
                  "passbolt_passbolt_com-browser-action"
                ];

                "toolbar-menubar" = [
                  "menubar-items"
                ];

                "TabsToolbar" = [
                  "firefox-view-button"
                  "tabbrowser-tabs"
                  "new-tab-button"
                ];

                "vertical-tabs" = [ ];

                "PersonalToolbar" = [
                  "personal-bookmarks"
                ];
              };

              seen = [
                "developer-button"
                "screenshot-button"

                "ublock0_raymondhill_net-browser-action"
              ];

              dirtyAreaCache = [
                "nav-bar"
                "vertical-tabs"
                "PersonalToolbar"
                "toolbar-menubar"
                "TabsToolbar"
                "unified-extensions-area"
              ];

              currentVersion = 23;
              newElementCount = 2;
            };
          };

        extensions = {
          force = true;
          packages =
            let
              unlicense =
                pkg:
                pkg.overrideAttrs (old: {
                  meta = (old.meta or { }) // {
                    license = [ ];
                  };
                });
            in
            with pkgs.firefox-addons;
            map unlicense [
              ublock-origin

              bitwarden-password-manager
              passbolt

              darkreader

              clearurls
              i-dont-want-cookies

              sink-it-for-reddit
              reddit-ad-remover
              reddit-nsfw-unblocker

              sponsorblock
              spot-sponsorblock

              youtube-recommended-videos

              violentmonkey
            ];
        };
      };
    };

    home.file.".mozilla/firefox/default/chrome/userChrome.css" = {
      text = ''
        /* remove close button */
        .titlebar-buttonbox-container {
          display:none
        }
      '';
    };

    home.file.".mozilla/firefox/new/chrome/userChrome.css" = {
      text = ''
        /* remove close button */
        .titlebar-buttonbox-container {
          display:none
        }
      '';
    };

    # firefoxpwa settings
    home.file.".local/share/firefoxpwa/profiles/00000000000000000000000000/user.js" = {
      text = ''
        user_pref("firefoxpwa.enableHidingIconBar", true);

        user_pref("browser.search.region", "DE");
        user_pref("browser.search.isUS", false);
        user_pref("distribution.searchplugins.defaultLocale", "en-US");
        user_pref("general.useragent.locale", "en-US");
      '';
    };
  };
}
