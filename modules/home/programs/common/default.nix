/*
  modules/home/programs/common/default.nix

  part of nixos system
  created 2026-04-27
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
    ./vscode
    ./zed

    ./git.nix
    ./imv.nix
    ./kitty.nix
    ./nemo.nix
    ./zathura.nix
  ];

  options.graphicalPrograms = {
    git = mkEnableDefault;
    imv = mkEnableDefault;
    vscode = mkEnableDefault;
    zathura = mkEnableDefault;
    zedEditor = mkEnableDefault;

    kitty = mkDisableDefault;
    nemo = mkDisableDefault;
  };

  config = {
    graphicalPrograms.kitty = lib.mkIf config.desktop.nn true;
    graphicalPrograms.nemo = lib.mkIf config.desktop.nn true;
  };
}
