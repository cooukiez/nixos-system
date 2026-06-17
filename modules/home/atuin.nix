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

  # force atuin sync to local server
  home.sessionVariables.ATUIN_SYNC_ADDRESS = lib.mkIf cfg.enable "https://atuin.home.lan";
}
