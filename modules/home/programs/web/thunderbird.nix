/*
  modules/home/programs/web/thunderbird.nix

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
  cfg = config.graphicalPrograms.thunderbird;
  settings = import ./settings.nix;
in
{
  config = lib.mkIf cfg {
    programs.thunderbird = {
      enable = true;
      package = pkgs.unstable.thunderbird;

      profiles.default = {
        isDefault = true;

        settings = settings.core // {
          "mail.biff.play_sound" = false;
        };

        userChrome = ''
          .titlebar-buttonbox-container {
            display: none !important;
          }

          .titlebar-spacer {
            display: none !important;
          }
        '';
      };
    };
  };
}
