/*
  modules/home-manager/default.nix

  created by ludw
  on 2026-01-29
*/

{
  # list module files here
  desktop-noctalia = import ./desktop/noctalia;
  desktop-kde = import ./desktop/kde;
  programs = import ./programs;
}
