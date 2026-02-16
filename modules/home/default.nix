/*
  modules/home/default.nix

  created by ludw
  on 2026-02-16
*/

{
  # list module files here

  # kde plasma desktop
  desktop-kde = import ./desktop/kde;

  # noctalia / niri desktop
  desktop-nn = import ./desktop/nn;

  programs = import ./programs;
}
