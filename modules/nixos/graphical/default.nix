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
  imports = [
    ./programs.nix
  ];

  options.graphicalConfig = {
    corePkg = mkEnableDefault;
    qtPkg = mkEnableDefault;
    appmenuPkg = mkEnableDefault;
    compatibilityPkg = mkEnableDefault;

    gnomeSupport = mkEnableDefault;
  };

  config = lib.mkMerge [
    {
      environment.systemPackages =
        (lib.optionals cfg.corePkg desktop.core)
        ++ (lib.optionals cfg.qtPkg desktop.qt)
        ++ (lib.optionals cfg.appmenuPkg desktop.appmenu)
        ++ (lib.optionals cfg.compatibilityPkg desktop.compatibility);
    }

    (lib.mkIf cfg.gnomeSupport {
      programs.dconf.enable = true;
      services.gvfs.enable = true;

      services.gnome.evolution-data-server.enable = true;
      services.gnome.tinysparql.enable = true;
      services.gnome.localsearch.enable = true;
    })
  ];
}
