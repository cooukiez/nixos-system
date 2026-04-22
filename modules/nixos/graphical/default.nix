{
  pkgs,
  lib,
  config,
  ...
}:
let
  desktop = import ./packages.nix { inherit pkgs; };
  cfg = config.graphicalConfig;

  mkEnableDefault = lib.mkOption {
    type = lib.types.bool;
    default = true;
  };
in
{
  options.graphicalConfig = {
    corePkg = mkEnableDefault;
    qtPkg = mkEnableDefault;
    appmenuPkg = mkEnableDefault;
  };

  config = {
    environment.systemPackages =
      (lib.optionals cfg.corePkg desktop.core)
      ++ (lib.optionals cfg.qtPkg desktop.qt)
      ++ (lib.optionals cfg.appmenuPkg desktop.appmenu);
  };
}
