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

        buffer_font_family = lib.mkForce "JetBrainsMono Nerd Font Mono";
        buffer_font_size = lib.mkForce 12;

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
