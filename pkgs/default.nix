/*
  pkgs/default.nix

  created by ludw
  on 2026-02-23
*/

# custom packages

pkgs:
let
  # appmenuGtkModule = pkgs.callPackage ./appmenu-gtk-module.nix {};
  hardcodeTray = pkgs.callPackage ./hardcode-tray.nix { };
  heidiSql = pkgs.callPackage ./heidisql.nix { };
  mcMojaveCursorTheme = pkgs.callPackage ./mcmojave-cursor-theme.nix { };
  steelFishFonts = pkgs.callPackage ./steelfish-fonts.nix { };
in
{
  # appmenu-gtk-module = appmenuGtkModule;
  hardcode-tray = hardcodeTray;
  heidisql = heidiSql;
  mcmojave-cursor-theme = mcMojaveCursorTheme;
  steelfish-fonts = steelFishFonts;
}
