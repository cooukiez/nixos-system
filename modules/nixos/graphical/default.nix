{
  pkgs,
  lib,
  config,
  ...
}:
let
  desktop = import ./packages.nix { inherit pkgs; };
  cfg = config.graphicalPkg;
in
{
  options.graphicalPkg = {
    core = lib.mkOption {
      type = lib.types.bool;
      default = true;
    };
    qt = lib.mkOption {
      type = lib.types.bool;
      default = true;
    };
    appmenu = lib.mkOption {
      type = lib.types.bool;
      default = true;
    };
  };

  config = {
    environment.systemPackages =
      (lib.optionals cfg.core desktop.core)
      ++ (lib.optionals cfg.qt desktop.qt)
      ++ (lib.optionals cfg.appmenu desktop.appmenu);
  };
}
