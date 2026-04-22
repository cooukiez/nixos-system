{
  config,
  pkgs,
  lib,
  hostConfig,
  ...
}:
let
  desktop = import ./packages.nix { inherit pkgs hostConfig; };
  cfg = config.graphicalConfig;

  mkEnableDefault = lib.mkOption {
    type = lib.types.bool;
    default = true;
  };
in
{
  imports = [
    ./media
    ./web

    ./display.nix
    ./fonts.nix
    ./programs.nix
    ./session.nix
  ];

  options.graphicalConfig = {
    appmenuPkg = mkEnableDefault;
    compatibilityPkg = mkEnableDefault;
    corePkg = mkEnableDefault;
    qtPkg = mkEnableDefault;

    fontsPkg = mkEnableDefault;

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
