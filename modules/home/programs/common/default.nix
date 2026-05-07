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
    ./nemo.nix
    ./zathura.nix
  ];

  options.graphicalPrograms = {
    code = mkEnableDefault;
    git = mkEnableDefault;
    imv = mkEnableDefault;
    zathura = mkEnableDefault;

    kitty = mkDisableDefault;
    nemo = mkDisableDefault;
  };

  config = {
    graphicalPrograms.kitty = lib.mkIf config.desktop.nn true;
    graphicalPrograms.nemo = lib.mkIf config.desktop.nn true;
  };
}
