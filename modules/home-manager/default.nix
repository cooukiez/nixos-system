/*
  modules/home-manager/default.nix

  created by ludw
  on 2026-01-25
*/

# add reusable home-manager modules to this directory, on their own file (https://nixos.wiki/wiki/Module)
# these should be stuff you would like to share with others, not your personal configurations
{
  # list your module files here
  # my-module = import ./my-module.nix;

  desktop-noctalia = import ./desktop/noctalia;
  desktop-kde = import ./desktop/kde;
  programs = import ./programs;
}
