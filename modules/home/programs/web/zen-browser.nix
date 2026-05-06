/*
  modules/home/programs/web/zen-browser.nix

  created by ludw
  on 2026-02-26
*/

{
  inputs,
  config,
  pkgs,
  pkgConfig,
  lib,
  hostConfig,
  userConfig,
  ...
}:
let
  cfg = config.graphicalPrograms.zen-browser;
  settings = import ./settings.nix;

  genId = name: builtins.hashString "sha256" name;
in
{
  imports = [
    inputs.zen-browser.homeModules.twilight
  ];

  config = lib.mkIf cfg {

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
        pins =
          let
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
            }) names
          );
      in
      {
        enable = true;
        package = pkgConfig.zen-browser;

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

          settings =
            settings.core
            // settings.firefoxCore
            // {
              # restore pins to original URL, not last visited
              "zen.pinned-tab-manager.restore-pinned-tabs-to-pinned-url" = true;

              # show essential pins in all workspaces
              "zen.workspaces.separate-essentials" = false;

              # restore workspaces / tabs from previous session
              "zen.workspaces.continue-where-left-off" = true;
            };

          # see https://github.com/0xc000022070/zen-browser-flake#search
          search = {
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
  };
}
