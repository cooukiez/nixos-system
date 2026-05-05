/*
  pkgs/default.nix

  created by ludw
  on 2026-02-26
*/

pkgs: {
  mcmojave-cursor-theme = pkgs.callPackage ./mcmojave-cursor-theme.nix { };
  steelfish-fonts = pkgs.callPackage ./steelfish-fonts.nix { };
}
