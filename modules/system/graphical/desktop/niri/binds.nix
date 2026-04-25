{
  config,
  pkgs,
  lib,
  ...
}:
let
  scripts = import ./scripts.nix { inherit pkgs; };

  split = str: builtins.filter builtins.isString (builtins.split " " str);

  mkNoctaliaBind = title: cmdStr: {
    spawn._args = [
      "${lib.getExe config.pkgConfig.noctalia}"
      "ipc"
      "call"
    ]
    ++ (split cmdStr);

    _props.hotkey-overlay-title = title;
  };

  mkExecBind = title: cmdStr: {
    spawn._args = split cmdStr;
    _props.hotkey-overlay-title = title;
  };
in
{
  "XF86AudioRaiseVolume" = mkNoctaliaBind "Raise Volume" "volume increase";
  "XF86AudioLowerVolume" = mkNoctaliaBind "Lower Volume" "volume decrease";
  "XF86AudioMute" = mkNoctaliaBind "Mute Sound" "volume muteOutput";
  "XF86AudioMicMute" = mkNoctaliaBind "Mute Microphone" "volume muteInput";

  "Mod+TouchpadScrollDown" = mkNoctaliaBind "Scroll Volume Up" "volume increase";
  "Mod+TouchpadScrollUp" = mkNoctaliaBind "Scroll Volume Down" "volume decrease";

  "XF86MonBrightnessUp" = mkNoctaliaBind "Increase Brightness" "brightness increase";
  "XF86MonBrightnessDown" = mkNoctaliaBind "Decrease Brightness" "brightness decrease";

  "Mod+Shift+TouchpadScrollDown" =
    mkExecBind "Scroll Brightness Up" "${lib.getExe pkgs.brightnessctl} set 2%+";
  "Mod+Shift+TouchpadScrollUp" =
    mkExecBind "Scroll Brightness Down" "${lib.getExe pkgs.brightnessctl} set 2%-";

  "XF86RFKill" = mkNoctaliaBind "Airplane Mode" "wifi disable";
  "XF86Bluetooth" = mkNoctaliaBind "Toggle Bluetooth" "bluetooth toggle";

  "Mod+I" = mkNoctaliaBind "Open Settings" "settings toggle";

  "Mod+Q" = mkExecBind "Open Terminal" "${lib.getExe pkgs.kitty}";

  "Mod+E" = mkExecBind "Open File Manager" "${lib.getExe config.pkgConfig.nautilus}";
  "Mod+Shift+F" = mkExecBind "Open Firefox" "${lib.getExe config.pkgConfig.firefox}";
  "Mod+Shift+D" = mkExecBind "Open Zen-Browser" "${lib.getExe config.pkgConfig.zen-browser}";
  "Mod+Shift+C" = mkExecBind "Open VSCode" "${lib.getExe config.pkgConfig.vscode}";

  "Mod+F1" = mkNoctaliaBind "Toggle Cheatsheet" "plugin:keybind-cheatsheet toggle";
  "Mod+D" = mkNoctaliaBind "Application Launcher" "launcher toggle";
  "Mod+R" = mkNoctaliaBind "Command Runner" "launcher command";
  "Mod+Shift+E" = mkNoctaliaBind "Emoji Selector" "launcher emoji";
  "Mod+Shift+V" = mkNoctaliaBind "Clipboard History" "launcher clipboard";
  "Mod+X" = mkNoctaliaBind "Control Center" "controlCenter toggle";
  "Mod+P" = mkNoctaliaBind "Session Menu" "sessionMenu toggle";

  "Mod+L" = mkExecBind "Lock Screen" "${lib.getExe config.pkgConfig.hyprlock}";

  "Mod+Shift+L" = mkExecBind "Apply low resolution" "${scripts.lowRes}/bin/low-res";
  "Mod+Shift+H" = mkExecBind "Apply high resolution" "${scripts.highRes}/bin/high-res";

  "Print" = mkExecBind "Screenshot full screen" "${scripts.screenshotFull}/bin/screenshot-full";
  "Mod+Print" = mkExecBind "Screenshot region" "${scripts.screenshotRegion}/bin/screenshot-region";

  "Mod+F2" = mkExecBind "Record full screen" "${scripts.recordFull}/bin/record-full";
  "Mod+F3" = mkExecBind "Record region" "${scripts.recordRegion}/bin/record-region";
  "Mod+F4" = mkExecBind "Stop all recordings" "${scripts.recordStop}/bin/record-stop";

  "Mod+C".close-window = { };
  "Mod+H".maximize-column = { };
  "Mod+S".toggle-overview = { };

  "Mod+WheelScrollDown".focus-workspace-down = { };
  "Mod+WheelScrollUp".focus-workspace-up = { };
  "Mod+WheelScrollRight".focus-column-right = { };
  "Mod+WheelScrollLeft".focus-column-left = { };

  "Mod+Left".focus-column-or-monitor-left = { };
  "Mod+Right".focus-column-or-monitor-right = { };
  "Mod+Up".focus-window-or-workspace-up = { };
  "Mod+Down".focus-window-or-workspace-down = { };

  "Mod+Shift+Return".move-window-to-monitor-next = { };

  "Mod+Shift+Left".move-column-left-or-to-monitor-left = { };
  "Mod+Shift+Right".move-column-right-or-to-monitor-right = { };
  "Mod+Shift+Up".move-window-up-or-to-workspace-up = { };
  "Mod+Shift+Down".move-window-down-or-to-workspace-down = { };

  "Mod+V".toggle-window-floating = { };
  "Mod+F".fullscreen-window = { };
  "Mod+G".toggle-windowed-fullscreen = { };

  "Ctrl+Alt+Left".consume-or-expel-window-left = { };
  "Ctrl+Alt+Right".consume-or-expel-window-right = { };

  "Ctrl+Alt+Q".switch-preset-column-width = { };
  "Ctrl+Alt+A".switch-preset-window-height = { };
  "Ctrl+Alt+S".expand-column-to-available-width = { };

  "Mod+W".toggle-column-tabbed-display = { };

  "Mod+Shift+M" = {
    quit._props.skip-confirmation = true;
    _props.hotkey-overlay-title = "Quit Compositor";
  };
}
// builtins.foldl' (acc: elem: acc // elem) { } (
  map (i: {
    "Mod+${builtins.toString i}".focus-workspace = i;
    "Mod+Shift+${builtins.toString i}".move-column-to-workspace = i;

  }) (lib.genList (x: x) 10)
)
