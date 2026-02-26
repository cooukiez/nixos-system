/*
  pkgs/default.nix

  created by ludw
  on 2026-02-23
*/

# custom packages

pkgs:
let
  # appmenuGtkModule = pkgs.callPackage ./appmenu-gtk-module.nix {};
  heidiSql = pkgs.callPackage ./heidisql.nix { };
  hardcodeTray = pkgs.callPackage ./hardcode-tray.nix { };
  mcMojaveCursorTheme = pkgs.callPackage ./mcmojave-cursor-theme.nix { };
  steelFishFonts = pkgs.callPackage ./steelfish-fonts.nix { };
in
{
  # appmenu-gtk-module = appmenuGtkModule;
  heidisql = heidiSql;
  hardcode-tray = hardcodeTray;
  mcmojave-cursor-theme = mcMojaveCursorTheme;
  steelfish-fonts = steelFishFonts;
}
