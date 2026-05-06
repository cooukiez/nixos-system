/*
  modules/home/programs/web/default.nix

  created by ludw
  on 2026-02-26
*/

{
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
    ./firefox.nix
    ./thunderbird.nix
    ./zen-browser.nix
  ];

  options.graphicalPrograms = {
    firefox = mkEnableDefault;
    thunderbird = mkEnableDefault;
    zen-browser = mkEnableDefault;
  };
}
