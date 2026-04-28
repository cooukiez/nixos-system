/*
  modules/home/programs/imv.nix

  created by ludw
  on 2026-02-26
*/

{
  config,
  lib,
  ...
}:
let
  cfg = config.graphicalPrograms.imv;
in
{
  config = lib.mkIf cfg {
    programs.imv = {
      enable = true;

      settings = {
        options = {
          overlay_font = "JetBrainsMono Nerd Font:10";
          upscaling_method = "linear";
        };
      };
    };
  };
}
