{
  config,
  pkgs,
  pkgConfig,
  lib,
  ...
}:
let
  cfg = config.graphicalPrograms.zedEditor;
in
{
  config = lib.mkIf cfg {
    programs.zed-editor = {
      enable = true;
      package = pkgConfig.zedEditor;

      extensions = [
        "nix"
        "rust"
        "toml"
      ];

      userSettings = {
        disable_ai = true;
        features = {
          edit_prediction_provider = "none";
        };

        language_models = { };

        autosave = "on_window_change";
        vim_mode = false;

        telemetry = {
          diagnostics = false;
          metrics = false;
        };
      };
    };
  };
}
