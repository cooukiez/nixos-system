/*
  modules/home/desktop/kde/plasma/default.nix

  created by ludw
  on 2026-02-26
*/

{
  pkgs,
  ...
}:
let

in
{
  home.file.".local/share/icons/Breeze-Chameleon-Dark" = {
    source = breezeChameleonDark;
    recursive = true;
  };
}
