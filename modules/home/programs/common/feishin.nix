{
  config,
  pkgs,
  ...
}:
let
  cfg = config.graphicalPrograms.feishin;

  feishinConfig = {
    disable_auto_updates = true;

    "__internal__" = {
      migrations = {
        version = "1.7.0";
      };
    };

    playbackType = "web";
    mediaSession = false;
    global_media_hotkeys = true;

    should_prompt_accessibility = false;
    shown_accessibility_warning = false;

    window_enable_tray = true;
    window_exit_to_tray = false;
    window_minimize_to_tray = true;
    window_start_minimized = false;

    window_window_bar_style = "linux";
    window_has_frame = false;
    bounds = {
      x = 0;
      y = 0;
      width = 1890;
      height = 1136;
    };

    maximized = false;
    fullscreen = false;

    theme = "dark";
    server = { };

    # lyrics
    lyrics = [
      "NetEase"
      "lrclib.net"
    ];

    enableNeteaseTranslation = false;
  };

  configFile = pkgs.writeText "feishin-config-template.json" (builtins.toJSON feishinConfig);
in
{
  config = lib.mkIf cfg {
    home.activation.copyFeishinConfig = config.lib.dag.entryAfter [ "writeBoundary" ] ''
      CONFIG_DIR="$HOME/.config/feishin"
      CONFIG_PATH="$CONFIG_DIR/config.json"

      mkdir -p "$CONFIG_DIR"

      if [ ! -f "$CONFIG_PATH" ]; then
          cp ${configFile} "$CONFIG_PATH"
          chmod 644 "$CONFIG_PATH"
      fi
    '';
  };
}
