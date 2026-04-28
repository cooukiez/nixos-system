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

    zen-browser = mkDisableDefault;
  };
}
