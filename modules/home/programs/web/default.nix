/*
modules/home/programs/web/default.nix

part of nixos system
created 2026-06-16 by ludw
*/
{lib, ...}: let
  mkEnableDefault = lib.mkOption {
    type = lib.types.bool;
    default = true;
  };
in {
  imports = [
    ./element.nix
    ./firefox.nix
    ./thunderbird.nix
    ./zen-browser.nix
  ];

  options.graphicalPrograms = {
    element = mkEnableDefault;
    firefox = mkEnableDefault;
    thunderbird = mkEnableDefault;
    zen-browser = mkEnableDefault;
  };
}
