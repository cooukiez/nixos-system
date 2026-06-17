/*
modules/home/programs/common/zed/default.nix

part of nixos system
created 2026-06-16 by ludw
*/
{
  config,
  pkgConfig,
  lib,
  ...
}: let
  cfg = config.graphicalPrograms.zedEditor;
in {
  config = lib.mkIf cfg {
    programs.zed-editor = {
      enable = true;
      package = pkgConfig.zedEditor;

      extensions = [
        "nix"
        "powershell"
        "rust"
        "toml"
      ];

      userSettings = {
        disable_ai = true;

        show_welcome_guide = false;

        theme = "Ayu Dark";

        buffer_font_family = lib.mkForce "JetBrainsMono Nerd Font Mono";
        buffer_font_size = lib.mkForce 16;
        ui_font_size = lib.mkForce 16;

        title_bar = {
          show_sign_in = false;
        };

        mouse_wheel_zoom = true;

        language_models = {};

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
