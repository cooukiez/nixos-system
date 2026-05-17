/*
pkgs/default.nix

part of nixos system
created 2026-02-26 by ludw
*/
pkgs: {
  mcmojave-cursor-theme = pkgs.callPackage ./mcmojave-cursor-theme.nix {};
  steelfish-fonts = pkgs.callPackage ./steelfish-fonts.nix {};
}
