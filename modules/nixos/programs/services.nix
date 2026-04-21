/*
  modules/nixos/programs/services.nix

  created by ludw
  on 2026-02-26
*/

{
  pkgs,
  ...
}:
{
  # location services
  services.locate.enable = true;
  # enable firmware update services
  services.fwupd.enable = true;
  # enable devmon for device management
  services.devmon.enable = true;
  # network statistics
  services.vnstat.enable = true;

  # running gnome apps outside of gnome
  programs.dconf.enable = true;
  services.gvfs.enable = true;

  # gnome calendar support
  services.gnome.evolution-data-server.enable = true;
  services.gnome.tinysparql.enable = true;
  services.gnome.localsearch.enable = true;
}
