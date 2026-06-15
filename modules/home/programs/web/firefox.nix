/*
modules/home/programs/web/firefox.nix

part of nixos system
created 2026-02-26 by ludw
*/
{
  config,
  pkgs,
  lib,
  userConfig,
  ...
}: let
  cfg = config.graphicalPrograms.firefox;
  settings = import ./config/settings.nix;
  extensions = import ./config/extensions.nix;

  hasPasswordManager = name: builtins.elem name (userConfig.passwordManagers or []);
in {
  config = lib.mkIf cfg {
    programs.firefox = {
      enable = true;
      package = pkgs.firefox;

      profiles.default = {
        id = 0;
        name = "default";
        isDefault = true;

        search = import ./config/search.nix {inherit pkgs;};

        settings =
          settings.core
          // settings.firefoxCore
          // {
            # hides window buttons
            "browser.tabs.drawInTitlebar" = true;

            "browser.compactmode.show" = true;
            "browser.uidensity" = 0;

            # sidebar disable chatbot
            "browser.ml.chat.enabled" = false;
            "browser.ml.chat.sidebar" = false;

            # bookmarks toolbar
            "browser.toolbars.bookmarks.visibility" = "newtab";

            "browser.newtabpage.activity-stream.discoverystream.endpointSpocsClear" = "";
            "browser.newtabpage.activity-stream.discoverystream.endpoints" = "";

            "browser.newtabpage.activity-stream.default.sites" = "";
            "browser.newtabpage.pinned" = builtins.toJSON [];

            "browser.uiCustomization.state" = builtins.toJSON {
              placements = {
                "widget-overflow-fixed-list" = [];

                "unified-extensions-area" = map (x: x.action) (builtins.attrValues extensions.extensions);

                "nav-bar" =
                  [
                    "back-button"
                    "forward-button"
                    "stop-reload-button"
                    "vertical-spacer"
                    "urlbar-container"
                    "downloads-button"
                    "unified-extensions-button"
                  ]
                  ++ map (x: x.action) (builtins.attrValues extensions.extNavBar)
                  ++ lib.optional (hasPasswordManager "bitwarden") extensions.extOptional.bitwarden-password-manager.action
                  ++ lib.optional (hasPasswordManager "passbolt") extensions.extOptional.passbolt.action;

                "toolbar-menubar" = [
                  "menubar-items"
                ];

                "TabsToolbar" = [
                  "firefox-view-button"
                  "tabbrowser-tabs"
                  "new-tab-button"
                ];

                "vertical-tabs" = [];

                "PersonalToolbar" = [
                  "personal-bookmarks"
                ];
              };

              seen =
                [
                  "developer-button"
                  "screenshot-button"
                ]
                ++ map (x: x.action) (builtins.attrValues extensions.extensions)
                ++ map (x: x.action) (builtins.attrValues extensions.extNavBar)
                ++ lib.optional (hasPasswordManager "bitwarden") extensions.extOptional.bitwarden-password-manager.action
                ++ lib.optional (hasPasswordManager "passbolt") extensions.extOptional.passbolt.action;

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
          packages = let
            getAddons = attrs: map (name: pkgs.firefox-addons.${name}) (builtins.attrNames attrs);

            unlicense = pkg:
              pkg.overrideAttrs (old: {
                meta =
                  (old.meta or {})
                  // {
                    license = [];
                  };
              });
          in
            with pkgs.firefox-addons;
              map unlicense (
                [
                  reddit-ad-remover
                  return-youtube-dislikes
                ]
                ++ getAddons extensions.extensions
                ++ getAddons extensions.extNavBar
                ++ lib.optionals (hasPasswordManager "bitwarden") [bitwarden-password-manager]
                ++ lib.optionals (hasPasswordManager "passbolt") [passbolt]
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
  };
}
