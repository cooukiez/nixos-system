/*
  pkgs/default.nix

  created by ludw
  on 2026-02-14
*/

# custom packages

pkgs:
let
  # appmenuGtkModule = pkgs.callPackage ./appmenu-gtk-module.nix {};
  heidiSql = pkgs.callPackage ./heidisql.nix { };
  hardcodeTray = pkgs.callPackage ./hardcode-tray.nix { };
in
{
  heidisql = heidiSql;
  hardcode-tray = hardcodeTray;
  # appmenu-gtk-module = appmenuGtkModule;
}
