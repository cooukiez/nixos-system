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
  settings = import ./mozilla.nix;
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
