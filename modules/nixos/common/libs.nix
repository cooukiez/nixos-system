/*
  modules/nixos/common/libs.nix

  created by ludw
  on 2026-02-26
*/

{
  pkgs,
  ...
}:
{
  # java support
  programs.java.enable = true;

  environment.systemPackages = with pkgs; [
    # general tools / libraries, sorted alphabetically
    cairo
    fontconfig
    fontforge
    freetype
    icu
    leptonica
    mariadb
    pandoc
    pango
    zlib
  ];
}
