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
  settings = import ./config/settings.nix;

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

          Public = {
            color = "turqoise";
            icon = "glasses";
            id = 2;
          };

          Media = {
            color = "blue";
            icon = "briefcase";
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
          "Personal" = {
            id = "532b719b-1f82-45c8-9644-6baf4e034c76";
            icon = "🫆";
            container = containers.Personal.id;
            position = 1000;
          };

          "Space" = {
            id = "7057f3dc-2c44-4777-b967-ca03cc6da12f";
            position = 2000;
          };

          "Public" = {
            id = "0e008614-d063-4847-95ba-0ea4418939a6";
            icon = "🌍";
            container = containers.Public.id;
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
              "zen.welcome-screen.seen" = true;
              "doh-rollout.doneFirstRun" = true;
              "app.normandy.first_run" = false;

              "zen.view.hide-window-controls" = true;
              "zen.view.experimental-no-window-controls" = true;

              "zen.watermark.enabled" = false;

              # restore pins to original url
              "zen.pinned-tab-manager.restore-pinned-tabs-to-pinned-url" = true;

              # show essential pins in all workspaces
              "zen.workspaces.separate-essentials" = false;

              "zen.view.compact.enable-at-startup" = false;
              "zen.ui.migration.compact-mode-button-added" = true;

              # restore workspace tabs
              "zen.workspaces.continue-where-left-off" = true;
            };

          search = import ./config/search.nix { inherit pkgs; };
        };
      };
  };
}
