/*
  modules/nixos/programs/services.nix

  created by ludw
  on 2026-01-29
*/

{
  # printing services
  services.printing.enable = true;
  # location services
  services.locate.enable = true;
  # enable firmware update services
  services.fwupd.enable = true;
  # enable devmon for device management
  services.devmon.enable = true;
  # network statistics
  services.vnstat.enable = true;
}
