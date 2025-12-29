# add reusable nixos modules to this directory, on their own file (https://nixos.wiki/wiki/Module)
# these should be stuff you would like to share with others, not your personal configurations
{ pkgs, ... }: {
  # list your module files here
  common = import ./common;
  desktop = import ./desktop;
  programs = import ./programs;
}