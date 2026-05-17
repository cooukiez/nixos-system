/*
modules/home/programs/web/zen-browser.nix

part of nixos system
created 2026-02-26 by ludw
*/
{
  inputs,
  config,
  pkgs,
  pkgConfig,
  lib,
  userConfig,
  ...
}: let
  cfg = config.graphicalPrograms.zen-browser;
  settings = import ./config/settings.nix;
  extensions = import ./config/extensions.nix;

  genId = name: builtins.hashString "sha256" name;

  hasPasswordManager = name: builtins.elem name (userConfig.passwordManagers or []);
in {
  imports = [
    inputs.zen-browser.homeModules.twilight
  ];

  config = lib.mkIf cfg {
    # see https://github.com/0xc000022070/zen-browser-flake
    programs.zen-browser = let
      containers = {
        Personal = {
          color = "purple";
          icon = "fingerprint";
          id = 1;
        };

        Work = {
          color = "red";
          icon = "briefcase";
          id = 2;
        };

        Media = {
          color = "blue";
          icon = "chill";
          id = 3;
        };

        Banking = {
          color = "green";
          icon = "dollar";
          id = 4;
        };

        Shopping = {
          color = "yellow";
          icon = "cart";
          id = 5;
        };

        Google = {
          color = "red";
          icon = "fence";
          id = 6;
        };

        Facebook = {
          color = "blue";
          icon = "fence";
          id = 7;
        };
      };

      # see https://github.com/0xc000022070/zen-browser-flake?tab=readme-ov-file#spaces
      spaces = {
        "Space" = {
          id = "7057f3dc-2c44-4777-b967-ca03cc6da12f";
          position = 1000;
        };

        "Personal" = {
          id = "532b719b-1f82-45c8-9644-6baf4e034c76";
          icon = "🫆";
          container = containers.Personal.id;
          position = 2000;
        };

        "Work" = {
          id = "0e008614-d063-4847-95ba-0ea4418939a6";
          icon = "💼";
          container = containers.Work.id;
          position = 3000;
        };
      };

      # see https://github.com/0xc000022070/zen-browser-flake#pinned-tabs-pins
      pins = let
        names = builtins.attrNames userConfig.zenBrowserShortcuts;
      in
        builtins.listToAttrs (
          lib.imap0 (i: name: {
            inherit name;
            value = {
              url = userConfig.zenBrowserShortcuts.${name};

              id = genId name;
              position = i + 100;
              container = containers.Personal.id;
              isEssential = true;
            };
          })
          names
        );
    in {
      enable = true;
      package = pkgConfig.zen-browser;

      nativeMessagingHosts = [
        pkgs.kdePackages.plasma-browser-integration
      ];

      profiles.default = {
        id = 0;
        name = "default";
        isDefault = true;

        search = import ./config/search.nix {inherit pkgs;};

        containersForce = true;
        spacesForce = true;
        pinsForce = true;

        inherit containers spaces pins;

        settings =
          settings.core
          // settings.firefoxCore
          // {
            "zen.welcome-screen.seen" = true;
            "doh-rollout.doneFirstRun" = true;
            "app.normandy.first_run" = false;

            "zen.view.hide-window-controls" = true;
            "zen.view.experimental-no-window-controls" = true;

            "zen.view.use-single-toolbar" = false;

            "zen.watermark.enabled" = false;

            # restore pins to original url
            "zen.pinned-tab-manager.restore-pinned-tabs-to-pinned-url" = true;

            # show essential pins in all workspaces
            "zen.workspaces.separate-essentials" = false;

            "zen.view.compact.enable-at-startup" = false;
            "zen.ui.migration.compact-mode-button-added" = true;

            # restore workspace tabs
            "zen.workspaces.continue-where-left-off" = true;

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
                  "tabbrowser-tabs"
                ];

                "vertical-tabs" = [];

                "PersonalToolbar" = [
                  "personal-bookmarks"
                ];

                "zen-sidebar-top-buttons" = [
                  "zen-toggle-compact-mode"
                ];

                "zen-sidebar-foot-buttons" = [
                  "downloads-button"
                  "zen-workspaces-button"
                  "zen-create-new-button"
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
                "zen-sidebar-foot-buttons"
                "PersonalToolbar"
                "toolbar-menubar"
                "TabsToolbar"
                "zen-sidebar-top-buttons"
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
      };
    };
  };
}
