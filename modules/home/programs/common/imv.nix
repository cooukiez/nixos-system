/*
  modules/home/programs/common/imv.nix

  part of nixos system
  created 2026-02-26 by ludw
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
