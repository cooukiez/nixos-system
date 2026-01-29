/*
  pkgs/default.nix

  created by ludw
  on 2026-01-29
*/

# custom packages

pkgs:
let
  # appmenuGtkModule = pkgs.callPackage ./appmenu-gtk-module.nix {};
  hardcodeTray = pkgs.callPackage ./hardcode-tray.nix { };
in
{
  hardcode-tray = hardcodeTray;
  # appmenu-gtk-module = appmenuGtkModule;
}
