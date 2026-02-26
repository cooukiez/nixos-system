/*
  modules/home/programs/web/zen-browser.nix

  created by ludw
  on 2026-02-23
*/

{
  config,
  inputs,
  pkgs,
  hostSystem,
  ...
}:
{
  # see https://github.com/0xc000022070/zen-browser-flake
  programs.zen-browser =
    let
      containers = {
        Personal = {
          color = "purple";
          icon = "fingerprint";
          id = 1;
        };
        Work = {
          color = "blue";
          icon = "briefcase";
          id = 2;
        };
        Shopping = {
          color = "yellow";
          icon = "cart";
          id = 3;
        };
      };

      # see https://github.com/0xc000022070/zen-browser-flake?tab=readme-ov-file#spaces
      spaces = {
        "Space" = {
          id = "7057f3dc-2c44-4777-b967-ca03cc6da12f";
          position = 1000;
        };

        "Work" = {
          id = "5307ca30-2ffc-4beb-8b10-7e265630a9f7";
          icon = "💼";
          container = containers.Work.id;
          position = 2000;
        };

        "Shopping" = {
          id = "abc85490-f3a3-4767-b290-bf4016592431";
          icon = "🛒";
          container = containers.Shopping.id;
          position = 3000;
        };
      };

      # see https://github.com/0xc000022070/zen-browser-flake#pinned-tabs-pins
      pins = {
        "youtube" = {
          id = "9d8a8f91-7e29-4688-ae2e-da4e49d4a179";
          container = containers.Personal.id;
          url = "https://www.youtube.com/";
          isEssential = true;
          position = 101;
        };

        "chatgpt" = {
          id = "c93f0c08-6866-40da-940b-b5cd509d6295";
          container = containers.Personal.id;
          url = "https://chatgpt.com/";
          isEssential = true;
          position = 102;
        };

        "maps" = {
          id = "43cfa3ce-d40c-4ca7-a390-313e122ce120";
          container = containers.Personal.id;
          url = "https://www.google.com/maps";
          isEssential = true;
          position = 103;
        };
      };

    in
    {
      enable = true;
      package = inputs.zen-browser.packages.${hostSystem}.twilight;

      policies = {
        AutofillAddressEnabled = true;
        AutofillCreditCardEnabled = false;

        DisableAppUpdate = true;
        DisableFeedbackCommands = true;
        DisableFirefoxStudies = true;
        DisablePocket = true;
        DisableTelemetry = true;

        DontCheckDefaultBrowser = true;

        NoDefaultBookmarks = true;
        OfferToSaveLogins = false;

        EnableTrackingProtection = {
          Value = true;
          Locked = true;
          Cryptomining = true;
          Fingerprinting = true;
        };
      };

      nativeMessagingHosts = [
        pkgs.firefoxpwa
        pkgs.kdePackages.plasma-browser-integration
      ];

      profiles.default = {
        id = 0;
        name = "default";
        isDefault = true;

        containersForce = true;
        spacesForce = true;
        pinsForce = true;

        inherit containers spaces pins;

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

          # restore pins to original URL, not last visited
          "zen.pinned-tab-manager.restore-pinned-tabs-to-pinned-url" = true;
          # show essential pins in all workspaces
          "zen.workspaces.separate-essentials" = false;
          # restore workspaces/tabs from previous session
          "zen.workspaces.continue-where-left-off" = true;

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

            nixpkgs = {
              name = "NixOS Search - Packages";
              urls = [
                {
                  template = "https://search.nixos.org/packages?channel=unstable&query={searchTerms}";
                  params = [
                    {
                      name = "query";
                      value = "searchTerms";
                    }
                  ];
                }
              ];

              icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
              definedAliases = [ "@np" ];
            };
          };
        };
      };
    };
}
