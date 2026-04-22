/*
  modules/home/default.nix

  created by ludw
  on 2026-02-26
*/

{
  desktopKDE = import ./desktop/kde;
  desktopNN = import ./desktop/nn;

  programs = import ./programs;
}
