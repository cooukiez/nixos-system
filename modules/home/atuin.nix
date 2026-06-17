/*
modules/home/atuin.nix

part of nixos system
created 2026-06-17 by ludw
*/
{
  config,
  lib,
  ...
}: let
  cfg = config.atuinCfg;
in {
  programs.atuin = lib.mkIf cfg.enable {
    enable = true;
    enableZshIntegration = true;

    forceOverwriteSettings = true;

    settings = {
      sync_address = "https://atuin.home.lan";
      auto_sync = true;
      sync_frequency = "5m";
      search_mode = "fuzzy";
    };
  };

  home.sessionVariables.ATUIN_SYNC_ADDRESS = lib.mkIf cfg.enable "https://atuin.home.lan";
}
