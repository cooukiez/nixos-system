/*
  modules/home/programs/web/firefox.nix

  created by ludw
  on 2026-02-26
*/

{
  config,
  pkgs,
  lib,
  userConfig,
  ...
}:
let
  cfg = config.graphicalPrograms.firefox;
  settings = import ./settings.nix;

  hasPasswordManager = name: builtins.elem name (userConfig.passwordManagers or [ ]);

  mkAction = extID: extID + "-browser-action";

  extensions = {
    duckduckgo-for-firefox = mkAction "jid1-zadieub7xozojw_jetpack";
    floccus = mkAction "floccus_handmadeideas_org";

    darkreader = mkAction "addon_darkreader_org";

    clearurls = mkAction "clearurls_kevin_roebert";
    i-dont-want-cookies = mkAction "_1d048372-7ac6-4292-b9ad-6cc53f399513_";

    sink-it-for-reddit = mkAction "_09acf9ff-55d4-4366-a1a9-c9b3c8877c09_";

    sponsorblock = mkAction "sponsorblocker_ajay_app";
    spot-sponsorblock = mkAction "sponsorblocker_spotsponsorblock_org";

    youtube-recommended-videos = mkAction "myallychou_gmail_com";

    violentmonkey = mkAction "_aecec67f-0d10-4fa7-b7c7-609a2db280cf_";
  };

  extNavBar = {
    ublock-origin = mkAction "ublock0_raymondhill_net";
  };

  extOptional = {
    bitwarden-password-manager = mkAction "_446900e4-71c2-419f-a6a7-df9c091e268b_";
    passbolt = mkAction "passbolt_passbolt_com";

    single-file = mkAction "_531906d3-e22f-4a6c-a102-8057b88a1a63_";

    privacy-badger17 = mkAction "jid1-mnnxcxisbpnsxq_jetpack";
    decentraleyes = mkAction "jid1-bofifl9vbdl2zq_jetpack";
  };
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

      profiles.test = {
        id = 2;
        name = "test";
        isDefault = false;

        settings = settings.core // settings.firefoxCore;
      };

      profiles.new = {
        id = 1;
        name = "new";
        isDefault = true;

        search = {
          force = true;
          default = "ddg";
          privateDefault = "ddg";

          order = [
            "ddg"
            "google"
          ];

          engines = {
            ddg = {
              name = "DuckDuckGo";
              urls = [
                {
                  template = "https://duckduckgo.com/?q={searchTerms}";
                }
              ];

              icon = "https://duckduckgo.com/favicon.ico";
              definedAliases = [ "@ddg" ];
            };

            nix-packages = {
              name = "Nix Packages";
              urls = [
                {
                  template = "https://search.nixos.org/packages";
                  params = [
                    {
                      name = "type";
                      value = "packages";
                    }
                    {
                      name = "query";
                      value = "{searchTerms}";
                    }
                  ];
                }
              ];

              icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
              definedAliases = [ "@np" ];
            };

            mynixos = {
              name = "MyNixOS";
              urls = [
                {
                  template = "https://mynixos.com/search?q={searchTerms}";
                }
              ];

              icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
              definedAliases = [ "@mn" ];
            };

            nixos-wiki = {
              name = "NixOS Wiki";
              urls = [
                {
                  template = "https://wiki.nixos.org/w/index.php?search={searchTerms}";
                }
              ];

              icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
              definedAliases = [ "@nw" ];
            };

            google.metaData.hidden = true;
            bing.metaData.hidden = true;
            ecosia.metaData.hidden = true;
            perplexity.metaData.hidden = true;
          };
        };

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

                "unified-extensions-area" = builtins.attrValues extensions;

                "nav-bar" = [
                  "back-button"
                  "forward-button"
                  "stop-reload-button"
                  "vertical-spacer"
                  "urlbar-container"
                  "downloads-button"
                  "unified-extensions-button"
                ]
                ++ builtins.attrValues extNavBar
                ++ lib.optional (hasPasswordManager "bitwarden") extOptional.bitwarden-password-manager
                ++ lib.optional (hasPasswordManager "passbolt") extOptional.passbolt;

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
              ]
              ++ builtins.attrValues extensions
              ++ builtins.attrValues extNavBar
              ++ lib.optional (hasPasswordManager "bitwarden") extOptional.bitwarden-password-manager
              ++ lib.optional (hasPasswordManager "passbolt") extOptional.passbolt;

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
              getAddons = attrs: map (name: pkgs.firefox-addons.${name}) (builtins.attrNames attrs);

              unlicense =
                pkg:
                pkg.overrideAttrs (old: {
                  meta = (old.meta or { }) // {
                    license = [ ];
                  };
                });
            in
            with pkgs.firefox-addons;
            map unlicense (
              [
                reddit-ad-remover
                return-youtube-dislikes
              ]
              ++ getAddons extensions
              ++ getAddons extNavBar
              ++ lib.optionals (hasPasswordManager "bitwarden") [ bitwarden-password-manager ]
              ++ lib.optionals (hasPasswordManager "passbolt") [ passbolt ]
            );
        };

        userChrome = ''
          /* remove close button */
          .titlebar-buttonbox-container {
            display:none
          }
        '';
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
