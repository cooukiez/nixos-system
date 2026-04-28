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

        settings = settings.core // settings.firefoxCore // settings.firefoxExtra;
      };

      profiles.new = {
        id = 1;
        name = "new";
        isDefault = true;

        settings = settings.core // settings.firefoxCore // settings.firefoxExtra;

        extensions = {
          force = true;
          packages = with pkgs.firefox-addons; [
            (ublock-origin.overrideAttrs (old: {
              meta = old.meta // {
                license = [ ];
              };
            }))
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

        toolbarspring {
          display: none !important;
        }

        #fxa-toolbar-menu-button {
          display: none !important;
        }

        #alltabs-button {
          display: none !important;
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
