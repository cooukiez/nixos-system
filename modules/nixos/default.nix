/*
  modules/nixos/default.nix

  created by ludw
  on 2026-01-29
*/

# add reusable nixos modules to this directory, on their own file (https://nixos.wiki/wiki/Module)
# these should be stuff you would like to share with others, not your personal configurations
{
  # list your module files here
  common = import ./common;
  desktop = import ./desktop;
  programs = import ./programs;
}
