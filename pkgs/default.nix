/*
  pkgs/default.nix

  created by ludw
  on 2026-02-26
*/

# custom packages

pkgs:
let
  # appmenuGtkModule = pkgs.callPackage ./appmenu-gtk-module.nix {};
  hardcodeTrayPkg = pkgs.callPackage ./hardcode-tray.nix { };
  heidisqlPkg = pkgs.callPackage ./heidisql.nix { };
  mcMojaveCursorThemePkg = pkgs.callPackage ./mcmojave-cursor-theme.nix { };
  steelFishFontsPkg = pkgs.callPackage ./steelfish-fonts.nix { };
in
{
  # appmenu-gtk-module = appmenuGtkModule;
  hardcode-tray = hardcodeTrayPkg;
  heidisql = heidisqlPkg;
  mcmojave-cursor-theme = mcMojaveCursorThemePkg;
  steelfish-fonts = steelFishFontsPkg;
}
