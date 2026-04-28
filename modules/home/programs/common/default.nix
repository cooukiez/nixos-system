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
    ./zathura.nix
  ];

  options.graphicalPrograms = {
    code = mkEnableDefault;
    git = mkEnableDefault;
    imv = mkEnableDefault;
    zathura = mkEnableDefault;

    kitty = mkDisableDefault;
  };

  config = {
    graphicalPrograms.kitty = lib.mkIf config.desktop.nn true;
  };
}
