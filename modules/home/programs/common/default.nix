/*
  modules/home/programs/common/default.nix

  created by ludw
  on 2026-04-27
*/

{
  config,
  lib,
  ...
}:
let
  mkEnableDefault = lib.mkOption {
    type = lib.types.bool;
    default = true;
  };

  mkDisableDefault = lib.mkOption {
    type = lib.types.bool;
    default = false;
  };
in
{
  imports = [
    ./code

    ./git.nix
    ./imv.nix
    ./kitty.nix
    ./obsidian.nix
    ./zathura.nix
  ];

  options.graphicalPrograms = {
    code = mkEnableDefault;
    git = mkEnableDefault;
    imv = mkEnableDefault;
    obsidian = mkEnableDefault;
    zathura = mkEnableDefault;

    kitty = mkDisableDefault;
  };

  config = {
    graphicalPrograms.kitty = lib.mkIf config.desktop.nn true;
  };
}
