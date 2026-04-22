/*
  configuration.nix

  created by ludw
  on 2026-02-26
*/

# system configuration file

{
  inputs,
  config,
  pkgs,
  lib,
  hostname,
  dnsServers,
  users,
  ...
}:
{

  # user configuration

  # see https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "25.11";
}
